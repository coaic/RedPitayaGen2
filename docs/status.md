# Project Status

Last updated: 2026-06-10

## Infrastructure — All Provisioned and Validated

| Component | Status | Notes |
|---|---|---|
| GCP project `redpitaya-fpga-builds` | ✅ Live | Billing linked |
| Terraform infrastructure | ✅ Applied | VPC, GCS buckets, IAM, NAT, budget |
| Vivado installer in GCS | ✅ Uploaded | `gs://redpitaya-fpga-builds-fpga-installer/Xilinx_Unified_2020.1_0602_1208.tar.gz` |
| Packer image `vivado-2020-1` | ✅ Ready | `vivado-2020-1-1780984785` — Vivado 2020.1 + XFCE + XRDP |
| Cloud Batch pipeline | ✅ Validated | Built `red_pitaya.bit` from `RedPitaya/RedPitaya-FPGA` master in ~8.5 min |
| IAP firewall rule | ✅ Applied | `allow-rdp-iap` → port 3389 |
| `vivado-desktop` VM | ✅ On-demand | Created/deleted by scripts — no idle cost |
| Remote desktop PoC | ✅ Validated | XRDP + XFCE responsive, Vivado GUI usable |

## Next Steps

### 1. Clean up stale branches

- `fix/purge-billing-account-from-history` — pending review/merge or delete
- `feat/cloud-build-infrastructure` — superseded by main, can be deleted

### 2. KiwiSDR — Vivado 2024.2 image

Apply the same Packer + Cloud Batch pattern for KiwiSDR (Vivado 2024.2, larger disk needed).

## Key Facts to Remember

**Vivado version**: 2020.1 is hard-pinned in `prj/v0.94/ip/systemZ20_G2.tcl`. All
`Release-20xx.x` branches in `RedPitaya/RedPitaya-FPGA` also use 2020.1 — the branch
naming refers to the Red Pitaya software release, not the Vivado version.

**Desktop VM cost**: ~$0.19/hr while running, zero when not in use.
`start-desktop.sh` creates the VM fresh from the image each session.
`stop-desktop.sh` deletes it entirely — no idle disk charges.

**Desktop login**: username `packer`, password set manually via `sudo passwd packer`
after first SSH in. If password is forgotten, SSH in again and reset it.

**Billing account ID**: stored in `infra/environments/dev.local.yml` (gitignored).
