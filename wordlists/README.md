# TORhunter Wordlists

This directory contains wordlists used for password cracking and brute force attacks with THC-Hydra and other tools.

## Included Wordlists

### Default Credentials
These files contain common default username/password combinations for various services:

- **ftp-default-userpass.txt** - FTP default credentials
- **ssh-default-userpass.txt** - SSH default credentials
- **telnet-default-userpass.txt** - Telnet default credentials
- **mysql-default-userpass.txt** - MySQL default credentials
- **mssql-default-userpass.txt** - MSSQL default credentials
- **postgres-default-userpass.txt** - PostgreSQL default credentials
- **oracle-default-userpass.txt** - Oracle default credentials
- **windows-default-userpass.txt** - Windows default credentials
- **tomcat-default-userpass.txt** - Tomcat default credentials

### Username Lists
- **simple-users.txt** - Common usernames
- **windows-users.txt** - Windows usernames
- **namelist.txt** / **nameslist.txt** - Name-based usernames

### Password Lists
- **passswords.txt** - Basic password list
- **password.lst** - General password list
- **password_weak.txt** - Weak passwords
- **password_medium.txt** - Medium strength passwords

### Service-Specific Lists
- **ftp_defuser.lst** / **ftp_defpass.lst** - FTP separated lists
- **ssh_defuser.lst** / **ssh_defpass.lst** - SSH separated lists
- **telnet_defuser.lst** / **telnet_defpass.lst** - Telnet separated lists
- **smtp_defuser.lst** / **smtp_defpass.lst** - SMTP separated lists
- **pop_defuser.lst** / **pop_defpass.lst** - POP3 separated lists
- **sql_defuser.lst** / **sql_defpass.lst** - SQL separated lists
- **xmpp_defuser.lst** / **xmpp_defpass.lst** - XMPP separated lists

### Other
- **snmp-strings.txt** - SNMP community strings
- **vnc-default-passwords.txt** - VNC default passwords

## RockYou Wordlist

### What is RockYou?

The **RockYou wordlist** is one of the most famous and comprehensive password lists for security testing. It contains **14+ million real-world passwords** from the RockYou.com data breach in 2009.

**Why use RockYou?**
- Real passwords used by actual users
- Extremely comprehensive (14,344,391 passwords)
- Industry standard for penetration testing
- Effective for password cracking

### Downloading RockYou

The RockYou wordlist is **not included** in this repository due to its large size (~130 MB). However, we provide an easy download script:

#### Quick Download

```bash
# Run the download script
cd ~/TORhunter/wordlists
./download-rockyou.sh
```

The script will:
1. Download the RockYou wordlist from a trusted source
2. Save it as `rockyou.txt` in the wordlists directory
3. Verify the download

#### Manual Download Options

**Option 1: From Kali Linux** (if using Kali):
```bash
# RockYou comes pre-installed on Kali but compressed
sudo gunzip /usr/share/wordlists/rockyou.txt.gz
cp /usr/share/wordlists/rockyou.txt ~/TORhunter/wordlists/
```

**Option 2: Direct Download**:
```bash
cd ~/TORhunter/wordlists
wget https://github.com/brannondorsey/naive-hashcat/releases/download/data/rockyou.txt
```

**Option 3: From SecLists**:
```bash
# Clone SecLists (contains many wordlists including RockYou)
git clone https://github.com/danielmiessler/SecLists.git /tmp/SecLists
cp /tmp/SecLists/Passwords/Leaked-Databases/rockyou.txt.tar.gz ~/TORhunter/wordlists/
cd ~/TORhunter/wordlists
tar -xzf rockyou.txt.tar.gz
```

### Using RockYou with TORhunter

Once downloaded, RockYou can be used with bruTOR:

#### Method 1: Edit bruTOR script
```bash
nano ~/TORhunter/bruTOR

# Change the PASS_FILE variable:
PASS_FILE="$WORDLIST_DIR/rockyou.txt"
```

#### Method 2: Use manually with Hydra
```bash
# SSH brute force with RockYou
export HYDRA_PROXY=socks4://127.0.0.1:9050
hydra -L simple-users.txt -P rockyou.txt 127.0.0.1 ssh -t 16

# HTTP brute force with RockYou
hydra -L simple-users.txt -P rockyou.txt 127.0.0.1 http-get -s 8000 -m /
```

## Creating Custom Wordlists

### From Your Own Data
```bash
# Extract usernames from a file
cat data.txt | grep -oP 'username: \K\w+' > custom-users.txt

# Extract emails and convert to usernames
cat emails.txt | cut -d'@' -f1 > custom-users.txt
```

### Combining Wordlists
```bash
# Combine multiple password lists
cat password_weak.txt password_medium.txt rockyou.txt > mega-passwords.txt

# Remove duplicates
sort -u mega-passwords.txt > unique-passwords.txt
```

### Generating Variations
```bash
# Use tools like crunch or John the Ripper
crunch 8 8 -t password@@@ > password-variations.txt
```

## Wordlist Best Practices

### For Authorized Testing
1. **Start Small**: Begin with default credentials, then weak passwords
2. **Use Appropriate Lists**: Match wordlist to target (e.g., Windows users for Windows systems)
3. **Consider Context**: Industry-specific passwords (healthcare, finance, etc.)
4. **Time Management**: Large wordlists like RockYou take time - use smaller lists first

### Performance Tips
1. **Smaller is Faster**: Start with targeted small lists
2. **Order Matters**: Put most likely passwords first
3. **Remove Duplicates**: `sort -u wordlist.txt > wordlist-unique.txt`
4. **Split Large Files**: For parallel attacks
   ```bash
   split -l 1000000 rockyou.txt rockyou-split-
   ```

### Legal Reminder
⚠️ **Only use wordlists for authorized penetration testing**
- Obtain written permission before testing
- Understand applicable laws and regulations
- Use only on systems you own or have permission to test
- Unauthorized access is illegal

## Wordlist Resources

### Additional Wordlist Collections
- **SecLists**: https://github.com/danielmiessler/SecLists
- **weakpass.com**: https://weakpass.com/wordlist
- **CrackStation**: https://crackstation.net/crackstation-wordlist-password-cracking-dictionary.htm
- **Probable-Wordlists**: https://github.com/berzerk0/Probable-Wordlists

### Password Pattern Tools
- **CUPP** (Common User Passwords Profiler): Generate targeted wordlists
- **Crunch**: Generate custom wordlists based on patterns
- **John the Ripper**: Password list generation and mangling rules
- **Hashcat**: Rule-based wordlist manipulation

## File Formats

### Colon-Separated (user:pass)
Used by Hydra's `-C` option:
```
admin:admin
root:toor
user:password123
```

### Separate Files
Used by Hydra's `-L` and `-P` options:
```
# users.txt
admin
root
user

# passwords.txt
admin
toor
password123
```

## Updating Wordlists

Keep your wordlists current:
```bash
# Backup current wordlists
cp -r ~/TORhunter/wordlists ~/TORhunter/wordlists-backup-$(date +%Y%m%d)

# Update specific lists
wget https://example.com/new-passwords.txt -O password-new.txt
```

---

**Note**: The wordlists included are for educational and authorized security testing only. Always ensure you have proper authorization before conducting any security assessments.
