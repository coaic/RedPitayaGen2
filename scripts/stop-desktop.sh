#!/usr/bin/env bash
# stop-desktop.sh — stop the Vivado desktop VM (stops billing for compute).
# The boot disk continues to incur storage costs (~$0.16/day for 200 GB pd-balanced).

set -euo pipefail

PROJECT="${GCP_PROJECT:-redpitaya-fpga-builds}"
ZONE="${GCP_ZONE:-australia-southeast1-a}"

gcloud compute instances stop vivado-desktop \
  --zone="${ZONE}" --project="${PROJECT}"

echo "vivado-desktop stopped."
