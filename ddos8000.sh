#!/bin/bash
# Quick DDoS on port 8000 - EDUCATIONAL ONLY
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
sudo "$SCRIPT_DIR/ddos" 127.0.0.1 8000 
