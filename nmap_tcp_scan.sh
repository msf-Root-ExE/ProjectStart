#!/bin/bash

# Change directory to the desktop
cd ~/Desktop

# Prompt user for a project name
read -p "Enter the project name: " project_name

# Create a file for the project
mkdir "${project_name}"

echo "File created successfully. The project file name is ${project_name}"

# Change directory to the project
cd "${project_name}"

# Create a file called "nmap"
mkdir "nmap"

echo "Second file created successfully. The file name is nmap."

# Change directory to the "nmap" directory
cd "nmap"

echo "Changed directory to nmap."

# Prompt user for target IP or hostname
read -p "Enter target IP or hostname: " target

# Run Nmap ping sweep and output live hosts to txt file
echo "Running Nmap ping sweep on target $target..."
ping_sweep=$(sudo nmap -sn $target | grep 'Nmap scan report for' | cut -d ' ' -f 5)

# Check if any live hosts found
if [[ -z "$ping_sweep" ]]; then
    echo "No live hosts found."
    exit 0
fi

echo "Creating txt file with live hosts..."
echo $ping_sweep > live_hosts_tcp.txt

# Perform discovery scan and output in all formats
echo "Running scan on live hosts...checking for vulns..."
nmap -sSVC -iL live_hosts_tcp.txt -oA fast_scan_tcp | tee TCPvulnScan.txt


# Perform full scan including port 0 and output in all formats
echo "Running full scan including port 0 on full range treating all hosts as live..."
sudo nmap -sSVC -Pn -p0-65535 $target -oA full_scan_tcp --max-rtt-timeout=950ms --max-retries=9 --version-intensity= 9 --max-scan-delay=50ms --min-rate=10000 --reason --script=banner | tee TCPFullScan.txt

echo "Scans complete."
