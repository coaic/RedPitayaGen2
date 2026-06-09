#!/usr/bin/env bash
# start-desktop.sh — start the Vivado remote desktop VM and open an IAP RDP tunnel.
#
# Usage: ./scripts/start-desktop.sh
#
# Prerequisites:
#   - gcloud auth login
#   - Microsoft Remote Desktop installed (Mac App Store, free)
#   After running this script, open Microsoft Remote Desktop and connect to localhost:3389
#   Username: packer  Password: (set on first login via gcloud compute ssh)

set -euo pipefail

PROJECT="${GCP_PROJECT:-redpitaya-fpga-builds}"
ZONE="${GCP_ZONE:-australia-southeast1-a}"
INSTANCE="vivado-desktop"

echo "Starting ${INSTANCE}..."
gcloud compute instances start "${INSTANCE}" \
  --zone="${ZONE}" --project="${PROJECT}"

echo "Opening IAP tunnel on localhost:3389..."
echo "Connect Microsoft Remote Desktop to localhost:3389 (username: packer)"
echo "Press Ctrl+C to close the tunnel and stop the VM."
echo ""

# Open tunnel — blocks until Ctrl+C
gcloud compute start-iap-tunnel "${INSTANCE}" 3389 \
  --local-host-port=localhost:3389 \
  --zone="${ZONE}" \
  --project="${PROJECT}"
