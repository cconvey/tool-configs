#!/usr/bin/bash
set -o nounset
set -o errexit
set -o pipefail

export TOUCHSCREEN_XRANDR_ID="DP-2"
export TOUCHSCREEN_VIRTUAL_KEYBOARD_XINPUT_NAME="CVTE Touch Device HS Keyboard"

for XINPUT_ID in $(xinput | grep CVTE | grep pointer | sed -rn 's/.*id=([0-9]+).*$/\1/p'); do
    echo "mapping input ${XINPUT_ID} to ${TOUCHSCREEN_XRANDR_ID}"
    xinput map-to-output "${XINPUT_ID}" "${TOUCHSCREEN_XRANDR_ID}"
done

export TOUCHSCREEN_VIRTUAL_KEYBOARD_XINPUT_ID="$(xinput | grep CVTE | grep "${TOUCHSCREEN_VIRTUAL_KEYBOARD_XINPUT_NAME}" | sed -rn 's/.*id=([0-9]+).*$/\1/p')"
echo "disabling virtual keyboard ${TOUCHSCREEN_VIRTUAL_KEYBOARD_XINPUT_NAME}"
xinput float "${TOUCHSCREEN_VIRTUAL_KEYBOARD_XINPUT_ID}"

echo "done"

