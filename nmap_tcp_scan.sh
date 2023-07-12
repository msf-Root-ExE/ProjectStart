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

echo "File created successfully. The file name is nmap."

# Create a file called "Evidence"
mkdir "Evidence"

echo "File created successfully. The file name is Evidence."

# Create a file called "Notes"
mkdir "Notes"

echo "File created successfully. The file name is Notes."

# Create a file called "Pre-Reqs"
mkdir "Pre-Reqs"

echo "File created successfully. The file name is Pre-Reqs."

# Change directory to the "nmap" directory
cd "nmap"

echo "Changed directory to nmap."

# Create a file called "TCP"
mkdir "TCP"

echo "File created successfully. The file name is TCP."

# Create a file called "UDP"
mkdir "UDP"

echo "File created successfully. The file name is UDP."

# Change directory to the "TCP" directory
cd "TCP"

echo "Changed directory to TCP."

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
echo $ping_sweep > live_hosts.txt

# Perform discovery scan and output in all formats
echo "Running scan on live hosts...checking for vulns..."
nmap -sSVC -vv -iL live_hosts.txt -oA fast_scan_tcp | tee TCPvulnScan.txt


# Perform full scan including port 0 and output in all formats
echo "Running full scan including port 0 on full range treating all hosts as live..."
sudo nmap -sSVC -Pn -p0-65535 $target -oA full_scan_tcp --max-rtt-timeout=950ms --max-retries=9 --version-intensity= 9 --max-scan-delay=50ms --min-rate=10000 --reason --script=banner | tee TCPFullScan.txt

echo "TCP Scans complete."

# Change directory to the "UDP" directory

cd ..
cd "UDP"

echo "Changed directory to UDP."

echo "UDP Scan Start"

# Run Nmap ping sweep and output live hosts to txt file
echo "Running Nmap ping sweep on target $target..."
ping_sweep=$(sudo nmap -sn $target | grep 'Nmap scan report for' | cut -d ' ' -f 5)

# Check if any live hosts found
if [[ -z "$ping_sweep" ]]; then
    echo "No live hosts found."
    exit 0
fi

echo "Creating txt file with live hosts..."
echo $ping_sweep > live_hosts.txt

# Perform verbose UDP fast scan and output in all formats
echo "Running verbose UDP fast scan on live hosts..."
sudo nmap -sU -vv -Pn --top-ports 100 -iL live_hosts.txt -oA fast_scan_udp | tee UDPfastscan.txt

# Perform UDP full scan output in all formats
echo "Running full UDP scan on all hosts..."
sudo nmap -Pn -sUV $target -oA full_scan_upd | tee UDPfullscan.txt

echo "UDP Scans complete."

echo "Scans complete."
