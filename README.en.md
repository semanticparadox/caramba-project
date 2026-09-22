<p align="center"><img src="docs/brand/caramba-cover.png" alt="The Caramba ship heading into open water" width="100%"></p>
<h1 align="center">Caramba Project</h1>
<p align="center"><strong>Your course. Your service.</strong><br>VPN administration and Caramba Connect apps.</p>
<p align="center"><a href="README.md">RU</a> | <strong>ENG</strong></p>
<p align="center"><a href="#download-caramba-connect">Download</a> · <a href="#install-the-panel">Install</a> · <a href="docs/UPGRADING.en.md">Upgrade</a> · <a href="docs/README.en.md">Documentation</a> · <a href="https://t.me/caramba_support">Support</a></p>

Caramba helps you run a VPN on your own servers and manage it from one panel.
Your users connect with Caramba Connect, access their subscriptions and contact
support from the app.

**Caramba Project 0.9.98 is available** for the panel, installer, nodes, bot
and Caramba Connect. Connect's internal build number is **112**.
[Release notes](docs/releases/0.9.98.en.md).

## Start here

| I want to… | Next step |
| :--- | :--- |
| Connect to my provider | [Download Caramba Connect](#download-caramba-connect) and [add a connection](docs/CONNECT.en.md). |
| Run my own service | [Install the panel](docs/INSTALL.en.md), add a server and issue a subscription. |
| Upgrade an existing installation | [Back up and upgrade](docs/UPGRADING.en.md). |
| Learn the panel | [Read the owner's guide](docs/PANEL.en.md). |

## Your service, in one place

**Infrastructure.** Servers, relays, node health and connection choices.
VLESS Reality, Hysteria2, TUIC, Shadowsocks and AmneziaWG are available depending
on the server and client.

**Users.** Plans, subscriptions, access duration, devices and support tickets.
A Telegram bot and Mini App help users get their connection link.

**New in 0.9.98:** staff permissions, up to 730 days of traffic history,
single-use key batches with TXT/CSV export, and a message editor with images,
GIFs and preview. [See what's new →](docs/releases/0.9.98.en.md)

## Free and Full

Version **0.9.98** introduces these panel editions:

| | Free | Full |
| :--- | :---: | :---: |
| VPN servers | Up to 3 | Per license |
| Relays | Up to 2, separate from servers | Per license |
| Users | Up to 100 | Per license |
| Tickets, messages, analytics, staff | Yes | Yes |
| Integrated payments | No | Yes |
| Key and promotional subscription activation | Admin approval | Automatic |
| Operator branding | Standard | Customizable |

Free is the official self-hosted build with no license fee. Free access and
welcome gifts configured in advance by the owner may be granted automatically.
In Free, waiting for key approval does not consume the granted days.

**For Full, contact [@caramba_support](https://t.me/caramba_support).** Terms and
authorization are arranged individually; automated license sales are not open.
[Terms of use](LICENSE.md).

## Download Caramba Connect

Release **0.9.98** files are available below. The historical source release
covers earlier versions; it is not a new app release.

The app is distributed separately. You need a subscription from your
provider; downloading the app does not include VPN service.

| Platform | Release 0.9.98 files |
| :--- | :--- |
| Windows · 64-bit | [EXE installer](https://github.com/semanticparadox/caramba-project/releases/latest/download/Caramba-Connect-Setup-x64.exe) · [Portable ZIP](https://github.com/semanticparadox/caramba-project/releases/latest/download/Caramba-Connect-Windows-x64-portable.zip) |
| macOS · Apple Silicon | [DMG](https://github.com/semanticparadox/caramba-project/releases/latest/download/Caramba-Connect-macOS-arm64.dmg) |
| Android | [ARM64 APK](https://github.com/semanticparadox/caramba-project/releases/latest/download/Caramba-Connect-Android-arm64.apk) · [ARMv7 APK](https://github.com/semanticparadox/caramba-project/releases/latest/download/Caramba-Connect-Android-armv7.apk) |
| Linux · 64-bit | [TAR.GZ archive](https://github.com/semanticparadox/caramba-project/releases/latest/download/Caramba-Connect-Linux-x64.tar.gz) |
| iPhone / iPad | No public Caramba Connect build yet. Ask your provider for a compatible client. |
| Telegram | Open the Mini App in your provider's bot; no separate installation. |

[Release page](https://github.com/semanticparadox/caramba-project/releases/latest) ·
[Installation and connection guide](docs/CONNECT.en.md)

Caramba is in beta. Signing, requirements and platform limitations are documented
in each release. On macOS, the current app uses a local proxy; it does not provide
a system VPN tunnel for all apps.

The macOS app uses an ad-hoc signature without a Developer ID certificate.
The DMG is unsigned and has not been notarized by Apple; macOS may block normal
opening of the downloaded file. This is an Apple Silicon beta build.

## Install the panel

You need a Linux server with administrator access and a domain.
The [installation guide](docs/INSTALL.en.md) takes you from server preparation
to your first subscription.
For an existing service, read the
[upgrade guide](docs/UPGRADING.en.md) first.

## Help and documentation

- [Panel guide](docs/PANEL.en.md) — users, servers, keys, messages and your team.
- [Connect and troubleshoot](docs/CONNECT.en.md) — help for Caramba Connect users.
- [Documentation](docs/README.en.md) — installation, upgrades and terms.
- [Licenses](LICENSE.md) · [Third-party components](docs/legal/THIRD_PARTY.md) · [Corresponding source](docs/legal/SOURCE_AVAILABILITY.md).

This repository provides documentation and links to ready-to-use releases.
Corresponding source required by component licenses is supplied **as attachments
to the same release**, alongside its binaries.

For the project, installation or Full, contact **[@caramba_support](https://t.me/caramba_support)**.
For a subscription from another provider, contact that provider's support.
