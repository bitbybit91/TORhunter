#!/bin/bash
# Script to download and extract the RockYou wordlist
# The RockYou wordlist contains 14+ million real-world passwords

WORDLIST_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
ROCKYOU_URL="https://github.com/brannondorsey/naive-hashcat/releases/download/data/rockyou.txt"
ROCKYOU_FILE="$WORDLIST_DIR/rockyou.txt"

echo "=========================================="
echo "  RockYou Wordlist Downloader"
echo "=========================================="
echo ""
echo "This will download the famous RockYou wordlist"
echo "Size: ~130 MB (14+ million passwords)"
echo "Source: RockYou.com data breach (2009)"
echo ""

# Check if already exists
if [ -f "$ROCKYOU_FILE" ]; then
    echo "✓ RockYou wordlist already exists at:"
    echo "  $ROCKYOU_FILE"
    echo ""
    echo "File info:"
    ls -lh "$ROCKYOU_FILE"
    echo ""
    read -p "Download again? (y/n): " choice
    if [[ ! "$choice" =~ ^[Yy]$ ]]; then
        echo "Exiting."
        exit 0
    fi
    echo ""
fi

echo "Downloading RockYou wordlist..."
echo "This may take a few minutes depending on your connection..."
echo ""

# Try with wget first, fallback to curl
if command -v wget &> /dev/null; then
    wget -O "$ROCKYOU_FILE" "$ROCKYOU_URL"
elif command -v curl &> /dev/null; then
    curl -L -o "$ROCKYOU_FILE" "$ROCKYOU_URL"
else
    echo "Error: Neither wget nor curl is installed!"
    echo "Please install one of them:"
    echo "  sudo apt-get install wget"
    echo "  or"
    echo "  sudo apt-get install curl"
    exit 1
fi

# Check if download was successful
if [ $? -eq 0 ] && [ -f "$ROCKYOU_FILE" ]; then
    echo ""
    echo "✓ Download complete!"
    echo ""
    echo "RockYou wordlist saved to:"
    echo "  $ROCKYOU_FILE"
    echo ""
    echo "File info:"
    ls -lh "$ROCKYOU_FILE"
    echo ""
    echo "Line count:"
    wc -l "$ROCKYOU_FILE"
    echo ""
    echo "You can now use this wordlist with bruTOR and other tools."
    echo "Example: Edit bruTOR and set PASS_FILE to rockyou.txt"
else
    echo ""
    echo "✗ Download failed!"
    echo "Please check your internet connection and try again."
    echo ""
    echo "Alternative: Download manually from Kali Linux:"
    echo "  sudo gunzip /usr/share/wordlists/rockyou.txt.gz"
    echo "  cp /usr/share/wordlists/rockyou.txt $WORDLIST_DIR/"
    exit 1
fi
