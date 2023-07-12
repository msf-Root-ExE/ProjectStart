The script will create a new project folderand, an nmap folder inside to save the data of this script. The script will run a ping sweep to detect live hosts, and place them in a .txt file. A scan will then be performed on all the live hosts found. After a full port 0 -Pn scan will then be done on the entire network incase any of the targtes have ping disabled or are hiding services on obsucre ports.

To use, download the script

git clone - https://github.com/msf-Root-ExE/ProjectStart.git

Go into the directory and modify the permissions of the script

chmod 700 projectStart.sh

To run the script

./projectStart.sh

Enter the project name.
Enter the network range xxx.xxx.xxx.xxx/xx and the results will start coming in.

This script will multiple different scans.

1.	Ping Sweep to identify live hosts
2.	Syn,version and script scan only on live hosts identified by the ping sweep.
3.	Full Scan on the whole range, including port 0 treating all hosts as live.
4.  Create a full list of hosts ID'd by the -pN full scan - taking hosts into account that are hidden from ping run the following UDP scans 
5.  UDP top 100 scan
6.  Full UDP scan on all hosts


