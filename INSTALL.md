# TORhunter Installation Guide

Complete step-by-step installation guide for TORhunter v2.0

## Table of Contents
- [System Requirements](#system-requirements)
- [Supported Operating Systems](#supported-operating-systems)
- [Dependencies](#dependencies)
- [Installation Steps](#installation-steps)
- [Post-Installation Configuration](#post-installation-configuration)
- [Troubleshooting](#troubleshooting)

## System Requirements

### Minimum Requirements
- **OS**: Linux (Debian-based recommended)
- **RAM**: 2GB minimum, 4GB recommended
- **Disk Space**: 2GB free space
- **Privileges**: Root/sudo access required
- **Network**: Internet connection for installation

### Recommended Systems
- Kali Linux 2020.1 or newer
- Ubuntu 20.04 LTS or newer
- Debian 10 or newer
- Parrot OS 4.11 or newer

## Supported Operating Systems

TORhunter has been tested and confirmed working on:
- ✅ Kali Linux
- ✅ Ubuntu
- ✅ Debian
- ✅ Parrot OS
- ⚠️ Other Linux distributions (may require manual dependency installation)

**Note**: TORhunter is NOT compatible with Termux or Android devices.

## Dependencies

TORhunter requires the following packages:

### Core Dependencies
```bash
- terminator          # Terminal emulator
- tor                 # The Onion Router
- proxychains4        # Proxy chains for routing
- socat               # Socket CAT for proxy tunneling
- nmap                # Network mapper
- hydra               # THC-Hydra password cracker
```

### Security Tools
```bash
- sqlmap              # SQL injection tool
- nikto               # Web server scanner
- uniscan             # Web vulnerability scanner
- etherape            # Network monitor
```

### Development Tools
```bash
- python3             # Python 3.x
- python3-pip         # Python package manager
- gcc                 # GNU C Compiler
- make                # Build automation
```

### Optional
```bash
- torbrowser-launcher # Tor Browser
```

## Installation Steps

### Step 1: Clone the Repository

Open a terminal and navigate to your preferred installation directory:

```bash
# Navigate to home directory (or choose your preferred location)
cd ~

# Clone the repository
sudo git clone https://github.com/bitbybit91/TORhunter.git

# Change to TORhunter directory
cd TORhunter
```

**Note**: Installing in your home directory is recommended for easier path management.

### Step 2: Make Installation Script Executable

```bash
# Give execute permissions to the installer
sudo chmod +x install.sh
```

### Step 3: Run the Installer

```bash
# Run the installation script with sudo
sudo ./install.sh
```

The installer will:
1. Update your package lists
2. Install all required dependencies
3. Configure Tor service
4. Compile DDoS tools
5. Set proper file permissions
6. Create necessary directories
7. Start Tor service

**Installation time**: Approximately 5-15 minutes depending on your internet speed.

### Step 4: Verify Installation

After installation completes, verify that Tor is running:

```bash
# Check Tor service status
sudo service tor status

# Or use systemctl
sudo systemctl status tor
```

You should see output indicating Tor is "active (running)".

### Step 5: Test Tor Connection

```bash
# Test Tor proxy
curl --socks5-hostname 127.0.0.1:9050 https://check.torproject.org/api/ip
```

This should return a JSON response with a different IP address than your actual IP.

## Post-Installation Configuration

### Configure Proxychains (Optional but Recommended)

Edit the proxychains configuration:

```bash
sudo nano /etc/proxychains4.conf
```

Ensure these settings are present at the end of the file:

```
[ProxyList]
socks4 127.0.0.1 9050
```

### Create Targets File

Create or edit the targets file to keep track of your investigation targets:

```bash
nano ~/TORhunter/targets.txt
```

Add your onion addresses (one per line):
```
example3fghdjs4.onion
thehiddenwiki2345678901234567890123456789012345.onion
```

### Customize Wordlists (Optional)

TORhunter includes default wordlists in the `wordlists/` directory. You can:

1. **View existing wordlists**:
   ```bash
   ls -la ~/TORhunter/wordlists/
   ```

2. **Download RockYou wordlist** (Recommended):
   ```bash
   # Download the famous RockYou wordlist (14+ million passwords)
   cd ~/TORhunter/wordlists
   ./download-rockyou.sh
   ```
   
   The RockYou wordlist is the industry standard for password cracking and provides comprehensive coverage. See `wordlists/README.md` for more details.

3. **Add custom wordlists**:
   ```bash
   # Copy your wordlists to the wordlists directory
   cp /path/to/your/wordlist.txt ~/TORhunter/wordlists/
   ```

4. **Edit default passwords**:
   ```bash
   nano ~/TORhunter/wordlists/passswords.txt
   ```

## Running TORhunter

After successful installation, run TORhunter:

```bash
# Navigate to TORhunter directory
cd ~/TORhunter

# Run TORhunter with sudo
sudo ./TORhunter
```

## Troubleshooting

### Issue: Tor Service Won't Start

**Symptoms**: Error message "Tor service failed to start"

**Solutions**:
```bash
# Check if another Tor process is running
ps aux | grep tor

# Kill existing Tor processes
sudo killall tor

# Restart Tor service
sudo service tor restart

# Check Tor logs
sudo journalctl -u tor -f
```

### Issue: Permission Denied Errors

**Symptoms**: "Permission denied" when running scripts

**Solutions**:
```bash
# Ensure you're running with sudo
sudo ./TORhunter

# Or set execute permissions manually
sudo chmod +x TORhunter proxy.sh bruTOR bruTOR.sh nmap.sh sql.sh
```

### Issue: Hydra Not Found

**Symptoms**: "hydra: command not found"

**Solutions**:
```bash
# Install hydra manually
sudo apt-get update
sudo apt-get install hydra

# Or install from source (if APT version doesn't work)
cd /tmp
git clone https://github.com/vanhauser-thc/thc-hydra
cd thc-hydra
./configure
make
sudo make install
```

### Issue: Dependencies Missing

**Symptoms**: Various tools not found during execution

**Solutions**:
```bash
# Reinstall all dependencies
sudo apt-get update
sudo apt-get install -y terminator nikto python3 python3-pip sqlmap uniscan socat hydra tor nmap torbrowser-launcher etherape proxychains4 gcc make

# Check which tools are missing
which nmap sqlmap hydra nikto uniscan
```

### Issue: Terminator Not Opening

**Symptoms**: New terminals don't open when selecting menu options

**Solutions**:
```bash
# Install terminator
sudo apt-get install terminator

# Or use an alternative terminal (edit TORhunter script)
# Replace 'terminator' with 'gnome-terminal' or 'xterm'
```

### Issue: v3 Onion Addresses Not Working

**Symptoms**: Cannot connect to 56-character onion addresses

**Solutions**:
```bash
# Ensure Tor is up to date (v3 support requires Tor 0.3.2+)
tor --version

# Update Tor if needed
sudo apt-get update
sudo apt-get upgrade tor

# Check Tor configuration
sudo nano /etc/tor/torrc
# Ensure: SocksPort 9050

# Restart Tor
sudo service tor restart
```

### Issue: Proxy Connection Fails

**Symptoms**: "Connection refused" or timeout errors

**Solutions**:
```bash
# Verify Tor SOCKS port is open
netstat -ln | grep 9050

# Test manual connection
curl --socks5-hostname 127.0.0.1:9050 https://check.torproject.org

# Check if socat is installed
which socat

# Restart proxy
sudo service tor restart
```

### Issue: Port 8000 Already in Use

**Symptoms**: "Address already in use" when starting proxy

**Solutions**:
```bash
# Find process using port 8000
sudo lsof -i :8000

# Kill the process (replace PID with actual process ID)
sudo kill -9 PID

# Or use a different local port in proxy.sh
```

## Getting Help

If you encounter issues not covered here:

1. **Check the main README**: `README.md`
2. **Review command documentation**: `COMMANDS.md`
3. **Check GitHub Issues**: https://github.com/bitbybit91/TORhunter/issues
4. **Verify all dependencies are installed**: Run `install.sh` again
5. **Check system logs**: `sudo journalctl -xe`

## Uninstallation

To remove TORhunter:

```bash
# Stop Tor service
sudo service tor stop

# Remove TORhunter directory
cd ~
sudo rm -rf TORhunter

# Optional: Remove dependencies (only if not used by other tools)
sudo apt-get remove --purge tor hydra sqlmap nikto uniscan
sudo apt-get autoremove
```

## Security Notes

⚠️ **Important Security Reminders**:

1. **Educational Purposes Only**: TORhunter is for legal security research and education
2. **Legal Authorization Required**: Only test systems you own or have explicit permission to test
3. **Log Files**: Results are saved in the `loot/` directory - handle with care
4. **Credentials**: Any discovered credentials should be reported responsibly
5. **Traffic**: All attacks generate network traffic that can be logged

## Next Steps

After successful installation:

1. Read the [Commands Guide](COMMANDS.md) to learn how to use TORhunter
2. Review the main [README](README.md) for feature overview
3. Configure your target list in `targets.txt`
4. Start with reconnaissance features before attempting exploitation

---

**Installation complete!** You're now ready to use TORhunter for security research.
