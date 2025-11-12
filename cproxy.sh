#!/bin/bash
# Custom Proxy Setup - Advanced proxy configuration with v3 onion support

echo "=========================================="
echo "  Custom TOR Proxy Configuration"
echo "=========================================="
echo ""

echo "Connecting to TOR..."
service tor start
sleep 2
clear

echo -e "\e[32mTOR Connected!\e[0m"
echo ""
echo -e "\e[5m!!! Keep this terminal running to maintain proxy connection !!!\e[0m"
echo -e "\e[0m"
echo -e "\e[45m===== Minimizing this terminal is recommended =====\e[0m" 
echo -e "\e[0m"
echo ""

echo "=========================================="
echo "Custom Proxy Configuration"
echo "=========================================="
echo ""
echo "TARGET FORMAT EXAMPLES:"
echo "  Standard:  example3fghdjs4.onion:80"
echo "  v3 Onion:  long56characteronionaddress.onion:443"
echo "  SQL Test:  site.com/vuln.php?id=1:80"
echo ""
echo "NOTE: Include port in format 'address:port'"
echo "=========================================="
echo ""
echo "Enter TARGET URL with PORT (format: address:port):"
read vartarget

# Parse target and port if provided in format address:port
if [[ "$vartarget" == *":"* ]]; then
    # Already has port specified
    target_addr=$(echo "$vartarget" | cut -d':' -f1)
    target_port=$(echo "$vartarget" | cut -d':' -f2)
    echo ""
    echo "Parsed - Address: $target_addr, Port: $target_port"
else
    # No port specified, ask for it
    target_addr="$vartarget"
    echo ""
    echo "Enter TARGET PORT:"
    read target_port
fi

echo ""
echo "Enter LOCAL LISTEN PORT (default: 8000):"
read local_port
local_port=${local_port:-8000}

echo ""
echo "Enter TOR SOCKS PORT (default: 9050):"
read socks_port
socks_port=${socks_port:-9050}

echo ""
echo -e "\e[32mStarting custom proxy...\e[0m"
echo "Configuration:"
echo "  Local:  127.0.0.1:$local_port"
echo "  TOR:    127.0.0.1:$socks_port"
echo "  Target: $target_addr:$target_port"
echo ""
echo -e "\e[33mAccess via: http://127.0.0.1:$local_port\e[0m"
echo -e "\e[33mPress Ctrl+C to stop\e[0m"
echo ""

# Start socat with custom configuration
sudo socat TCP4-LISTEN:$local_port,reuseaddr,fork SOCKS4A:127.0.0.1:$target_addr:$target_port,socksport=$socks_port

