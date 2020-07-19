#!/bin/bash
read -p "Enter IP: " IP
function main {
	
	if ping -c 1 $IP > /dev/null #checks if host is up
	then
	
		nmap -v -oN nmapscan $IP #starts a nmap scan, and saves the output to a file
		if cat nmapscan | grep -q '999' # checks if host is fully set up
		then
			echo "Waiting for host to finish setup!"
			sleep 10
			main
		else
			gobuster dir -u http://$IP -w /usr/share/wordlists/dirb/common.txt -o dirs #starts gobuster with the common wordlist and save it to a file
		fi
	
	else
		echo "Host Down!"
		main
	fi
}
main
