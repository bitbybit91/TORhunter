#!/usr/bin/env bash
# DDoS x4 - Launch 4 simultaneous attacks - EDUCATIONAL ONLY
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo "⚠️  WARNING: Launching 4 simultaneous DDoS attacks!"
echo "⚠️  For authorized testing ONLY!"
echo ""

sudo terminator -e "sudo $SCRIPT_DIR/ddos8000.sh" &
sudo terminator -e "sudo $SCRIPT_DIR/ddos8000.sh" &
sudo terminator -e "sudo $SCRIPT_DIR/ddos8000.sh" & 
sudo terminator -e "sudo $SCRIPT_DIR/ddos8000.sh" 


