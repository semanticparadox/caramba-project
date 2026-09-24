# Caramba Connect: connect and troubleshoot

[← Documentation](README.md) · **English** | [Русский](CONNECT.ru.md) · [Download the app](../README.md#download-caramba-connect)

Caramba Connect connects you to your VPN provider. **Caramba Connect 0.9.98**
is part of Caramba Project **0.9.98**. Its internal build number is **112**.
Available platforms and files are listed below.

## Install the app

Download from the [official release](https://github.com/semanticparadox/caramba-project/releases/latest).
Check its notes for the appropriate build and limitations.

| System | Installation |
| :--- | :--- |
| Windows 64-bit | Open `Caramba-Connect-Setup-x64.exe` and follow the installer. Extract the entire portable ZIP if using it; the app needs the files beside its EXE. |
| macOS on Apple Silicon | Open the DMG and move the app to Applications. This build is for Apple M-series chips. |
| Android | Most devices use ARM64; ARMv7 is for older 32-bit devices. Open the APK and allow installation from your chosen download source. |
| Linux 64-bit | Extract the archive and run the included `install.sh`, which sets up app integration and required permissions. |
| iPhone / iPad | There is no public Caramba Connect build. Ask your provider for a compatible app and subscription link. |

The macOS app uses an ad-hoc signature without a Developer ID certificate.
The DMG is unsigned and has not been notarized by Apple; macOS may block normal
opening of the downloaded file. This is an Apple Silicon beta build.

The release notes describe signing and requirements. If your system reports a
damaged or incompatible file, check the platform, download source and file
integrity before trying again.

## Add a connection

1. Get a connection link from your provider. In its Telegram bot, look for
   **Connect Caramba Connect** or the `/link` command.
2. Open the link. If it does not open the app, copy it and choose
   **Connections → Add connection → Paste** in the app.
3. Check the operator name on the confirmation screen and confirm the connection.
4. Return to the home screen and press Connect.
5. On Android, approve the system VPN request when connecting for the first time.

An invitation can be single-use and time-limited. Get a fresh link if it has
expired. Do not forward it to anyone else.

Add connection also accepts supported standard subscriptions and configuration
files. Account, plan and device management requires a linked panel account and
depends on your provider's capabilities.

## How traffic is routed

Windows and Linux default to **system TUN**. A previously selected mode is
retained. Windows requests administrator permission; on Linux, run the included
`install.sh` — it requests the required permissions and configures TUN access.
If permissions prevent TUN from starting, fix the installation or manually choose
**Local proxy** under **Settings → Network and core → Traffic capture**.

On macOS, use the **local proxy**: system TUN is unsupported in the current
build. The proxy address is displayed in the app, usually `127.0.0.1:7890`.
In proxy mode, configure your browser or other app with that address. A connected
status on a Mac does not mean all device traffic is routed through the VPN.

Use traffic rules to choose an available routing mode and exceptions. Reconnect
after a settings change if prompted.

## Servers, profile and support

Choose an available server or use **Find best node**. If your provider offers
relays, you can choose an entry point. The connection type needs to work with
both your server and network.

A linked account's profile provides subscriptions, devices and support requests.
Labels and available actions depend on the provider and panel version. Your plan
determines access duration and device limits.

On desktop, the app may remain in the tray or menu bar after its window closes.
Startup and close behavior are in the app settings. Use its Quit action when
you want to close the app completely.

## If it does not connect

| Symptom | What to check |
| :--- | :--- |
| A link does not open the app | Paste it manually. The Windows portable app does not register links automatically. |
| An invitation expired | Request a fresh link from the provider. |
| A server does not respond | Check internet access without the VPN, then try another available server or connection type. |
| Connected, but sites do not open | Check proxy/TUN mode, browser settings and traffic rules. |
| All device slots are taken | Remove an unused device or ask your provider about the plan limit. |
| A subscription is awaiting approval | Wait for your provider's approval. Reinstalling the app will not speed it up. |
| A support request fails to send | Check the network and your existing ticket list, then retry. |

Contact your provider for subscription questions. For a problem with the app
itself, contact [@caramba_support](https://t.me/caramba_support). Include your
system, app version and error text. Do not include passwords, invitations,
subscription keys or personal payment details.

## Checksums and source

App checksums are recorded in the release's `Caramba-Connect-<platform>.json`
files. Matching source archives and their checksums are attached alongside
the builds. [Find the right source archive](legal/SOURCE_AVAILABILITY.md).
