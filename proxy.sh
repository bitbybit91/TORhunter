#!/bin/bash
# TORhunter Proxy Setup - Enhanced for v3 Onion Support
# Supports both v2 (16-char) and v3 (56-char) onion addresses

echo "Connecting to TOR..."
sudo service tor start
sleep 2
clear

# Check if Tor is running
if ! pgrep -x "tor" > /dev/null; then
    echo -e "\e[31mError: Tor service failed to start!\e[0m"
    echo "Please ensure Tor is installed: sudo apt-get install tor"
    exit 1
fi

echo -e "\e[32mTor service started successfully!\e[0m"
sleep 1
clear

echo -e "\e[5m!!!Please keep this terminal running in order to maintain connections to TOR & proxy server!!!"
echo -e "\e[0m"
echo -e "\e[45m-----= Minimizing the terminal is suggested =-----\e[0m" 
echo -e "\e[0m"
echo -e "Connecting to TOR...... \e[5m\e[32mCONNECTED!\e[0m"
echo -e "\e[0m"  
echo "================================================================================"
echo "ONION ADDRESS EXAMPLES:"
echo "  v2 (16-char): example3fghdjs4.onion"
echo "  v3 (56-char): thehiddenwiki2345678901234567890123456789012345.onion"
echo ""
echo "For SQL server attacks use: http://www.site.com/vuln.php?id=1"
echo "================================================================================"
echo ""
echo "Enter TARGET ONION URL (without http://):"
read vartarget

# Validate onion address format
if [[ ! "$vartarget" =~ \.onion$ ]]; then
    echo -e "\e[33mWarning: Target doesn't end with .onion, continuing anyway...\e[0m"
fi

# Extract just the domain if full URL provided
if [[ "$vartarget" =~ ^https?:// ]]; then
    vartarget=$(echo "$vartarget" | sed 's~^https\?://~~' | cut -d'/' -f1)
    echo "Extracted domain: $vartarget"
fi

# Determine onion version
if [[ ${#vartarget} -gt 22 ]]; then
    echo -e "\e[36mDetected v3 onion address (56 characters)\e[0m"
else
    echo -e "\e[36mDetected v2 onion address (16 characters)\e[0m"
fi

# Ask for custom port (default 80)
echo ""
echo "Enter TARGET PORT (default: 80, common: 80, 443, 8000, 8080):"
read varport
varport=${varport:-80}

echo ""
echo "Enter LOCAL LISTEN PORT (default: 8000):"
read localport
localport=${localport:-8000}

echo ""
echo -e "\e[32mStarting proxy tunnel...\e[0m"
echo "Local: 127.0.0.1:$localport -> Tor -> $vartarget:$varport"
echo ""
echo -e "\e[33mYou can now access the onion site at: http://127.0.0.1:$localport\e[0m"
echo -e "\e[33mPress Ctrl+C to stop the proxy\e[0m"
echo ""

# Use socat with SOCKS4A for better v3 onion support
sudo socat TCP4-LISTEN:$localport,reuseaddr,fork SOCKS4A:127.0.0.1:$vartarget:$varport,socksport=9050



