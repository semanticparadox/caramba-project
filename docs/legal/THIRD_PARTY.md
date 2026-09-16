# Third-party components

This is a component boundary and release-distribution guide, not a replacement
for the licenses included with each dependency. Versions are pinned by the lockfiles
and build workflows in the same release revision.

| Component | Pinned version / location | License and source |
| --- | --- | --- |
| Mihomo | v1.19.27, `libs/caramba-core/go.mod`; local patches in `libs/caramba-core/patches` | [GPL-3.0](https://github.com/MetaCubeX/mihomo/blob/v1.19.27/LICENSE) |
| sing-box | v1.13.14, `.github/workflows/release.yml` | [GPL-3.0-or-later](https://github.com/SagerNet/sing-box/blob/v1.13.14/LICENSE) |
| amneziawg-go | v3.1.20260828, release workflow | [MIT license and source](https://github.com/amnezia-vpn/amneziawg-go/blob/v3.1.20260828/LICENSE) |
| Wintun signed Windows DLL | 0.14.1, checksum-pinned `libs/caramba-core/scripts/fetch-wintun.sh` | [Prebuilt Binaries License](https://www.wintun.net/), retained beside the DLL; separate from the GPL-2.0 source license |
| colored | 3.1.1, `Cargo.lock` | MPL-2.0; preserve file notices and provide the unmodified covered source |
| webpki-root-certs / webpki-roots | `Cargo.lock` | CDLA-Permissive-2.0; preserve the supplied certificate-data notices |
| Other Rust dependencies | `Cargo.lock` | Per-package SPDX identifiers and license files in the source distribution |
| Flutter and Dart packages | `apps/caramba-client/pubspec.lock` | Per-package notices; the Flutter licenses screen remains available |
| QR scanner | `qr_code_scanner_plus` 2.3.0; ZXing core 3.5.2 / Android Embedded 4.3.0 | BSD-2-Clause / Apache-2.0; notices in the app's licenses screen, exact native source jars in Android source assets |
| Go dependencies | `libs/caramba-core/go.sum` and engine module files | Preserve upstream notices and exact source alongside patched engine builds |
| Browser libraries | `apps/caramba-panel/assets/js/vendor`, frontend lockfiles | Preserve embedded/license-file notices when rebuilding bundled assets |

A release carrying copyleft binaries must also carry corresponding source and
build instructions, rather than only a moving upstream URL. Keep local engine
patches, exact module versions and workflow build tags with that source. Do not
remove the source assets while their binary releases remain available.

The release workflows generate these assets before uploading their binaries.
See [Component source availability](SOURCE_AVAILABILITY.md) for
the artifact inventory, component scopes and release checks.

The panel invokes sing-box as a separate process. Its license is not a grant to
relicense sing-box or the Mihomo-linked client under the panel's restrictions.
