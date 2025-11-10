#!/bin/bash
# Custom Port Scanner - Enhanced for v2/v3 Onion Support
# Uses Docker-based onion-nmap for direct onion scanning

echo "=========================================="
echo "  Custom Port Scanner"
echo "=========================================="
echo ""

# Check if Docker is installed
if ! command -v docker &> /dev/null; then
    echo "Docker is not installed. Using proxychains + nmap instead..."
    echo ""
    
    # Fallback to proxychains
    echo "Enter TARGET (onion address or IP):"
    read vartarget
    
    echo ""
    echo "Enter PORTS (e.g., 80,443,8000 or leave empty for common ports):"
    read varports
    
    if [ -z "$varports" ]; then
        varports="21,22,23,25,80,135,139,443,445,3306,3389,5900,8000,8080,8443"
    fi
    
    echo ""
    echo "Starting scan through TOR proxy..."
    proxychains4 nmap -Pn -sT -p "$varports" "$vartarget"
    
else
    # Docker method
    echo "Connecting to TOR..."
    service tor start
    sleep 2
    clear
    
    echo "CONNECTED TO TOR!"
    echo ""
    echo "Starting Docker service..."
    service docker start
    sleep 2
    clear
    
    echo "DOCKER STARTED!"
    echo ""
    echo "=========================================="
    echo "Example formats:"
    echo "  v2: example3fghdjs4.onion"
    echo "  v3: thehiddenwiki2345678901234567890123456789012345.onion"
    echo ""
    echo "Example port specification:"
    echo "  -p 21,22,23,25,80,135,139,443,8080,8000,9050,4444"
    echo "=========================================="
    echo ""
    echo "Enter TARGET (onion address):"
    read vartarget
    
    echo ""
    echo "Enter PORT SPECIFICATION (e.g., -p 80,443 or leave empty for defaults):"
    read portspec
    
    if [ -z "$portspec" ]; then
        portspec="-p 21,22,23,25,80,135,139,443,445,3306,3389,5900,8000,8080"
    fi
    
    echo ""
    echo "Starting Docker-based onion scan..."
    sudo docker run --rm -it milesrichardson/onion-nmap $portspec $vartarget
fi

echo ""
read -p "Press [Enter] to continue..."
