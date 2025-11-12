# Changelog

All notable changes to TORhunter will be documented in this file.

## [2.1] - 2024-11-12

### 🤖 AutoBot Release - Automated Multi-Target Scanning

This release adds comprehensive automation capabilities for unattended scanning of multiple targets.

### Added

#### AutoBot - Automated Scanning
- ✅ **autobot.sh** - Automated multi-target processing script
- ✅ **AUTOBOT.md** - Complete documentation for automated scanning
- ✅ Unattended operation on target lists from targets.txt
- ✅ Automatic TOR proxy management per target
- ✅ Comprehensive logging and error handling
- ✅ Summary report generation
- ✅ Support for scheduled execution (cron)
- ✅ Integration with all TORhunter tools (nmap, nikto, bruTOR)

#### Features
- Processes multiple targets sequentially
- Automatic proxy setup and teardown
- Configurable timeouts and operations
- Detailed logging to loot/ directory
- Continues processing even if individual targets fail
- Generates comprehensive reports with findings

### Updated
- README.md - Added AutoBot documentation and workflow
- Documentation structure - Added AUTOBOT.md reference

## [2.0] - 2024-11-10

### 🎉 Major Release - v3 Onion Support & THC-Hydra Integration

This release represents a complete overhaul of TORhunter with modern features, enhanced security tool integration, and comprehensive documentation.

### Added

#### v3 Onion Address Support
- ✅ Full support for 56-character v3 onion addresses (Next Generation Onion Services)
- ✅ Automatic detection of v2 (16-char) vs v3 (56-char) addresses
- ✅ Enhanced proxy system for better v3 compatibility
- ✅ Improved error handling for connection issues
- ✅ User-friendly prompts explaining address formats

#### Enhanced THC-Hydra Integration
- ✅ Complete integration with THC-Hydra functionality
- ✅ Support for 50+ protocols including:
  - Network: FTP, SSH, Telnet, SMB, RDP, VNC
  - Databases: MySQL, PostgreSQL, MSSQL, Oracle
  - Web: HTTP/HTTPS Basic Auth, Form-based authentication
  - Email: SMTP, POP3, IMAP
  - Other: SNMP, LDAP, Redis, Memcached
- ✅ Intelligent protocol detection based on open ports
- ✅ Default credential testing before wordlist attacks
- ✅ Multi-threading support (configurable, default: 16 threads)
- ✅ Timeout control for slow TOR connections
- ✅ Enhanced result logging with automatic file saving
- ✅ Verbose output showing real-time attack progress
- ✅ TOR proxy integration for all attacks

#### Documentation
- ✅ **INSTALL.md** - Complete installation guide
  - System requirements
  - Step-by-step installation
  - Dependency information
  - Troubleshooting section
  - Post-installation configuration
- ✅ **COMMANDS.md** - Comprehensive command reference
  - Full menu navigation guide
  - Detailed tool explanations
  - Usage examples for each feature
  - THC-Hydra integration details
  - Advanced usage workflows
  - Tips and best practices
- ✅ **Updated README.md**
  - v3 onion support information
  - Enhanced feature list
  - Quick start guide
  - Usage examples
  - THC-Hydra capabilities

#### Script Improvements
- ✅ Dynamic path detection (no more hardcoded paths!)
- ✅ Automatic SCRIPT_DIR variable in all scripts
- ✅ Removed manual username configuration requirement
- ✅ Better error messages and user guidance
- ✅ Input validation for all user inputs
- ✅ Graceful handling of missing dependencies
- ✅ Improved status messages and progress indicators

#### Enhanced Tools

**proxy.sh**:
- Added v3 onion detection
- Custom port selection
- Better connection status messages
- Validation for onion addresses
- Configurable local and remote ports

**bruTOR**:
- Complete rewrite with modern bash practices
- Dependency checking before execution
- Dynamic wordlist paths
- Enhanced port scanning with more protocols
- Improved result parsing and display
- Better error handling and recovery
- Support for TOR proxy environment variables

**bruTOR.sh**:
- Interactive target selection
- Optional port specification
- Better user prompts and guidance

**install.sh**:
- Automatic dependency installation
- TOR configuration setup
- Service management (enable/start)
- Better error reporting
- Post-installation verification
- No manual path editing required

**cport.sh**:
- Docker support detection
- Fallback to proxychains+nmap
- Better port specification
- v2/v3 onion examples

**cproxy.sh**:
- Advanced proxy configuration
- Custom port selection
- SOCKS port configuration
- Better target parsing

**ddos.sh, ddos8000.sh, ddosx4.sh**:
- Dynamic path detection
- Better warnings and legal notices
- Improved error handling

### Changed

#### Core Functionality
- **Path Handling**: All scripts now use dynamic path detection
- **User Experience**: Clearer prompts and better feedback
- **Error Messages**: More informative error messages with solutions
- **TOR Integration**: Improved TOR service management
- **Wordlists**: Better organized wordlist structure

#### Security
- ✅ No hardcoded credentials
- ✅ Better input validation
- ✅ Improved error handling prevents information leakage
- ✅ Clear warnings about legal usage

### Fixed

#### Bugs
- Fixed hardcoded `/home/YOUR_USER_NAME/` paths
- Fixed broken path references in all menu options
- Fixed TOR Browser launcher paths
- Fixed proxy connection issues
- Fixed port variable assignment bugs in bruTOR
- Fixed missing dependency checks

#### Compatibility
- Better support for different Linux distributions
- Improved TOR Browser detection
- Fallback options when tools are missing
- Better handling of different TOR configurations

### Deprecated
- Manual username configuration (now automatic)
- Hardcoded path structure
- Old v2-only proxy code

### Security Notes

This release includes several security improvements:
1. All user input is now validated
2. No credentials are hardcoded in scripts
3. Better separation of sensitive data
4. Improved logging security
5. Clear warnings about legal usage throughout

### Migration Guide

For users upgrading from v1.x:

1. **No manual configuration needed**: The new installer handles everything
2. **Existing wordlists preserved**: Your custom wordlists in `wordlists/` are safe
3. **Results location unchanged**: The `loot/` directory structure remains the same
4. **New documentation**: Check INSTALL.md and COMMANDS.md for new features

### Breaking Changes

None - v2.0 is fully backward compatible with v1.x workflows.

### Contributors

- Original Author: Err0r_HB ~ HackBoyz
- v2.0 Enhancement: Enhanced for v3 onion support and THC-Hydra integration
- THC-Hydra: https://github.com/vanhauser-thc/thc-hydra

### Acknowledgments

- THC-Hydra team for the excellent password cracking tool
- TOR Project for the anonymity network
- Original TORhunter contributors
- Security research community

---

## [1.9] - 2020-01-08

### Added
- Full Port Scan functionality
- Custom Port Scan option
- Custom Proxy configuration

### Changed
- Updated menu system
- Improved stability

---

## [1.0] - 2020

### Initial Release

- Basic TOR proxy functionality
- Nmap integration
- SQLMap integration
- Nikto scanner
- Uniscan integration
- Basic brute force (BruteX)
- DDoS tools
- Target notes system

---

## Future Roadmap

Planned features for future releases:

### Version 2.1 (Planned)
- [ ] XSSer integration
- [ ] XSStrike integration
- [ ] Enhanced web crawling
- [ ] Improved reporting system

### Version 2.2 (Planned)
- [ ] Metasploit Framework integration
- [ ] BeEF integration
- [ ] Site cloning capabilities
- [ ] Phishing toolkit

### Version 3.0 (Long-term)
- [ ] GUI interface option
- [ ] Automated report generation
- [ ] Machine learning for vulnerability detection
- [ ] Enhanced payload generation
- [ ] Bot net management (for authorized testing)

---

## Versioning

TORhunter uses [Semantic Versioning](https://semver.org/):
- **Major version**: Breaking changes or major feature additions
- **Minor version**: New features, backward compatible
- **Patch version**: Bug fixes and minor improvements

---

## Support

For issues, questions, or contributions:
- GitHub Issues: https://github.com/bitbybit91/TORhunter/issues
- Documentation: README.md, INSTALL.md, COMMANDS.md

---

**Remember**: TORhunter is for EDUCATIONAL PURPOSES ONLY. Always obtain proper authorization before testing any systems.
