#!/bin/bash

# ASCII Art and Authorship
echo "__________                  __  ___________        ___________"
echo "\\______   \\  ____    ____ _/  |_\\_   _____/___  ___\\_   _____/"
echo " |       _/ /  _ \\  /  _ \\   __\\|    __)_ \\  \\/  / |    __)_ "
echo " |    |   \\(  <_> )(  <_> )|  |  |        \\ >    <  |        \\"
echo " |____|_  / \\____/  \\____/ |__| /_______  //__/\\_ \\/_______  /"
echo "        \\/                              \\/       \\/        \\/"
echo ""
echo "# Author: Ross Brereton (https://www.linkedin.com/in/ross-b-673872107/)"
echo "# Website: https://github.com/msf-Root-ExE"
echo ""

# Change directory to the desktop
cd ~/Desktop

# Prompt user for a project name
read -p "Enter the project name: " project_name

# Create a directory for the project
mkdir "${project_name}"

echo "Directory created successfully. The project directory name is ${project_name}"

# Change directory to the project
cd "${project_name}"

# Create directories
mkdir "nmap" "Evidence" "Notes" "Pre-Reqs" "Web-App"

echo "Directories created successfully. The directory names are nmap, Evidence, Notes, Pre-Reqs, and Web-App."

# Change directory to the "nmap" directory
cd "nmap"

# Create directories called "TCP" and "UDP"
mkdir "TCP" "UDP"

echo "Directories created successfully. The directory names are TCP and UDP."

# Change directory to the "TCP" directory
cd "TCP"

# Prompt user for target IP or hostname
read -p "Enter target IP or hostname: " target

# Run Nmap ping sweep and output live hosts to txt file
echo "Running Nmap ping sweep on target $target..."
ping_sweep=$(nmap -sn $target | grep 'Nmap scan report for' | cut -d ' ' -f 5)

# Check if any live hosts found
if [[ -z "$ping_sweep" ]]; then
    echo "No live hosts found."
    exit 0
fi

echo "Creating txt file with live hosts..."
echo $ping_sweep > live_hosts.txt
cp live_hosts.txt ../UDP/

# Perform discovery scan and output in all formats
echo "Running scan on live hosts...checking for vulns..."
nmap -sSVC -vv -iL live_hosts.txt -oA fast_scan_tcp | tee TCPvulnScan.txt

# Perform full scan including port 0 and output in all formats
echo "Running full scan including port 0 on full range treating all hosts as live..."
full_scan=$(nmap -sSVC -Pn -p0-65535 $target -oA full_scan_tcp --max-rtt-timeout=950ms --max-retries=9 --version-intensity= 9 --max-scan-delay=50ms --min-rate=1000 --reason --script=banner | tee TCPFullScan.txt)

# Extract live hosts from the full scan and write to full_hosts.txt
echo "$full_scan" | grep 'Nmap scan report for' | cut -d ' ' -f 5 > full_hosts.txt

echo "TCP Scans complete."

# Copy full_hosts.txt file to the UDP directory
cp full_hosts.txt ../UDP/

# Change directory to the "UDP" directory
cd ../UDP

echo "Changed directory to UDP."

echo "UDP Scan Start"

# Perform verbose UDP fast scan and output in all formats
echo "Running verbose UDP fast scan on full hosts..."
nmap -sU -vv -Pn --top-ports 100 -iL full_hosts.txt -oA fast_scan_udp | tee UDPfastscan.txt

# Perform UDP full scan output in all formats
echo "Running full UDP scan on all hosts..."
nmap -Pn -sUV -p0-65535 -iL full_hosts.txt -oA full_scan_upd | tee UDPfullscan.txt

echo "UDP Scans complete."

echo "Scans complete."
