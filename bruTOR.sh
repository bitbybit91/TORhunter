#!/bin/bash
# BruTOR Launcher - Automated Password Cracking for TOR Services
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo "=========================================="
echo "  BruTOR - Password Brute Force Tool"
echo "=========================================="
echo ""
echo "This tool performs automated password attacks on services"
echo "running through the TOR proxy (127.0.0.1)."
echo ""
echo "First, use the Nmap scan (Menu 1, Option 3/4) to identify open ports."
echo "Common ports: 21 (FTP), 22 (SSH), 80 (HTTP), 443 (HTTPS), 8000, 8080"
echo ""
echo "Enter TARGET (default: 127.0.0.1 for TOR proxy):"
read vartarget
vartarget=${vartarget:-127.0.0.1}

echo ""
echo "Enter PORT (leave empty to scan all common ports):"
read varport

echo ""
echo "Starting brute force attack on $vartarget${varport:+:$varport}..."
echo ""

sudo "$SCRIPT_DIR/bruTOR" "$vartarget" "$varport"

echo ""
read -p "Press [Enter] to continue..."
