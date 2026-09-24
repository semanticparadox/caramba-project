# Install the panel

[← Documentation](README.md) · **English** | [Русский](INSTALL.ru.md) · [Upgrade an existing panel](UPGRADING.md)

This guide is for service owners. If you only want to connect to a VPN, use the
[Caramba Connect guide](CONNECT.md).

Installation from the public address requires release **0.9.98 or later**.
Older 0.9.97 server files do not support this installation path.

## Prepare your server

You need a Linux server with administrator access, internet access and a domain
pointing to its IP address. A dedicated server running Ubuntu 22.04 or newer is
recommended. Check the [release notes](https://github.com/semanticparadox/caramba-project/releases/latest)
for supported systems and architectures.

Have access to your domain's DNS settings. If you plan to use Telegram, create
a bot through BotFather and keep its token ready for setup. The token controls
your bot; do not publish it or include it in support requests.

## Run the installer

Connect to the server over SSH, download the official installer and run it:

```bash
curl -fsSL https://raw.githubusercontent.com/semanticparadox/caramba-project/main/install.sh -o /tmp/caramba-install.sh
sudo bash /tmp/caramba-install.sh
```

The installer downloads ready-to-use components from the public release. Follow
its prompts to choose the panel role, enter your domain and configure the admin
account. Save the login address and password in your password manager.

Back up existing data before installing on a server already in use. For an
existing Caramba installation, follow the [upgrade guide](UPGRADING.md).

## First run

1. Open the panel address shown by the installer and sign in as the owner.
2. Confirm that HTTPS works and the service status shows no errors.
3. Add a VPN server in the servers section. Run the enrollment command supplied
   by the panel on that server and wait for it to come online. The command contains
   a secret; use it only on a server you control.
4. Create a plan with access duration, traffic allowance and device limits.
   Link it to the intended servers or server group.
5. Issue a subscription to your own test user and check it in Caramba Connect.
6. Set up your bot, messages and support contact if your service needs them.

The panel and VPN server have different roles: being able to sign in to the panel
does not mean a connection server is ready. Check both before inviting users.

## Choose an edition

In release **0.9.98**, Free allows up to 3 VPN servers, 2 separate
relays and 100 users, without integrated payments. For Full or setup questions,
contact [@caramba_support](https://t.me/caramba_support).
[Terms of use](../LICENSE.md).

Next: [panel guide](PANEL.md) · [backups and upgrades](UPGRADING.md).
