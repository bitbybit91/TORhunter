# TORhunter v2.0
#### <i>**The Nightmare of TOR Browser - Enhanced Edition**</i>

🎯 **v2.0 UPDATES**: Full v3 Onion Support | Enhanced THC-Hydra Integration | Improved Documentation

៚ Designed to scan and exploit vulnerabilities within Tor hidden services. TORhunter allows most security tools to work seamlessly while resolving both v2 and v3 .onion addresses through an intelligent proxy system.

៚ TOR Browser security toolkit designed specifically for security research and educational purposes. 

## ⚠️ WARNING:
**EDUCATIONAL PURPOSES ONLY - NEVER USE ILLEGALLY**

- ⚡ This tool requires root privileges and Linux (Debian-based recommended)
- ⛔ NOT compatible with Termux or Android devices  
- 📚 For security research, penetration testing training, and educational use only
- 🎓 Users must obtain proper authorization before testing any systems
- ⚖️ Unauthorized use may violate laws and result in serious legal consequences 

## 🚀 What's New in v2.0

### v3 Onion Address Support
- ✅ Full support for 56-character v3 onion addresses (Next Generation Onion Services)
- ✅ Backward compatible with 16-character v2 onion addresses
- ✅ Automatic detection and handling of both formats
- ✅ Enhanced proxy system with improved stability

### Enhanced THC-Hydra Integration  
- 🔧 Full feature implementation from https://github.com/vanhauser-thc/thc-hydra
- 🔧 Support for 50+ protocols (FTP, SSH, HTTP, MySQL, RDP, VNC, etc.)
- 🔧 Intelligent credential testing with default password databases
- 🔧 Multi-threaded attacks with configurable thread counts
- 🔧 Enhanced result logging and reporting
- 🔧 TOR proxy integration for anonymous brute forcing

### Improved Usability
- 📖 Complete installation guide ([INSTALL.md](INSTALL.md))
- 📖 Comprehensive command reference ([COMMANDS.md](COMMANDS.md))
- 🔄 Dynamic path detection (no manual configuration needed)
- ✅ Better error handling and user feedback
- 🎯 Step-by-step guides for all features

## About This Project

TORhunter is a comprehensive security research toolkit designed for penetration testing of TOR hidden services. The toolkit works by proxying TOR through localhost, allowing industry-standard security tools to operate seamlessly against .onion addresses.

**Key Features**:
- 🎯 Automated workflows requiring minimal user input (< 7 keystrokes per attack)
- 🔄 Seamless integration with professional security tools
- 📊 Comprehensive reporting and logging
- 🛡️ Built for security researchers, from novice to expert
- 🌐 Support for both v2 and v3 onion services 

## Screenshot 
![Screenshot](https://i.postimg.cc/sxzDwL2N/20201121-200541.jpg)

## 🛠️ Tools & Features

### Core Capabilities

#### Reconnaissance & Scanning
* ✅ **Automated TOR Proxy** - Seamless v2/v3 onion address handling
* ✅ **Nmap Integration** - Network mapping through TOR
* ✅ **Full Port Scanning** - Comprehensive service discovery
* ✅ **Custom Port Scanning** - Targeted reconnaissance
* ✅ **Proxychains Support** - Flexible routing options

#### Exploitation & Testing
* ✅ **SQLMap Integration** - Automated SQL injection testing
* ✅ **Nikto Scanner** - Web vulnerability assessment
* ✅ **Uniscan** - Website mapping and vulnerability scanning
* ✅ **THC-Hydra** - 50+ protocol password cracking
  - FTP, SSH, Telnet, HTTP/HTTPS
  - MySQL, PostgreSQL, MSSQL, Oracle
  - RDP, VNC, SMTP, POP3, IMAP
  - SMB, LDAP, and many more

#### Reporting & Utilities
* ✅ **IP Geolocation** - Target location mapping
* ✅ **Anonymous File Sharing** - Secure file transfer
* ✅ **Anonymous Email** - ProtonMail integration
* ✅ **Target Notes** - Built-in documentation system
* ✅ **Result Logging** - Automatic finding storage

## 🎯 Quick Usage Guide

### Basic Workflow

1. **Launch TORhunter**
   ```bash
   sudo ./TORhunter
   ```

2. **Connect to TOR hidden service**
   - Main Menu → `01` (Vigilance/Recon)
   - Select `01` (Connect to TOR/Proxy)
   - Enter onion address: `example3fghdjs4.onion` (v2) or `longaddress56chars.onion` (v3)
   - Enter port: `80` (or leave default)
   - Local port: `8000` (or leave default)

3. **Scan the service**
   - Return to Recon menu
   - Select `03` for quick scan or `04` for full scan

4. **Exploit vulnerabilities**
   - Main Menu → `02` (Vengeance/Exploit)
   - Select appropriate tool:
     - `01` - SQLMap for database testing
     - `02` - Nikto for web vulnerabilities
     - `05` - Hydra for password cracking

5. **Document findings**
   - Press `t` in any menu to open target notes
   - Record discovered vulnerabilities and credentials

### Example: Testing SSH Authentication

```bash
# 1. Connect proxy to target
Main Menu > 01 > 01
Target: target.onion
Port: 22

# 2. Run password attack  
Main Menu > 02 > 05
Target: 127.0.0.1
Port: 22 (or leave empty for auto-scan)

# 3. Check results
Results saved in: ~/TORhunter/loot/hydra-ssh-127.0.0.1.txt
```

### Supported Onion Address Formats

**v2 Onion (16 characters)**:
```
example3fghdjs4.onion
thehiddenwiki.onion
```

**v3 Onion (56 characters)**:
```
thehiddenwiki2345678901234567890123456789012345.onion
protonmailrmez3lotccipshtkleegetolb73fuirgj7r4o4vfu7ozyd.onion
```

Both formats are automatically detected and handled!

## 🔮 Future Enhancements

Planned features for future releases:
* XSSer & XSStrike integration
* Payload Generator/Handler
* Web Crawler
* ClickJacking tester
* Metasploit Framework integration
* BeEF integration
* Site cloner
* Enhanced reporting system


## 🔐 THC-Hydra Integration Details

TORhunter v2.0 includes full integration with [THC-Hydra](https://github.com/vanhauser-thc/thc-hydra), the world's most powerful network login cracker.

### Supported Protocols (50+)

**Network Services**: FTP, SSH, Telnet, SMB, LDAP, RDP, VNC  
**Databases**: MySQL, PostgreSQL, MSSQL, Oracle, MongoDB  
**Web**: HTTP/HTTPS Basic/Digest/NTLM Auth, HTTP Forms  
**Email**: SMTP, POP3, IMAP, IMAP-NTLM  
**Other**: SNMP, Cisco, SOCKS5, Redis, Memcached, and more

### Enhanced Features

- ✅ **TOR Proxy Integration** - All attacks routed through TOR
- ✅ **Default Credentials** - Built-in database of common passwords
- ✅ **Custom Wordlists** - Optimized lists for different services
- ✅ **Multi-threading** - Configurable parallel connections (default: 16)
- ✅ **Timeout Control** - Adjustable timeouts for slow TOR connections
- ✅ **Result Logging** - Automatic saving of successful credentials
- ✅ **Verbose Output** - Real-time attack progress

### How It Works

1. **Automatic Service Detection**: Nmap scans identify running services
2. **Protocol Selection**: Appropriate Hydra module auto-selected
3. **Credential Testing**: Tests default credentials first, then wordlists
4. **TOR Routing**: All connections proxied through TOR for anonymity
5. **Result Storage**: Successful logins saved to `loot/` directory

### Example Attack Workflow

```bash
# Hydra automatically tests these in order:
1. Default credentials (admin:admin, root:toor, etc.)
2. Username as password (admin:admin)
3. Null passwords (admin:)
4. Reversed username (admin:nimda)
5. Custom wordlist combinations

# All through TOR proxy for anonymity
```

## 🏗️ Built With

* **Platform**: [Kali Linux](https://www.kali.org/) (recommended)
* **Shell**: [Bash](https://en.wikipedia.org/wiki/Bash_(Unix_shell)) scripting
* **System Tools**: [C](https://en.wikipedia.org/wiki/C_(programming_language)) for DDoS tools
* **Integration**: [Python](https://en.wikipedia.org/wiki/Python_(programming_language)) tools (SQLMap, etc.)
* **Password Cracking**: [THC-Hydra](https://github.com/vanhauser-thc/thc-hydra)

## 🧪 Testing Environment

**Tested and verified on**:
- ✅ Kali Linux 2020.1 - 2024.x
- ✅ Ubuntu 20.04 LTS, 22.04 LTS
- ✅ Debian 10, 11, 12
- ✅ Parrot OS 4.11+

**TOR Support**:
- ✅ v2 Onion addresses (legacy, 16 characters) - Deprecated by TOR Project
- ✅ v3 Onion addresses (current, 56 characters) - Fully supported

### v3 Onion Technical Details

**What are v3 Onion Services?**

v3 onion addresses are the next-generation hidden services that offer:
- **Better Security**: Ed25519 public keys (vs RSA in v2)
- **Improved Privacy**: Enhanced encryption and authentication
- **Longer Addresses**: 56 characters (vs 16 in v2) for better collision resistance
- **Future-Proof**: v2 addresses deprecated as of October 2021

**Compatibility**:
- Requires TOR version 0.3.2+ (installed automatically)
- Full backward compatibility with v2 addresses
- Automatic format detection in TORhunter

**Example Addresses**:
```
v2 (legacy): 3g2upl4pq6kufc4m.onion (16 chars)
v3 (current): thehiddenwiki2345678901234567890123456789012345.onion (56 chars)
```



<!-- GETTING STARTED -->
## Getting Started

!!!MAKE SURE TO INSTALL TORHUNTER FOLDER IN YOUR ROOT DIRECTORY!!!

## 📋 Prerequisites

### System Requirements
* **Operating System**: Kali Linux, Ubuntu 20.04+, Debian 10+, or Parrot OS
* **Privileges**: Root/sudo access required
* **RAM**: 2GB minimum, 4GB recommended
* **Disk Space**: 2GB free space

### Core Dependencies
All dependencies are automatically installed by the installation script:

* **TOR** - The Onion Router (v0.3.2+ for v3 onion support)
* **THC-Hydra** - Password cracking tool
* **Nmap** - Network scanner
* **SQLMap** - SQL injection tool
* **Nikto** - Web server scanner
* **Uniscan** - Website vulnerability scanner
* **Terminator** - Terminal emulator
* **Socat** - Socket proxy utility
* **Proxychains4** - Proxy routing
* **Python 3** - Runtime environment
* **GCC** - C compiler (for DDoS tools)

## 🚀 Quick Start Installation

### One-Command Installation

```bash
# Clone, install, and run
sudo git clone https://github.com/bitbybit91/TORhunter && cd TORhunter && sudo chmod +x install.sh && sudo ./install.sh
```

### Step-by-Step Installation

1. **Clone the repository**
   ```bash
   sudo git clone https://github.com/bitbybit91/TORhunter
   ```

2. **Navigate to directory**
   ```bash
   cd TORhunter
   ```

3. **Make installer executable**
   ```bash
   sudo chmod +x install.sh
   ```

4. **Run the installer**
   ```bash
   sudo ./install.sh
   ```
   
   The installer will:
   - Update system packages
   - Install all dependencies
   - Configure TOR service
   - Compile tools
   - Set permissions
   - Start TOR automatically

5. **Launch TORhunter**
   ```bash
   sudo ./TORhunter
   ```

⏱️ **Installation time**: 5-15 minutes depending on your internet speed

## 📚 Documentation

### Quick Links
- 🚀 **[QUICKSTART.md](QUICKSTART.md)** - Get started in 5 minutes!
- 📦 **[INSTALL.md](INSTALL.md)** - Complete installation guide with troubleshooting  
- 📖 **[COMMANDS.md](COMMANDS.md)** - Full command reference and usage examples
- 📝 **[CHANGELOG.md](CHANGELOG.md)** - Version history and changes
- 📄 **[README.md](README.md)** - This file (project overview)

### Documentation Structure
```
TORhunter/
├── QUICKSTART.md    # 5-minute getting started guide
├── INSTALL.md       # Detailed installation instructions
├── COMMANDS.md      # Complete command reference (17K+ words)
├── CHANGELOG.md     # Version history and roadmap
└── README.md        # Project overview and features
```

## ⚖️ Legal Disclaimer

**IMPORTANT - READ BEFORE USE**

This tool is provided for **EDUCATIONAL AND RESEARCH PURPOSES ONLY**.

### Authorized Use Only
- ✅ Use ONLY on systems you own
- ✅ Use ONLY with explicit written permission from system owners
- ✅ Use for authorized penetration testing and security research
- ✅ Use in isolated lab environments for learning

### Prohibited Use
- ❌ Unauthorized access to computer systems
- ❌ Testing systems without explicit permission
- ❌ Any illegal activity whatsoever
- ❌ Causing harm, disruption, or damage

### Your Responsibility
- You are solely responsible for your actions
- Unauthorized use may violate laws including the Computer Fraud and Abuse Act (CFAA)
- Violations can result in criminal prosecution and civil liability
- Always obtain proper authorization before testing any system

### Developer Liability
The developers of TORhunter:
- Do NOT condone illegal use of this software
- Are NOT responsible for misuse or damage caused by this tool
- Provide this software "AS IS" without warranty
- Encourage responsible and ethical security research

**By using TORhunter, you agree to use it legally and ethically.**

## 🤝 Contributing

We welcome contributions to TORhunter! Here's how you can help:

### Ways to Contribute
- 🐛 Report bugs and issues
- 💡 Suggest new features
- 📖 Improve documentation
- 🔧 Submit pull requests
- ⭐ Star the repository
- 📢 Share with the security community

### Contribution Guidelines
1. Fork the repository
2. Create a feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

### Code of Conduct
- Be respectful and professional
- Focus on constructive feedback
- Help maintain a welcoming environment
- Follow ethical security research practices

## 📜 License

TORhunter is released under the MIT License. See the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- **Original Author**: Err0r_HB ~ HackBoyz
- **THC-Hydra Team**: For the excellent password cracking tool
- **TOR Project**: For the anonymity network
- **Security Community**: For continuous feedback and support
- **All Contributors**: Thank you for your contributions!

## 📊 Project Status

![Version](https://img.shields.io/badge/version-2.0-blue)
![License](https://img.shields.io/badge/license-MIT-green)
![Platform](https://img.shields.io/badge/platform-Linux-lightgrey)
![TOR](https://img.shields.io/badge/TOR-v2%20%7C%20v3-purple)

---

### Original Author Connect:
<a href="https://github.com/Err0r-ICA"><img align="left" alt="codeSTACKr | Github" width="22px" src="https://cdn.jsdelivr.net/npm/simple-icons@v3/icons/github.svg" /></a>
<a href="https://t.me/kalit3rmux"><img align="left" alt="codeSTACKr | Telegram" width="22px" src="https://cdn.jsdelivr.net/npm/simple-icons@v3/icons/telegram.svg" /></a>
<a href="https://www.facebook.com/termuxxhacking"><img align="left" alt="codeSTACKr | Facebook" width="22px" src="https://cdn.jsdelivr.net/npm/simple-icons@v3/icons/facebook.svg" /></a>
<a href="https://instagram.com/termux_hacking"><img align="left" alt="codeSTACKr | Instagram" width="22px" src="https://cdn.jsdelivr.net/npm/simple-icons@v3/icons/instagram.svg" /></a>

<br><br>

<p align="center">
  <img alt="Err0r-ICA' Github Stats" src="https://github-readme-stats.vercel.app/api?username=Err0r-ICA&show_icons=true&include_all_commits=true&hide_border=true" />
<!--  <img alt="profile pic" width="195px" src="https://avatars2.githubusercontent.com/u/26059688?s=460&u=d41b000a62eab50d000c3da604d151cec27bd850&v=4" />  -->
<!--  <img src="https://github-readme-stats.anuraghazra1.vercel.app/api/top-langs/?username=Err0r-ICA&hide=ruby,perl&hide_border=true" />  -->
</p>

<p align="center">
<a href="https://github.com/Err0r-ICA/followers"><img title="Followers" src="https://img.shields.io/github/followers/lovehacker404?color=blue&style=flat-square"></a>
<a href="https://github.com/Err0r-ICA/World/stargazers/"><img title="Stars" src="https://img.shields.io/github/stars/lovehacker404/World?color=red&style=flat-square"></a>
<a href="https://github.com/Err0r-ICA/World/network/members"><img title="Forks" src="https://img.shields.io/github/forks/lovehacker404/World?color=red&style=flat-square"></a>
<a href="https://github.com/Err0r-ICA/World/watchers"><img title="Watching" src="https://img.shields.io/github/watchers/lovehacker404/World?label=Watchers&color=blue&style=flat-square"></a>
</p>

[![Build-passing](https://img.shields.io/badge/build-passing-red.svg?style=plastic)](https://github.com/Err0r-ICA/SpeedTest/issues) [![Stars](https://img.shields.io/open-vsx/stars/Redhat/Java.svg?style=plastic&color=orange)](https://github.com/Err0r-ICA/SpeedTest/issues) [![Coverage](https://img.shields.io/azure-devops/coverage/Swellaby/Opensource/25?color=yellow&style=plastic)](https://github.com/Err0r-ICA/SpeedTest/issues)

[![Maintainers](https://img.shields.io/badge/mainteiners-HackBoyz-green.svg?style=plastic)](https://github.com/Err0r-ICA/SpeedTest/issues) [![coded](https://img.shields.io/badge/coded%20in-bash-mintgreen.svg?style=plastic)](https://github.com/Err0r-ICA/SpeedTest/issues)

[![Status](https://img.shields.io/badge/code%20status-encrypted-cyan.svg?style=plastic)](https://github.com/Err0r-ICA/SpeedTest/issues) [![License](https://img.shields.io/badge/license-MIT-blueviolet.svg?style=plastic)](https://github.com/Err0r-ICA/SpeedTest/issues)

[![Test](https://img.shields.io/badge/tested%20on-Termux,%20Kali%20Linux,%20Ubuntu,%20Parrot%20OS,%20Debian,%20ANDRAX%20Mobile-%23ff69b4.svg?style=plastic)](https://github.com/Err0r-ICA/SpeedTest/issues)
 
