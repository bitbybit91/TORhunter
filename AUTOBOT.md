# TORhunter AutoBot Documentation

## Overview

TORhunter AutoBot is an automated scanning and exploitation tool that processes targets from `targets.txt` without manual interaction. It automatically executes reconnaissance, vulnerability scanning, and password attacks on multiple onion addresses.

## Features

- ✅ **Automated Processing** - Runs unattended on target list
- ✅ **Multi-Target Support** - Processes all targets in targets.txt
- ✅ **TOR Proxy Management** - Automatically sets up and tears down proxies
- ✅ **Comprehensive Scanning** - Port scanning, vulnerability detection, brute force
- ✅ **Result Logging** - Detailed logs and reports in loot/ directory
- ✅ **Error Handling** - Continues processing even if individual targets fail
- ✅ **Summary Reports** - Generates comprehensive reports after completion

## Installation

AutoBot is included with TORhunter v2.0. No additional installation needed.

```bash
# Ensure TORhunter is installed
cd ~/TORhunter
sudo ./install.sh

# AutoBot is ready to use
./autobot.sh
```

## Configuration

### Target List

Add targets to `targets.txt` (one per line):

```bash
nano ~/TORhunter/targets.txt
```

Example content:
```
# Target list for AutoBot
example3fghdjs4.onion
thehiddenwiki2345678901234567890123456789012345.onion
another-site.onion
```

**Format Rules**:
- One onion address per line
- Lines starting with `#` are comments (ignored)
- Empty lines are ignored
- Must end with `.onion`
- Both v2 (16-char) and v3 (56-char) addresses supported

### Script Configuration

Edit `autobot.sh` to customize behavior:

```bash
nano ~/TORhunter/autobot.sh
```

**Available Options**:
```bash
ENABLE_PROXY=true          # Enable/disable proxy setup
ENABLE_SCAN=true           # Enable/disable port scanning
ENABLE_VULN_SCAN=true      # Enable/disable vulnerability scanning
ENABLE_BRUTE_FORCE=true    # Enable/disable password attacks
PROXY_PORT=8000            # Local proxy port
SCAN_TIMEOUT=300           # Scan timeout in seconds (5 min)
BRUTE_TIMEOUT=600          # Brute force timeout (10 min)
```

## Usage

### Basic Usage

```bash
# Run AutoBot
cd ~/TORhunter
sudo ./autobot.sh
```

### Running in Background

```bash
# Run in background with nohup
cd ~/TORhunter
nohup sudo ./autobot.sh > autobot-output.log 2>&1 &

# Check status
ps aux | grep autobot.sh

# View live output
tail -f autobot-output.log
```

### Scheduled Execution (Cron)

Run AutoBot automatically at scheduled intervals:

```bash
# Edit crontab
sudo crontab -e

# Add entry to run every hour
0 * * * * cd /home/YOUR_USERNAME/TORhunter && ./autobot.sh >> /home/YOUR_USERNAME/TORhunter/loot/autobot-cron.log 2>&1

# Run every 6 hours
0 */6 * * * cd /home/YOUR_USERNAME/TORhunter && ./autobot.sh >> /home/YOUR_USERNAME/TORhunter/loot/autobot-cron.log 2>&1

# Run daily at 2 AM
0 2 * * * cd /home/YOUR_USERNAME/TORhunter && ./autobot.sh >> /home/YOUR_USERNAME/TORhunter/loot/autobot-cron.log 2>&1
```

### Using with Screen/Tmux

For long-running sessions:

```bash
# Using screen
screen -S torhunter-autobot
cd ~/TORhunter
sudo ./autobot.sh
# Press Ctrl+A then D to detach

# Reattach later
screen -r torhunter-autobot

# Using tmux
tmux new -s torhunter-autobot
cd ~/TORhunter
sudo ./autobot.sh
# Press Ctrl+B then D to detach

# Reattach later
tmux attach -t torhunter-autobot
```

## Workflow

AutoBot follows this automated workflow for each target:

```
1. Load targets from targets.txt
2. For each target:
   a. Setup TOR proxy (target.onion:80 → 127.0.0.1:8000)
   b. Port scan with nmap
   c. Vulnerability scan with Nikto
   d. Password attacks with THC-Hydra (bruTOR)
   e. Stop proxy
   f. Move to next target
3. Generate summary report
4. Exit
```

## Output and Results

### Log Files

AutoBot creates several log files in the `loot/` directory:

```
loot/
├── autobot-YYYYMMDD-HHMMSS.log          # Main execution log
├── autobot-report-YYYYMMDD-HHMMSS.txt   # Summary report
├── nmap-target.xml                       # Nmap XML results
├── nmap-target.txt                       # Nmap text results
├── nikto-target.txt                      # Nikto scan results
├── bruteforce-target.log                 # Brute force log
├── hydra-protocol-127.0.0.1.txt         # Successful credentials
└── proxy-target.log                      # Proxy logs
```

### Report Contents

The summary report includes:
- Execution timestamp
- Number of targets processed
- Port scan results
- Open ports for each target
- Discovered credentials
- Success/failure statistics

### Viewing Results

```bash
# View latest log
ls -lt ~/TORhunter/loot/autobot-*.log | head -1 | xargs cat

# View latest report
ls -lt ~/TORhunter/loot/autobot-report-*.txt | head -1 | xargs cat

# Search for successful logins
grep -r "login:" ~/TORhunter/loot/hydra-*.txt

# View specific target results
cat ~/TORhunter/loot/nmap-example-onion.txt
```

## Advanced Usage

### Custom Target Processing

Create a custom targets file:

```bash
# Create specialized target list
cat > ~/TORhunter/targets-high-priority.txt << EOF
high-value-target1.onion
high-value-target2.onion
EOF

# Modify autobot.sh to use it
TARGETS_FILE="$SCRIPT_DIR/targets-high-priority.txt"
```

### Parallel Execution

Process multiple target lists simultaneously:

```bash
# Terminal 1
cd ~/TORhunter
TARGETS_FILE=targets-list1.txt ./autobot.sh

# Terminal 2
cd ~/TORhunter
TARGETS_FILE=targets-list2.txt ./autobot.sh
```

### Integration with Other Tools

```bash
# Export findings to another format
cd ~/TORhunter/loot
for xml in nmap-*.xml; do
    xsltproc $xml > ${xml%.xml}.html
done

# Send report via email
mail -s "TORhunter AutoBot Report" user@example.com < autobot-report-*.txt
```

## Troubleshooting

### AutoBot Won't Start

**Problem**: Script exits immediately

**Solutions**:
```bash
# Check dependencies
which tor nmap hydra nikto socat

# Install missing dependencies
sudo ./install.sh

# Check TOR service
sudo service tor status
sudo service tor start
```

### No Targets Found

**Problem**: "No valid .onion addresses found"

**Solutions**:
```bash
# Check targets.txt exists
ls -l ~/TORhunter/targets.txt

# Verify format
cat ~/TORhunter/targets.txt | grep -v '^#' | grep '\.onion'

# Add sample targets
echo "example.onion" >> ~/TORhunter/targets.txt
```

### Proxy Connection Fails

**Problem**: "Failed to establish proxy"

**Solutions**:
```bash
# Check if port 8000 is in use
sudo lsof -i :8000
sudo pkill -f "TCP4-LISTEN:8000"

# Verify TOR is working
curl --socks5-hostname 127.0.0.1:9050 https://check.torproject.org

# Restart TOR
sudo service tor restart
```

### Scans Timeout

**Problem**: Operations take too long

**Solutions**:
```bash
# Increase timeouts in autobot.sh
SCAN_TIMEOUT=600      # 10 minutes
BRUTE_TIMEOUT=1200    # 20 minutes

# Or disable slow operations
ENABLE_VULN_SCAN=false
ENABLE_BRUTE_FORCE=false
```

### Insufficient Permissions

**Problem**: Permission denied errors

**Solutions**:
```bash
# Run with sudo
sudo ./autobot.sh

# Fix file permissions
chmod +x ~/TORhunter/autobot.sh
chmod 755 ~/TORhunter/loot
```

## Best Practices

### Security

1. **Use Responsibly**: Only scan authorized targets
2. **Secure Logs**: Protect loot/ directory with sensitive data
   ```bash
   chmod 700 ~/TORhunter/loot
   ```
3. **Clean Up**: Remove old logs regularly
   ```bash
   find ~/TORhunter/loot -name "autobot-*" -mtime +30 -delete
   ```

### Performance

1. **Target Selection**: Start with small target lists
2. **Resource Management**: Monitor system resources
   ```bash
   htop  # Monitor CPU/RAM
   ```
3. **Timeout Tuning**: Adjust based on target responsiveness
4. **Parallel Limits**: Don't run too many instances simultaneously

### Reliability

1. **Use Screen/Tmux**: For long-running sessions
2. **Monitor Logs**: Check for errors regularly
3. **Backup Results**: Archive important findings
   ```bash
   tar -czf autobot-results-$(date +%Y%m%d).tar.gz loot/
   ```

## Automation Examples

### Daily Scheduled Scan

```bash
# Create wrapper script
cat > ~/torhunter-daily.sh << 'EOF'
#!/bin/bash
cd /home/YOUR_USERNAME/TORhunter
./autobot.sh
# Email results
mail -s "Daily TORhunter Report $(date)" admin@example.com < loot/autobot-report-*.txt
EOF

chmod +x ~/torhunter-daily.sh

# Add to crontab
sudo crontab -e
# Add: 0 3 * * * /home/YOUR_USERNAME/torhunter-daily.sh
```

### Continuous Monitoring

```bash
# Run in infinite loop with delays
while true; do
    cd ~/TORhunter
    ./autobot.sh
    echo "Scan complete. Waiting 1 hour..."
    sleep 3600
done
```

### Alerting on Findings

```bash
# Monitor for new credentials
watch -n 60 'grep -c "login:" ~/TORhunter/loot/hydra-*.txt'

# Alert script
if grep -q "login:" ~/TORhunter/loot/hydra-*.txt; then
    echo "Credentials found!" | mail -s "TORhunter Alert" admin@example.com
fi
```

## Limitations

- **Speed**: TOR routing is slow; scans take longer than direct connections
- **Detection**: Automated scans may trigger intrusion detection systems
- **Resources**: Multiple targets require significant CPU/memory
- **Rate Limiting**: Some services may block repeated connections

## FAQ

**Q: Can I run AutoBot without root?**
A: Some operations (TOR proxy, nmap) require sudo. Consider using passwordless sudo for automation.

**Q: How long does it take per target?**
A: Typically 15-30 minutes depending on enabled operations and timeouts.

**Q: Can I process hundreds of targets?**
A: Yes, but it will take considerable time. Consider splitting into batches.

**Q: Will AutoBot stop if one target fails?**
A: No, it continues processing remaining targets and logs the failure.

**Q: Can I run AutoBot on multiple machines?**
A: Yes, each instance operates independently with its own target list.

## Updates and Maintenance

Keep AutoBot updated:

```bash
# Check for updates
cd ~/TORhunter
git pull origin main

# Update dependencies
sudo ./install.sh
```

## Support

For issues or questions:
- Check logs in `loot/autobot-*.log`
- Review this documentation
- See main TORhunter documentation: README.md, COMMANDS.md
- Report bugs via GitHub Issues

---

**Remember**: TORhunter AutoBot is for EDUCATIONAL PURPOSES and AUTHORIZED TESTING ONLY. Always obtain proper authorization before scanning any systems.
