# Caramba panel: owner's guide

[← Documentation](README.md) · **English** | [Русский](PANEL.ru.md) · [Install](INSTALL.md) · [Support](https://t.me/caramba_support)

The panel brings together your servers, users, subscriptions and support.
Features introduced in the **0.9.98 release** are marked below. Their
menu entries may not be present in the previously published 0.9.97 release.

## Your first day

After [installation](INSTALL.md), sign in as the owner. Add a VPN server, wait
for it to connect to the panel, create a plan and issue a subscription to your
own test user. Test the app connection before inviting customers.

Keep your login address and password safe. In 0.9.98, separate staff accounts
let your team work without sharing the owner's password.

## Servers and relays

A VPN server provides the internet exit. A relay adds an entry point and forwards
the connection to an exit server. Start with a regular server if you do not need
a relay arrangement.

Add a node in the servers section and run its enrollment command on your server.
Wait for it to connect, then link the server or its group to the intended plan.
Adding a server to the panel alone does not make it available to every user.

Choose protocols supported by both the server and client. When a server is
unavailable, check its health and connection to the panel first. Changing a user's
plan or issuing another key will not fix an offline server.

## Plans, users and devices

A plan defines access duration, available servers, traffic allowance and device
limits. Review these before issuing subscriptions. The service owner sets the
free plan's allowance; there is no universal traffic quota for every installation.

A user's page shows their active subscription, expiry, devices and tickets.
When all device slots are taken, a user with a connected panel account can remove
an unused device in the app.

Connection links give access to an account or subscription. Share them only with
the account owner. For troubleshooting, the error text and app version are
usually sufficient.

### Pending subscriptions — new in 0.9.98

In Free, user activation of keys, promotional subscriptions and pending
subscriptions requires admin approval. Open the pending subscription on the
user's page and approve it when you are ready to provide access.

Key days are preserved while waiting. Multiple keys for the same plan accumulate.
On approval, their days extend an existing subscription to the same plan,
preserving paid time. If no active time remains, the grant starts at approval.

If the selected group has no available capacity, approval fails and the pending
days remain intact. Free capacity or correct the group settings, then try again.
Activating a different plan replaces the current one; account for this before
approving a switch.

Free access and welcome gifts configured in advance by the owner may be granted
automatically in Free as well.

## Subscription keys — new in 0.9.98

Use keys for individual grants, promotions or marketplace sales. Open
**Sales → Promotions → Subscription keys**.

1. Select an active plan and the number of days.
2. Name the batch and choose a quantity from 1 to 5,000.
3. Optionally set the last date on which keys may be redeemed. The date is in UTC.
4. Create the batch and download the required format.

| File | Contents | Typical use |
| :--- | :--- | :--- |
| TXT | Valid, unused keys only, one per line | Import into a marketplace delivery system. |
| CSV | All keys in the batch, duration and status | Track issued and remaining keys. |

Each key can be redeemed once. Resubmitting the same creation form should return
the same batch. **Revoke unused** invalidates keys that have not been redeemed;
existing subscriptions and their history remain.

Give each customer only their own key. A full TXT/CSV export grants access to all
unused keys in the batch, so protect it like a password.

A key for the same plan adds days to the active subscription. Free waits for
approval; Full activates automatically. The redemption deadline and subscription
duration are different: the former limits when a key may be used, while the latter
sets how long access lasts.

## Traffic and history — new in 0.9.98

Open **Overview → Traffic analytics**. Choose 7, 30, 90, 180, 365 or 730 days,
or select custom dates within 730 days. Dates and daily intervals use UTC.
The chart shows daily measured traffic, with exact amounts in the tables.
Filter by user and device. CSV export requires permission to manage analytics.

| Category | Meaning |
| :--- | :--- |
| Device | The server measured credentials assigned to a specific device. |
| Shared | Traffic belongs to a subscription whose credentials are shared. |
| Unknown | A measurement cannot reliably be matched to a user or device. |

Shared traffic is not a second estimate of an individual device's traffic.
The categories describe different measurement coverage. An old shared
subscription cannot be split into a device history retroactively.

Device attribution requires an updated client with a stable installation ID and
separate credentials. Those credentials become active after the serving nodes
apply their configuration. Shared AmneziaWG and Shadowsocks modes remain shared.
The statistics do not promise individual device coverage for every protocol.

Daily measurements are retained for up to **730 days**. New history accumulates
after upgrading; previously deleted data is not reconstructed. An empty period
means there are no measurements for it. Following an outage, delayed traffic
may be recorded on the day the report arrives. Check server health if new data
is missing.

These statistics measure traffic volume, not the websites a user visits.

## Telegram messages — updated in 0.9.98

In **Messaging → Templates**, choose an event and language. Welcome messages have
regular and promotion variants. Enter your message, choose its format and add
an image, GIF or link buttons if needed.

PNG, JPEG and GIF files are supported up to **5 MB** each. Buttons can be grouped
into rows. The preview shows the message with a sample recipient name; rendering
may vary slightly between Telegram versions.

**Saving a template does not send it to users.** **Send test to me** sends only to
the current administrator's Telegram account, if linked. After checking a test,
use **Messaging → Broadcasts** to launch a campaign separately.

Unused attachments older than seven days are cleaned up on the next upload.
Files referenced by templates are retained. Include attachments in your backups.

## Support tickets

Caramba Connect users open **Profile → Support requests**, describe their problem
and receive replies there. Open the panel's tickets section, choose a ticket and
reply. Assign a responsible staff member when working as a team so the same issue
is not handled independently by two people.

In **0.9.98**, saving a ticket does not wait for Telegram notification delivery.
The updated client can retry a failed submission without creating another ticket.
For users on older clients, ask them to check their ticket list and update first.

**Support tickets → Manage** is sufficient for replying. Support staff do not
need server credentials or payment settings for this task.

## Team permissions — new in 0.9.98

As the owner, open **System → Panel accounts**. Create a staff username and
password, then choose access for each section.

| Permission | Access |
| :--- | :--- |
| No access | The section is unavailable. |
| View | Read permitted information without making changes. |
| Manage | Perform the permitted actions in that section. |

Key and analytics exports require the corresponding management permission.
Read access does not reveal system secrets. Owner management and system secrets
remain available only to the panel owner.

Changing permissions or disabling an account invalidates its previous sessions.
Staff change their own passwords through **My account** at the top of the panel.
Start with only the sections each person needs and expand access with their role.

## Free, Full and payments — 0.9.98

Free provides the official build without a license fee: **3 VPN servers,
2 separate relays and 100 users**. Support, messages, analytics and staff accounts
are available. Integrated payments are disabled.

Full requires separate authorization and a valid license. Contact
[@caramba_support](https://t.me/caramba_support); automated license sales are not
open. [Edition terms](../LICENSE.md).

License expiry does not delete users, servers or data. Limits apply to new
operations and new payments. Before changing editions, check your payment flow
and the resulting limits.

## Regular maintenance

Check server health, user tickets and free disk space. Keep a separate backup
of the database, settings and attachments. Before upgrading, read the
[upgrade guide](UPGRADING.md) and the specific release notes.

For help, send [@caramba_support](https://t.me/caramba_support) the version and error
text. Do not include passwords, tokens, complete connection links or key exports.
