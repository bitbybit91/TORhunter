# TORhunter Quick Start Guide

Get up and running with TORhunter in 5 minutes!

## ⚡ Fast Installation

```bash
# Clone and install in one command
git clone https://github.com/bitbybit91/TORhunter && cd TORhunter && chmod +x install.sh && sudo ./install.sh
```

Wait 5-15 minutes for installation to complete.

## 🚀 Launch TORhunter

```bash
cd ~/TORhunter
sudo ./TORhunter
```

## 📝 Your First Scan

### Step 1: Connect to a Hidden Service

1. From Main Menu, type `01` (Vigilance/Recon)
2. Type `01` (Connect to TOR/Proxy)
3. Enter onion address: `example.onion`
4. Press Enter for default port (80)
5. Press Enter for default local port (8000)
6. **Keep this window open!**

### Step 2: Scan for Open Ports

1. Open a new TORhunter instance (new terminal)
2. Main Menu → `01` (Recon)
3. Type `03` (Nmap Quick Scan)
4. Note the open ports displayed

### Step 3: Test for Vulnerabilities

From Main Menu:
- Type `02` (Vengeance/Exploit)
- Choose a tool:
  - `02` - Web vulnerabilities (Nikto)
  - `05` - Password cracking (Hydra)
  - `01` - SQL injection (SQLMap)

### Step 4: Document Findings

- Press `t` in any menu
- Add your notes about the target
- Save and exit (Ctrl+X, Y, Enter)

## 🎯 Common Workflows

### Web Application Testing
```
Main → 01 → 01 (Proxy)     # Connect
Main → 02 → 02 (Nikto)     # Scan web
Main → 02 → 01 (SQLMap)    # Test SQL
Main → 02 → 05 (Hydra)     # Crack passwords
```

### SSH Service Testing
```
Main → 01 → 01 (Proxy)     # Connect
Main → 01 → 03 (Scan)      # Find port 22
Main → 02 → 05 (Hydra)     # Crack SSH
```

### Complete Reconnaissance
```
Main → 01 → 01 (Proxy)     # Connect
Main → 01 → 04 (Full Scan) # Deep scan
Main → 02 → 03 (Uniscan)   # Map site
Main → 02 → 02 (Nikto)     # Find vulns
```

## 💡 Quick Tips

1. **Always start proxy first** - Option 01 > 01
2. **Use 127.0.0.1:8000** - This is your proxy endpoint
3. **Keep proxy window open** - Minimize, don't close
4. **Check results in loot/** - All findings saved there
5. **Document everything** - Use the 't' option

## ⚠️ Important Notes

- ✅ Use ONLY on systems you own or have permission to test
- ✅ Scans through TOR are SLOW - be patient
- ✅ Results are in `~/TORhunter/loot/`
- ✅ Press `b` to go back to previous menu
- ✅ Press `q` to quit from main menu

## 🆘 Quick Troubleshooting

**Proxy won't connect?**
```bash
sudo service tor restart
sudo lsof -i :8000  # Check if port is free
```

**Tool not found?**
```bash
cd ~/TORhunter
sudo ./install.sh  # Reinstall
```

**Scan timing out?**
- TOR is slow, wait longer
- Try smaller port ranges
- Check TOR is running: `ps aux | grep tor`

## 📚 Learn More

- **Full Installation Guide**: [INSTALL.md](INSTALL.md)
- **Command Reference**: [COMMANDS.md](COMMANDS.md)
- **Project Info**: [README.md](README.md)
- **Changes**: [CHANGELOG.md](CHANGELOG.md)

## 🔥 Example: Complete Hidden Service Assessment

```bash
# 1. Launch TORhunter
sudo ./TORhunter

# 2. Connect to target (Terminal 1)
Main → 01 → 01
Target: examplexyz123.onion
Port: 80
Local: 8000

# 3. Quick scan (Terminal 2)
sudo ./TORhunter
Main → 01 → 03
# Note: Port 22, 80, 443 open

# 4. Web vulnerability scan
Main → 02 → 02
# Let Nikto run...

# 5. Brute force SSH
Main → 02 → 05
Target: 127.0.0.1
Port: [Enter for auto]
# Let Hydra run...

# 6. Check results
ls ~/TORhunter/loot/
cat ~/TORhunter/loot/hydra-ssh-127.0.0.1.txt

# 7. Document findings
Main → 01 → t
# Add notes, save, exit
```

## ⌨️ Keyboard Shortcuts

- `01`, `02`, `03`, etc. - Select menu option
- `t` - Open target notes
- `b` - Back to main menu
- `q` - Quit (from main menu)
- `Ctrl+C` - Stop current tool
- `Ctrl+Z` - Suspend (not recommended)

## 🎓 Training Scenario

Practice on your own test server:

1. Set up a local web server with vulnerabilities
2. Configure it as a TOR hidden service
3. Use TORhunter to discover and exploit it
4. Document your methodology
5. Learn from the process!

---

**Ready?** Run `sudo ./TORhunter` and start exploring! 🚀

**Need help?** Check the [full documentation](COMMANDS.md) or [troubleshooting guide](INSTALL.md#troubleshooting).

**Remember**: Educational purposes only! 📚⚖️
