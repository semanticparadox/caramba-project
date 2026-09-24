# Activate Caramba Full

**English** | [Русский](LICENSING.ru.md)

Free can be installed on your own server with no license fee. For Full, contact
[@caramba_support](https://t.me/caramba_support), agree on the term and number
of installations, and receive an activation file for your panel.
In-app license purchasing is not available yet.

## What the panel owner receives

Full enables integrated payments, custom branding and automatic promotional
subscription activation. The standard license allows up to 1000 servers and
unlimited users. The issued license determines the actual term and limits.
This licenses the panel; an end user's VPN subscription is obtained separately
from their chosen provider.

## Activation

1. Send support your panel domain and installation identifier. The identifier
   is stored in `CARAMBA_INSTANCE_ID`; preserve it during upgrades. If an older
   installation has no identifier, agree on a new one when requesting a license.
2. Receive a private file containing four settings: `CARAMBA_LICENSE_KEY`,
   `CARAMBA_INSTANCE_ID`, `CARAMBA_LICENSE_SERVER_URL` and `CARAMBA_LICENSE_PUBKEY`.
3. Your server administrator adds or replaces those four values in the existing
   `/opt/caramba/.env`, preserving all other settings. Do not replace the whole
   `.env` with the activation file. Restrict access to the service administrator;
   standard installations use file permissions `0600`.
4. Restart the panel service and check its edition in General settings.
   In version 0.9.98, **Pro** means **Full**. This version has no browser form
   for entering a license key.

The activation file contains your secret license key. Do not publish it in a
repository, public chat or screenshot. The private signing key used by the
Caramba owner is never supplied to customers.

## Renewal and moving servers

Contact [@caramba_support](https://t.me/caramba_support) to renew or move a license.
Do not copy a license to additional installations beyond its agreed seat count.
Preserve the installation identifier and key during ordinary panel upgrades.

The panel checks activation at startup and approximately every 12–24 hours.
If the activation server is unavailable, a previously verified license remains
valid for up to 14 days after its last successful check, but never beyond its
expiry date. Free restrictions apply when validity ends; renew in advance.

[Compare Free and Full](../README.md#free-and-full) ·
[Terms of use](../LICENSE.md) · [Upgrade the panel](UPGRADING.md)
