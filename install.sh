#!/bin/bash
# TORhunter Installation Script v2.0
# Enhanced with v3 Onion Support and THC-Hydra Integration

echo "=========================================="
echo "  TORhunter Installation Script v2.0"
echo "=========================================="
echo ""
echo "This script will install all required dependencies for TORhunter."
echo "Requires root privileges to install packages."
echo ""

# Check if running as root or with sudo
if [ "$EUID" -ne 0 ]; then 
    echo "Please run with sudo: sudo ./install.sh"
    exit 1
fi

echo "[*] Updating package lists..."
apt-get update

echo ""
echo "[*] Installing core dependencies..."
apt-get install -y \
    terminator \
    nikto \
    python3 \
    python3-pip \
    sqlmap \
    uniscan \
    socat \
    hydra \
    tor \
    nmap \
    torbrowser-launcher \
    etherape \
    proxychains4 \
    gcc \
    make

echo ""
echo "[*] Configuring Tor..."
# Ensure Tor is configured properly
if [ ! -f /etc/tor/torrc.bak ]; then
    cp /etc/tor/torrc /etc/tor/torrc.bak
fi

# Enable SOCKS proxy on port 9050
if ! grep -q "^SocksPort 9050" /etc/tor/torrc; then
    echo "SocksPort 9050" >> /etc/tor/torrc
fi

echo ""
echo "[*] Compiling DDoS tools..."
gcc ddos.c -o ddos 2>/dev/null || echo "Warning: ddos.c compilation failed"
gcc cDDoS.c -o cDDoS 2>/dev/null || echo "Warning: cDDoS.c compilation failed"

echo ""
echo "[*] Setting executable permissions..."
chmod +x proxy.sh cproxy.sh bruTOR.sh bruTOR cport.sh ddos.sh ddos8000.sh ddosx4.sh nmap.sh run.sh sql.sh TORhunter 2>/dev/null

echo ""
echo "[*] Creating necessary directories..."
mkdir -p loot
mkdir -p bin
mkdir -p etc

echo ""
echo "[*] Starting Tor service..."
systemctl enable tor
systemctl start tor

# Wait for Tor to initialize
sleep 5

# Check if Tor is running
if pgrep -x "tor" > /dev/null; then
    echo "[+] Tor service started successfully!"
else
    echo "[!] Warning: Tor service may not be running properly"
    echo "    Try manually: sudo service tor start"
fi

echo ""
echo "=========================================="
echo "  Installation Complete!"
echo "=========================================="
echo ""
echo "To run TORhunter:"
echo "  sudo ./TORhunter"
echo ""
echo "For help and documentation, see:"
echo "  - README.md"
echo "  - INSTALL.md"
echo "  - COMMANDS.md"
echo ""
