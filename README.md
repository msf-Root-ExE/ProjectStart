The script will create a new folder and save all output inside. The script will run a ping sweep and a fast scan on all the hosts found. A full port 0 -Pn scan will then be done on the entire network.

To use, download the script

git clone https://github.com/msf-Root-ExE/nmap_tcp_scan.git

Go into the directory and modify the permissions of the script

chmod 700 nmap_tcp_scan.sh

To run the script

./nmap_tcp_scan.sh

Enter the network range xxx.xxx.xxx.xxx/xx and the results will start coming in.

This script will 3 3 different scans.

1.	Ping Sweep to identify live hosts
2.	Fast Scan on all hosts identified
3.	Full Scan on the whole range, including port 0 with ping disabled.



