#!/bin/bash
# DDoS Testing Tool - EDUCATIONAL PURPOSES ONLY
# Detect script directory
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

clear
echo "=========================================="
echo "  DDoS Testing Tool (Xerxes)"
echo "=========================================="
echo ""
echo "⚠️  WARNING: For authorized testing ONLY!"
echo "⚠️  Unauthorized DDoS attacks are ILLEGAL!"
echo ""
echo "====================================================================="
echo "EtherApe is a visual tool that will show you information such as"
echo "what you are attacking and at what rate you are attacking." 
echo "---------------------------------------------------------------------"
sleep 1.5
echo "You may also run this script more than once at the same time"
echo "in an effort to be more effective; or choose menu 2 option 6"
echo "====================================================================="
echo ""
echo ""
echo "First, identify open ports using:"
echo "  - Nmap (Menu 1, Option 3)"
echo "  - Full Port Scan (Menu 1, Option 4)"
echo ""
echo "Common ports: 80, 443, 8000, 8080, 22, 21"
echo "---------------------------------------------------------------------"
echo ""
echo "Enter TARGET (default: 127.0.0.1 for TOR proxy):"
read vartarget
vartarget=${vartarget:-127.0.0.1}

echo ""
echo "Enter PORT to attack:"
read varport

if [ -z "$varport" ]; then
    echo "Error: Port is required!"
    exit 1
fi

echo ""
echo "Starting DDoS attack on $vartarget:$varport"
echo "Press Ctrl+C to stop"
echo ""

# Check if ddos binary exists
if [ ! -f "$SCRIPT_DIR/ddos" ]; then
    echo "Error: DDoS tool not compiled!"
    echo "Run: cd $SCRIPT_DIR && gcc ddos.c -o ddos"
    exit 1
fi

sudo "$SCRIPT_DIR/ddos" "$vartarget" "$varport"
