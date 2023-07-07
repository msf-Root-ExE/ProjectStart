The script will create a new project folderand, an nmap folder inside to save the data of this script. The script will run a ping sweep to detect live hosts, and place them in a .txt file. A scan will then be performed on all the live hosts found. After a full port 0 -Pn scan will then be done on the entire network incase any of the targtes have ping disabled or are hiding services on obsucre ports.

To use, download the script

git clone https://github.com/msf-Root-ExE/nmap_tcp_scan.git

Go into the directory and modify the permissions of the script

chmod 700 nmap_tcp_scan.sh

To run the script

./nmap_tcp_scan.sh

Enter the project name.
Enter the network range xxx.xxx.xxx.xxx/xx and the results will start coming in.

This script will 3 3 different scans.

1.	Ping Sweep to identify live hosts
2.	Thorough on all hosts identified
3.	Full Scan on the whole range, including port 0 treating all hosts as live.



