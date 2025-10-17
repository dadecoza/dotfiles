#!/usr/bin/bash
if pgrep -x "direwolf" > /dev/null; then
    # echo "Direwolf is already running. Exiting."
    exit 0
fi
# Kill old processes
sudo pkill -f ax25d || true
sudo pkill -f kissattach || true

/usr/local/bin/direwolf -t 0 -c /etc/direwolf.conf -p &
sleep 5
KISS_SYMLINK="/tmp/kisstnc"
TNC_DEVICE=$(readlink -f "$KISS_SYMLINK")
sudo kissattach "$TNC_DEVICE" radio0 0.0.4.176
sudo kissparms -c 1 -p radio0
sudo ax25d -c /etc/ax25/ax25d.conf -l

