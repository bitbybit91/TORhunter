# TORhunter Commands Guide

Complete command reference and usage guide for TORhunter v2.0

## Table of Contents
- [Getting Started](#getting-started)
- [Main Menu Overview](#main-menu-overview)
- [Vigilance/Recon Menu](#vigilancerecon-menu)
- [Vengeance/Exploit Menu](#vengeanceexploit-menu)
- [Verbose/Report Menu](#verbosereport-menu)
- [THC-Hydra Integration](#thc-hydra-integration)
- [Advanced Usage](#advanced-usage)
- [Tips and Best Practices](#tips-and-best-practices)

## Getting Started

### Launching TORhunter

```bash
# Navigate to TORhunter directory
cd ~/TORhunter

# Launch with sudo (required)
sudo ./TORhunter
```

### Understanding the Interface

TORhunter uses a text-based menu system with three main categories:
- **Vigilance/Recon**: Reconnaissance and information gathering
- **Vengeance/Exploit**: Active exploitation and attack tools
- **Verbose/Report**: Reporting and communication tools

Navigate by entering the number or letter of your choice and pressing Enter.

## Main Menu Overview

```
[01] Vigilance/Recon    - Reconnaissance and scanning
[02] Vengeance/Exploit  - Exploitation and attacks
[03] Verbose/Report     - Reporting and utilities
[q]  Quit              - Exit TORhunter
```

### Exiting TORhunter

- Type `q` and press Enter to quit
- Or press `Ctrl+Z` to suspend (not recommended)
- Or press `Ctrl+C` to force quit

## Vigilance/Recon Menu

**Purpose**: Reconnaissance, scanning, and information gathering on TOR hidden services.

### Menu Options

```
[01] Connect to TOR/Proxy (v2/v3 Onion Support)
[02] Disconnect TOR/PROXY
[03] Nmap Quick Scan
[04] Full Port Scan (Proxychains)
[05] Custom Port Scan
[06] Custom Proxy
[t]  Target Notes
[b]  Main Menu
```

---

### Option 01: Connect to TOR/Proxy

**Purpose**: Establish a proxy tunnel to access TOR hidden services locally.

**How it works**: Creates a local proxy that forwards traffic through TOR, allowing you to access .onion sites at `http://127.0.0.1:8000`

**Step-by-step usage**:

1. Select option `01`
2. Enter the onion address (without `http://`)
   - **v2 Example**: `example3fghdjs4.onion`
   - **v3 Example**: `thehiddenwiki2345678901234567890123456789012345.onion`
3. Enter target port (default: 80)
   - Common ports: 80 (HTTP), 443 (HTTPS), 8000, 8080
4. Enter local listen port (default: 8000)
5. Keep the terminal window open

**Example Session**:
```
Enter TARGET ONION URL (without http://):
> example3fghdjs4.onion

Enter TARGET PORT (default: 80, common: 80, 443, 8000, 8080):
> 80

Enter LOCAL LISTEN PORT (default: 8000):
> 8000

Starting proxy tunnel...
Local: 127.0.0.1:8000 -> Tor -> example3fghdjs4.onion:80

You can now access the onion site at: http://127.0.0.1:8000
```

**Accessing the site**:
- Open browser: `http://127.0.0.1:8000`
- Or use other tools against `127.0.0.1:8000`

**Notes**:
- ⚠️ Keep the proxy terminal window open
- Supports both v2 (16-char) and v3 (56-char) onion addresses
- Press `Ctrl+C` in the proxy window to stop

---

### Option 02: Disconnect TOR/PROXY

**Purpose**: Stop the TOR service and close proxy connections.

**Usage**:
```
Select option: 02
```

**What it does**:
- Stops the TOR service
- Closes proxy connections
- Displays confirmation message

**To restart TOR**:
```bash
sudo service tor start
```

---

### Option 03: Nmap Quick Scan

**Purpose**: Quick network scan of the local proxy endpoint.

**Usage**:
```
Select option: 03
```

**What it scans**: `127.0.0.1` (your local proxy)

**Output**: Lists open ports on the proxied service

**Example Output**:
```
PORT     STATE SERVICE
80/tcp   open  http
443/tcp  open  https
8000/tcp open  http-alt
```

---

### Option 04: Full Port Scan (Proxychains)

**Purpose**: Comprehensive port scan through TOR using proxychains.

**Requirements**: Must enter a target onion address

**Step-by-step**:
1. Select option `04`
2. Enter the onion URL
   - Example: `example3fghdjs4.onion`
3. Wait for scan to complete (may take several minutes)

**What it scans**: All common ports through TOR proxy

**Note**: This can be slow due to TOR routing

---

### Option 05: Custom Port Scan

**Purpose**: Scan specific ports through TOR proxy.

**Step-by-step**:
1. Select option `05`
2. Enter target address (usually `127.0.0.1` if proxy is running)
3. Enter specific ports to scan
   - Single port: `80`
   - Multiple ports: `80,443,8000`
   - Port range: `80-100`

---

### Option 06: Custom Proxy

**Purpose**: Set up a custom proxy configuration with specific parameters.

**Use case**: When you need non-default ports or custom configurations.

---

### Option t: Target Notes

**Purpose**: Open a text editor to track target information.

**Usage**:
```
Select option: t
```

**Opens**: `~/TORhunter/targets.txt` in nano editor

**Recommended info to track**:
```
Target: example.onion
Date: 2024-01-01
Open Ports: 80, 443
Services: HTTP, HTTPS
Notes: Login page found at /admin
Credentials: (if found)
```

## Vengeance/Exploit Menu

**Purpose**: Active exploitation and attack tools.

⚠️ **WARNING**: Only use these tools on systems you own or have explicit permission to test.

### Menu Options

```
[01] Database Exploit/Injection (SQLMap)
[02] XSS/Vulnerability Scan (Nikto)
[03] Full Site Mapper (Uniscan)
[04] Directory Scan (Uniscan)
[05] Automated Password Cracking (THC-Hydra)
[06] DDoS (Xerxes)
[07] DDoS (Xerxes x4) Port 8000
[08] Customized DDoS
[t]  Target Notes
[b]  Main Menu
```

---

### Option 01: Database Exploit/Injection (SQLMap)

**Purpose**: Automated SQL injection testing and database exploitation.

**Requirements**: 
- Proxy must be running (Option 01 from Recon menu)
- Target URL with parameters

**Step-by-step**:
1. Ensure proxy is running to target site
2. Select option `01`
3. Enter target URL with parameters
   - Example: `http://127.0.0.1:8000/page.php?id=1`
   - Example: `http://www.site.com/vuln.php?id=1`

**What it does**:
- Tests for SQL injection vulnerabilities
- Attempts to extract database information
- Uses TOR proxy for anonymity
- Saves results to files

**SQLMap Options Used**:
- `--tor`: Route through TOR
- `--time-sec 20`: Timeout per request
- `--crawl=2`: Crawl site for injectable parameters
- `--random-agent`: Randomize user agent

**Example**:
```
Enter TARGET URL:
> http://127.0.0.1:8000/products.php?id=5

[*] Testing parameter 'id' for SQL injection
[*] Injectable parameter found!
[*] Database: MySQL 5.7.32
[*] Extracting tables...
```

---

### Option 02: XSS/Vulnerability Scan (Nikto)

**Purpose**: Web server vulnerability scanner.

**What it scans**:
- Default target: `127.0.0.1:8000` (your proxy)
- Checks for common web vulnerabilities
- Tests for XSS, directory traversal, outdated software

**Usage**:
```
Select option: 02
```

**Output includes**:
- Server information
- Potential vulnerabilities
- Security headers status
- Dangerous files/directories

---

### Option 03: Full Site Mapper (Uniscan)

**Purpose**: Complete website mapping and vulnerability scanning.

**Default target**: `http://127.0.0.1:8000`

**What it does**:
- Discovers all pages and directories
- Tests for common vulnerabilities
- Maps site structure
- Identifies potential injection points

**Scan types performed**:
- Directory enumeration
- File disclosure
- Dynamic testing
- Static testing

---

### Option 04: Directory Scan (Uniscan)

**Purpose**: Quick directory and file enumeration.

**Faster than**: Option 03 (focuses only on directories)

**Use when**: You need quick directory listing without full vulnerability scan.

---

### Option 05: Automated Password Cracking (THC-Hydra)

**Purpose**: Brute force authentication on discovered services.

**This is the enhanced THC-Hydra integration with full feature support!**

**Step-by-step**:
1. First run port scan (Recon Menu, Option 04) to identify services
2. Select option `05`
3. Choose target (default: `127.0.0.1`)
4. Optionally specify port, or leave empty to scan all common ports

**What it does**:
- Scans for open services (FTP, SSH, HTTP, MySQL, etc.)
- Attempts authentication using wordlists
- Tests default credentials first
- Saves successful logins to `loot/` directory

**Supported Protocols**:
- FTP (port 21)
- SSH (port 22)
- Telnet (port 23)
- HTTP/HTTPS (ports 80, 443, 8000, 8080)
- MySQL (port 3306)
- PostgreSQL (port 5432)
- MSSQL (port 1433)
- RDP (port 3389)
- VNC (ports 5900, 5901)
- And more...

**Example Session**:
```
Enter TARGET (default: 127.0.0.1 for TOR proxy):
> 127.0.0.1

Enter PORT (leave empty to scan all common ports):
> [Enter]

[*] Scanning common ports...
[+] Port 22 (SSH) open... running brute force...
[*] Using THC-Hydra with enhanced options
[+] Found valid credentials!
    Login: admin
    Password: admin123
```

**Results location**: `~/TORhunter/loot/hydra-*.txt`

---

### Option 06-08: DDoS Tools

**Purpose**: Denial of Service testing (EDUCATIONAL ONLY)

⚠️ **EXTREME WARNING**: 
- DDoS attacks are ILLEGAL without explicit authorization
- Can cause serious legal consequences
- Only use in isolated lab environments
- Never use against production systems

**Not recommended for general use.**

---

## Verbose/Report Menu

**Purpose**: Reporting, geolocation, and anonymous communication.

### Menu Options

```
[01] Geolocate IP on a Map
[02] File Uploader (Send Link in Email)
[03] Anonymous E-Mail
[t]  Target Notes
[b]  Main Menu
```

### Option 01: Geolocate IP

Opens `https://iplocation.com` to geolocate IP addresses.

### Option 02: File Uploader

Opens anonymous file upload service (filedropper.com) in TOR Browser.

### Option 03: Anonymous E-Mail

Opens ProtonMail onion service in TOR Browser for anonymous communication.

## THC-Hydra Integration

TORhunter v2.0 includes enhanced THC-Hydra integration with full feature support.

### Hydra Features in TORhunter

1. **Automatic Protocol Detection**: Scans ports and selects appropriate attack
2. **Default Credentials**: Tests common default username/password combinations
3. **Custom Wordlists**: Uses optimized wordlists from `wordlists/` directory
4. **TOR Proxy Support**: Routes attacks through TOR for anonymity
5. **Multi-threaded**: Faster attacks with configurable threads
6. **Result Logging**: Saves all findings to `loot/` directory

### Hydra Command Line Options Used

TORhunter uses these enhanced Hydra options:

```bash
-C file            # Colon-separated username:password file
-L file            # Username list
-P file            # Password list
-t threads         # Number of parallel connections (16)
-w timeout         # Timeout per connection (30 seconds)
-e nsr             # Try null, same as username, reversed username as password
-V                 # Verbose output
-o file            # Output file for results
```

### Customizing Wordlists

Located in: `~/TORhunter/wordlists/`

**Available wordlists**:
- `passswords.txt` - Common passwords
- `simple-users.txt` - Common usernames
- `ftp-default-userpass.txt` - FTP defaults
- `ssh-default-userpass.txt` - SSH defaults
- `mysql-default-userpass.txt` - MySQL defaults
- `windows-default-userpass.txt` - Windows defaults
- And more...

**To add custom wordlists**:
```bash
# Copy your wordlist
cp /path/to/custom.txt ~/TORhunter/wordlists/

# Edit bruTOR script to use it
nano ~/TORhunter/bruTOR
# Add: CUSTOM_LIST="$WORDLIST_DIR/custom.txt"
```

### Manual Hydra Commands

You can also use Hydra manually with TOR:

```bash
# Set proxy environment variable
export HYDRA_PROXY=socks4://127.0.0.1:9050

# SSH brute force through TOR
hydra -L users.txt -P passwords.txt 127.0.0.1 ssh -t 16 -V

# HTTP basic auth through TOR
hydra -L users.txt -P passwords.txt 127.0.0.1 http-get -s 8000 -m /admin

# HTTP POST form
hydra -L users.txt -P passwords.txt 127.0.0.1 http-post-form \
  -s 8000 -m "/login:username=^USER^&password=^PASS^:F=failed"
```

## Advanced Usage

### Chaining Tools

**Workflow Example**: Complete reconnaissance to exploitation

```
1. Start TOR Proxy (Recon Menu > 01)
   Target: example.onion
   Port: 80
   Local: 8000

2. Quick Scan (Recon Menu > 03)
   Identifies: Port 80 (HTTP), 22 (SSH)

3. Full Port Scan (Recon Menu > 04)
   Detailed service detection

4. Web Scan (Exploit Menu > 02)
   Find vulnerabilities with Nikto

5. Password Cracking (Exploit Menu > 05)
   Attempt SSH/HTTP authentication

6. SQL Injection (Exploit Menu > 01)
   If web forms found

7. Document findings (Both menus > t)
   Record in targets.txt
```

### Using External Tools with TORhunter Proxy

Once proxy is running, you can use other tools:

```bash
# Using curl
curl http://127.0.0.1:8000

# Using wget
wget http://127.0.0.1:8000/index.html

# Using Firefox with proxy
firefox http://127.0.0.1:8000

# Using dirb for directory brute force
dirb http://127.0.0.1:8000 /usr/share/wordlists/dirb/common.txt

# Using gobuster
gobuster dir -u http://127.0.0.1:8000 -w /path/to/wordlist.txt
```

### Custom Nmap Scans

```bash
# Scan through proxychains
proxychains4 nmap -sT -Pn target.onion

# Service version detection
proxychains4 nmap -sV -Pn target.onion

# Scan specific ports
proxychains4 nmap -p 80,443,8000 -Pn target.onion
```

## Tips and Best Practices

### Reconnaissance Best Practices

1. **Always start passive**: Gather information before active scanning
2. **Document everything**: Use Target Notes (option 't')
3. **Be patient**: TOR routing is slow, scans take time
4. **Multiple passes**: Run scans at different times
5. **Verify results**: False positives are common

### Security Best Practices

1. **Legal authorization**: Only test authorized targets
2. **Use VPN**: Additional layer before TOR (VPN -> TOR)
3. **Clean up**: Delete logs after legitimate testing
4. **Responsible disclosure**: Report findings properly
5. **Educate**: Understand tools before using

### Performance Tips

1. **Keep proxy running**: Don't restart for each tool
2. **Use screen/tmux**: Keep sessions alive
3. **Reasonable threads**: Don't overload (16 threads max for Hydra)
4. **Target specific ports**: Faster than full scans
5. **Use appropriate wordlists**: Smaller = faster

### Troubleshooting Tips

1. **Proxy not working**:
   ```bash
   sudo service tor restart
   sudo lsof -i :8000  # Check if port is free
   ```

2. **Scan timing out**:
   - Increase timeout values
   - Reduce thread count
   - Target specific ports only

3. **Tools not found**:
   ```bash
   sudo ./install.sh  # Reinstall dependencies
   ```

4. **Results not saving**:
   ```bash
   mkdir -p ~/TORhunter/loot
   chmod 777 ~/TORhunter/loot
   ```

## Example Workflow

### Complete Testing Scenario

**Scenario**: Testing a hidden service for security assessment

```
Step 1: Preparation
- Launch TORhunter: sudo ./TORhunter
- Document target: Press 't' > Add target info

Step 2: Connect to Target (Main > 01 > 01)
- Enter onion address: target.onion
- Port: 80
- Local port: 8000
- Keep terminal open

Step 3: Initial Reconnaissance (Main > 01 > 03)
- Quick scan of 127.0.0.1
- Note open ports in targets.txt

Step 4: Service Enumeration (Main > 01 > 04)
- Full port scan
- Identify services and versions

Step 5: Web Vulnerability Scan (Main > 02 > 02)
- Run Nikto scan
- Review findings

Step 6: Directory Discovery (Main > 02 > 04)
- Find hidden directories
- Identify interesting endpoints

Step 7: Authentication Testing (Main > 02 > 05)
- Run Hydra against found services
- Test default credentials
- Try wordlist attacks

Step 8: SQL Injection Testing (Main > 02 > 01)
- Test any forms or parameters
- Attempt extraction if vulnerable

Step 9: Documentation (Main > 01 or 02 > t)
- Record all findings
- Note vulnerabilities
- Save credentials if found

Step 10: Reporting
- Compile findings
- Create remediation recommendations
- Report responsibly
```

## Command Quick Reference

```
Main Menu:
  01 - Vigilance/Recon
  02 - Vengeance/Exploit
  03 - Verbose/Report
  q  - Quit

Recon Menu:
  01 - Connect TOR Proxy
  02 - Disconnect TOR
  03 - Quick Nmap Scan
  04 - Full Port Scan
  05 - Custom Port Scan
  06 - Custom Proxy
  t  - Edit Targets
  b  - Back to Main

Exploit Menu:
  01 - SQLMap
  02 - Nikto
  03 - Uniscan Full
  04 - Uniscan Dirs
  05 - Hydra BruteForce
  06 - DDoS Xerxes
  07 - DDoS x4
  08 - Custom DDoS
  t  - Edit Targets
  b  - Back to Main

Report Menu:
  01 - Geolocate IP
  02 - File Upload
  03 - Anonymous Email
  t  - Edit Targets
  b  - Back to Main
```

## Additional Resources

### THC-Hydra Documentation
- Official: https://github.com/vanhauser-thc/thc-hydra
- Supported protocols: Over 50 protocols supported
- Wiki: Detailed protocol-specific instructions

### Related Documentation
- [Installation Guide](INSTALL.md) - Complete installation instructions
- [README](README.md) - Project overview and features
- [GitHub Issues](https://github.com/bitbybit91/TORhunter/issues) - Report bugs

### Learning Resources
- TOR Project: https://www.torproject.org/
- OWASP Testing Guide: https://owasp.org/
- Penetration Testing Framework: http://www.vulnerabilityassessment.co.uk/Penetration%20Test.html

---

**Remember**: TORhunter is for EDUCATIONAL PURPOSES ONLY. Always obtain proper authorization before testing any systems.
