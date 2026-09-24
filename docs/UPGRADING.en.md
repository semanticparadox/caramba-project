# Upgrades and backups

[← Documentation](README.md) · **English** | [Русский](UPGRADING.ru.md)

Release **0.9.98** is available. The upgrade command installs the published release.

**Server upgrades from the new address require 0.9.98 or newer.** The panel,
installer, nodes, bot and Connect apps share version **0.9.98**.

## Before upgrading the panel

Read the [release notes](https://github.com/semanticparadox/caramba-project/releases/latest).
Choose a time when a short service interruption will affect fewer users.

Back up the database, installation settings, keys and uploaded message attachments.
Include any custom file locations. In 0.9.98, the default image and GIF directory
is `/var/lib/caramba/message-media`.

Keep a copy away from the server being upgraded and know how to restore it.
After database changes, replacing a binary with an older version may not be
enough to roll back.

## Upgrade the panel

On the panel server, download the current installer from **Caramba Project**:

```bash
curl -fsSL https://raw.githubusercontent.com/semanticparadox/caramba-project/main/install.sh -o /tmp/caramba-install.sh
sudo bash /tmp/caramba-install.sh --upgrade
```

This also supports installations that previously updated from
`semanticparadox/caramba`: it refreshes the installer before upgrading components.
Use the new address for your next upgrade.

There is no automatic redirect from the old repository. The 0.9.97 installer
still points there, so running the old upgrade command is insufficient; use
the new script above.

## Migrate the panel's download links

Open **Bot & App → Client App**, then the **Downloads** form. Replace any saved
Android, Windows, macOS and Linux links pointing to the old repository with:

| Platform | New address |
| :--- | :--- |
| Android | `https://github.com/semanticparadox/caramba-project/releases/latest/download/Caramba-Connect-Android-arm64.apk` |
| Windows | `https://github.com/semanticparadox/caramba-project/releases/latest/download/Caramba-Connect-Setup-x64.exe` |
| macOS | `https://github.com/semanticparadox/caramba-project/releases/latest/download/Caramba-Connect-macOS-arm64.dmg` |
| Linux | `https://github.com/semanticparadox/caramba-project/releases/latest/download/Caramba-Connect-Linux-x64.tar.gz` |

Do not add an iOS link; no public build exists. Save and test the user-facing
download buttons.

**Changing an address and changing a build are different operations.** If the new
address serves the exact same file, changing the link is enough. For a different
build, such as Connect 0.9.98, first deploy its matching
`Caramba-Connect-<platform>.json` files on the panel. Replace the app files too if
serving them locally. The panel takes the version, build number and checksum
from those files even when the download URL is manually overridden. An old
version file paired with a new app can cause an update verification failure.

For a standard installation, these files are in
`/opt/caramba/apps/caramba-panel/downloads/`. For a custom installation directory,
use its `apps/caramba-panel/downloads/` subfolder. Take the apps and version files
from the same release. Afterwards, check **Bot & App → Client App → Releases →
Builds on disk**: a file missing from the release does not automatically replace
an older local file. Uploading a file to Telegram does not update these panel files.
After manually replacing files, allow up to five minutes for the cache to refresh,
or restart the panel during planned maintenance. Confirm **0.9.98, build 112** appears.

Do not merely edit the version number. Installed apps get their links from the
panel, so changing the address alone does not require reinstalling them.

## Check the service after upgrading

Upgrade the panel first, then its VPN servers and relays, then client apps.
Afterwards, check owner sign-in, server health, a test connection and subscription
access. If you use Full, check your license and payment flow before reopening sales.

## Changes to expect in 0.9.98

- Up to 730 days of traffic history accumulates after the upgrade. Previously
  deleted data cannot be recovered by updating.
- Device attribution starts after client updates and server configuration
  activation. Legacy shared connections remain in the shared traffic category.
- Free requires admin approval for user-redeemed keys and pending subscriptions.
  Key days are preserved while waiting.
- New integrated payments require Full. Changing editions does not delete
  existing users or servers.

## Update Caramba Connect

Use the update offered in the app or download the new
[build for your platform](../README.md#download-caramba-connect). Close the app
before replacing its files. On Android, install the APK for the same architecture
over the existing app; avoid uninstalling it first unless necessary.

If an upgrade fails, save the error text and version number. Avoid repeatedly
deleting data. Contact [@caramba_support](https://t.me/caramba_support).
