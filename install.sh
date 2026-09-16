#!/bin/bash
set -euo pipefail

REPO="${CARAMBA_RELEASE_REPOSITORY:-semanticparadox/caramba-project}"
if [[ ! "$REPO" =~ ^[A-Za-z0-9_.-]+/[A-Za-z0-9_.-]+$ || "$REPO" == */.. || "$REPO" == ../* || "$REPO" == */. || "$REPO" == ./* ]]; then
  echo "Invalid CARAMBA_RELEASE_REPOSITORY: expected owner/repository."
  exit 1
fi
export CARAMBA_RELEASE_REPOSITORY="$REPO"
INSTALL_BIN_DIR="${CARAMBA_INSTALL_BIN_DIR:-/usr/local/bin}"
INSTALLER_ASSET="caramba-installer"
INSTALL_DIR="/opt/caramba"
INSTALL_DIR_SET=0
UPGRADE=0
NO_RESTART=0

ROLE="hub"
DOMAIN=""
SUB_DOMAIN=""
ADMIN_PATH=""
DB_PASS=""
PANEL_URL=""
TOKEN=""
NODE_TYPE="exit"
REGION="global"
LISTEN_PORT="8080"
BOT_TOKEN=""
PANEL_TOKEN=""
VERSION_OVERRIDE=""

usage() {
  cat <<'EOF'
Usage:
  install.sh [options]

Roles:
  --role hub       Install hub (panel + sub; optional bot/node)
  --role panel     Install panel only
  --role node      Install node
  --role agent     Alias for node
  --role sub       Install sub/frontend edge
  --role frontend  Alias for sub
  --role bot       Install bot

Common options:
  --upgrade                Refresh the installer, then upgrade an existing installation
  --no-restart             With --upgrade, leave service restarts to the operator
  --install-dir <dir>       Default: /opt/caramba
  --version <tag>           Force release tag (v0.9.98 or newer)

Hub/panel options:
  --domain <domain>
  --sub-domain <domain>
  --admin-path <path>
  --db-pass <password>

Node options:
  --panel <url>             Panel URL
  --token <token>           Join token OR enrollment key
  --node-type <exit|relay>  Default: exit

Sub/frontend options:
  --panel <url>             Panel URL
  --domain <domain>         Frontend domain
  --token <token>           Internal/frontend auth token
  --region <name>           Default: global
  --listen-port <port>      Default: 8080

Bot options:
  --panel <url>             Panel URL
  --bot-token <token>       Telegram bot token
  --panel-token <token>     Optional panel API token for bot
EOF
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --role)
      ROLE="${2:-}"
      shift 2
      ;;
    --domain)
      DOMAIN="${2:-}"
      shift 2
      ;;
    --sub-domain)
      SUB_DOMAIN="${2:-}"
      shift 2
      ;;
    --admin-path)
      ADMIN_PATH="${2:-}"
      shift 2
      ;;
    --db-pass)
      DB_PASS="${2:-}"
      shift 2
      ;;
    --install-dir)
      INSTALL_DIR="${2:-}"
      INSTALL_DIR_SET=1
      shift 2
      ;;
    --upgrade)
      UPGRADE=1
      shift
      ;;
    --no-restart)
      NO_RESTART=1
      shift
      ;;
    --panel)
      PANEL_URL="${2:-}"
      shift 2
      ;;
    --token)
      TOKEN="${2:-}"
      shift 2
      ;;
    --node-type)
      NODE_TYPE="${2:-}"
      shift 2
      ;;
    --region)
      REGION="${2:-}"
      shift 2
      ;;
    --listen-port)
      LISTEN_PORT="${2:-}"
      shift 2
      ;;
    --bot-token)
      BOT_TOKEN="${2:-}"
      shift 2
      ;;
    --panel-token)
      PANEL_TOKEN="${2:-}"
      shift 2
      ;;
    --version)
      VERSION_OVERRIDE="${2:-}"
      shift 2
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      echo "❌ Unknown argument: $1"
      usage
      exit 1
      ;;
  esac
done

ROLE=$(echo "$ROLE" | tr '[:upper:]' '[:lower:]')
NODE_TYPE=$(echo "$NODE_TYPE" | tr '[:upper:]' '[:lower:]')
if [[ "$NODE_TYPE" != "relay" ]]; then
  NODE_TYPE="exit"
fi
case "$ROLE" in
  agent) ROLE="node" ;;
  frontend) ROLE="sub" ;;
esac

case "$ROLE" in
  hub|panel|node|sub|bot) ;;
  *)
    echo "❌ Unsupported role: $ROLE"
    usage
    exit 1
    ;;
esac

if [[ -n "$VERSION_OVERRIDE" ]]; then
  VERSION="$VERSION_OVERRIDE"
else
  echo "🔍 Resolving latest version..."
  RELEASES_JSON=$(curl -fsSL "https://api.github.com/repos/$REPO/releases" || true)
  VERSION=$(printf "%s" "$RELEASES_JSON" \
    | grep -oE '"tag_name":[[:space:]]*"v[0-9]+\.[0-9]+\.[0-9]+"' \
    | head -n1 \
    | sed -E 's/.*"([^"]+)".*/\1/' || true)

  if [[ -z "$VERSION" ]]; then
    LATEST_URL=$(curl -Ls -o /dev/null -w %{url_effective} "https://github.com/$REPO/releases/latest")
    VERSION=$(basename "$LATEST_URL")
  fi
fi

if [[ -z "${VERSION:-}" || ! "$VERSION" =~ ^v[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
  echo "❌ Failed to detect release version."
  exit 1
fi

# Older CLIs ignore CARAMBA_RELEASE_REPOSITORY and fetch from the now-private
# repository. A public bridge release may still contain those exact binaries;
# never run one under the misleading promise that it can migrate an install.
IFS=. read -r VERSION_MAJOR VERSION_MINOR VERSION_PATCH <<< "${VERSION#v}"
if (( 10#$VERSION_MAJOR == 0 && (10#$VERSION_MINOR < 9 || (10#$VERSION_MINOR == 9 && 10#$VERSION_PATCH < 98)) )); then
  echo "❌ Public installation requires installer v0.9.98 or newer; $VERSION uses the old private download source."
  echo "Wait for the migration-capable release. For rollback, first update the CLI, then use caramba upgrade --to <public tag>."
  exit 1
fi

echo "✅ Using version: $VERSION"

DOWNLOAD_URL="https://github.com/$REPO/releases/download/$VERSION/$INSTALLER_ASSET"
echo "⬇️ Downloading installer from $DOWNLOAD_URL..."
TMP_BIN=$(mktemp)
TMP_SUMS=$(mktemp)
trap 'rm -f "$TMP_BIN" "$TMP_SUMS"' EXIT
curl -fL "$DOWNLOAD_URL" -o "$TMP_BIN"

# Supply-chain hardening: verify the downloaded installer against the release's
# required SHA256SUMS manifest BEFORE replacing the CLI or executing it as root.
# Every release allowed by the migration version floor must publish this asset.
SUMS_URL="https://github.com/$REPO/releases/download/$VERSION/SHA256SUMS"
if ! curl -fLs "$SUMS_URL" -o "$TMP_SUMS"; then
  echo "❌ Could not download required SHA256SUMS for $VERSION — refusing to install."
  exit 1
fi
EXPECTED=$(awk -v asset="$INSTALLER_ASSET" '$2 == asset { print $1 }' "$TMP_SUMS")
if [[ ! "$EXPECTED" =~ ^[a-f0-9]{64}$ ]]; then
  echo "❌ SHA256SUMS must contain exactly one valid checksum for $INSTALLER_ASSET — refusing to install."
  exit 1
fi
if command -v sha256sum >/dev/null 2>&1; then
  ACTUAL=$(sha256sum "$TMP_BIN" | awk '{print $1}')
else
  ACTUAL=$(shasum -a 256 "$TMP_BIN" | awk '{print $1}')
fi
if [[ "$EXPECTED" != "$ACTUAL" ]]; then
  echo "❌ Checksum mismatch for $INSTALLER_ASSET (expected $EXPECTED, got $ACTUAL). Aborting."
  exit 1
fi
echo "✅ Installer checksum verified."

chmod +x "$TMP_BIN"

echo "📦 Installing caramba to $INSTALL_BIN_DIR/caramba..."
mv "$TMP_BIN" "$INSTALL_BIN_DIR/caramba"
chmod +x "$INSTALL_BIN_DIR/caramba"

INSTALL_ARGS=(install)
if [[ "$UPGRADE" == 1 ]]; then
  INSTALL_ARGS=(upgrade --version "$VERSION")
  [[ "$INSTALL_DIR_SET" == 1 ]] && INSTALL_ARGS+=(--install-dir "$INSTALL_DIR")
  [[ "$NO_RESTART" == 1 ]] && INSTALL_ARGS+=(--no-restart)
else
case "$ROLE" in
  hub)
    INSTALL_ARGS+=(--hub --install-dir "$INSTALL_DIR")
    [[ -n "$DOMAIN" ]] && INSTALL_ARGS+=(--domain "$DOMAIN")
    [[ -n "$SUB_DOMAIN" ]] && INSTALL_ARGS+=(--sub-domain "$SUB_DOMAIN")
    [[ -n "$ADMIN_PATH" ]] && INSTALL_ARGS+=(--admin-path "$ADMIN_PATH")
    [[ -n "$DB_PASS" ]] && INSTALL_ARGS+=(--db-pass "$DB_PASS")
    [[ -n "$TOKEN" ]] && INSTALL_ARGS+=(--token "$TOKEN")
    [[ -n "$BOT_TOKEN" ]] && INSTALL_ARGS+=(--bot-token "$BOT_TOKEN")
    [[ -n "$REGION" ]] && INSTALL_ARGS+=(--region "$REGION")
    ;;
  panel)
    INSTALL_ARGS+=(--panel --install-dir "$INSTALL_DIR")
    [[ -n "$DOMAIN" ]] && INSTALL_ARGS+=(--domain "$DOMAIN")
    [[ -n "$ADMIN_PATH" ]] && INSTALL_ARGS+=(--admin-path "$ADMIN_PATH")
    [[ -n "$DB_PASS" ]] && INSTALL_ARGS+=(--db-pass "$DB_PASS")
    ;;
  node)
    if [[ -z "$PANEL_URL" ]]; then
      echo "❌ --panel is required for role node"
      exit 1
    fi
    if [[ -z "$TOKEN" ]]; then
      echo "❌ --token is required for role node"
      exit 1
    fi
    INSTALL_ARGS+=(--node --install-dir "$INSTALL_DIR" --panel-url "$PANEL_URL" --token "$TOKEN" --node-type "$NODE_TYPE")
    ;;
  sub)
    if [[ -z "$PANEL_URL" ]]; then
      echo "❌ --panel is required for role sub/frontend"
      exit 1
    fi
    if [[ -z "$DOMAIN" ]]; then
      echo "❌ --domain is required for role sub/frontend"
      exit 1
    fi
    if [[ -z "$TOKEN" ]]; then
      echo "❌ --token is required for role sub/frontend"
      exit 1
    fi
    INSTALL_ARGS+=(--sub --install-dir "$INSTALL_DIR" --panel-url "$PANEL_URL" --domain "$DOMAIN" --token "$TOKEN" --region "$REGION" --listen-port "$LISTEN_PORT")
    ;;
  bot)
    if [[ -z "$PANEL_URL" ]]; then
      echo "❌ --panel is required for role bot"
      exit 1
    fi
    if [[ -z "$BOT_TOKEN" ]]; then
      echo "❌ --bot-token is required for role bot"
      exit 1
    fi
    INSTALL_ARGS+=(--bot --install-dir "$INSTALL_DIR" --panel-url "$PANEL_URL" --bot-token "$BOT_TOKEN")
    [[ -n "$PANEL_TOKEN" ]] && INSTALL_ARGS+=(--panel-token "$PANEL_TOKEN")
    ;;
esac
fi

echo "🚀 Running ${INSTALL_ARGS[0]}..."
export CARAMBA_VERSION="$VERSION"
if [[ "$EUID" -ne 0 ]]; then
  sudo CARAMBA_VERSION="$VERSION" CARAMBA_RELEASE_REPOSITORY="$REPO" "$INSTALL_BIN_DIR/caramba" "${INSTALL_ARGS[@]}"
else
  "$INSTALL_BIN_DIR/caramba" "${INSTALL_ARGS[@]}"
fi
