#!/bin/bash

green="\e[0;32m\033[1m"
end="\033[0m\e[0m"
red="\e[0;31m\033[1m"
blue="\e[0;34m\033[1m"
yellow="\e[0;33m\033[1m"
purple="\e[0;35m\033[1m"
turquoise="\e[0;36m\033[1m"
gray="\e[0;37m\033[1m"

echo -e "\t${turquoise} __             _                ${end}"
echo -e "\t${turquoise}/  |_  _  _|/  | \ _ __  _  o __ ${end}"
echo -e "\t${turquoise}\__| |(/_(_|\  |_/(_)|||(_| | | |${end}"
echo -e "\t\t${gray}abund4nt${end}"

function helpPanel(){
	echo -e "\n${turquoise}[+]${end} ${gray}Help Panel:${end}"
	echo -e "\t${turquoise}-d${end} ${gray}Domain Scan (DMARC, SPF)${end}"
	echo -e "\t${turquoise}-s${end} ${gray}Send forged mail.${end}\n"
	echo -e "${yellow}Example: ./domainCheck.sh -d google.cl${end}"
	echo -e "${yellow}         ./domainCheck.sh -s correoSpoofed@google.cl (Remitente)${end}"
}

function checkTodo(){
	domain="$1"
	echo -e "\n${turquoise}[+]${end} ${gray}SPF configuration: ${end}\n"
	dig TXT ${domain} | grep -i spf
	echo -e "\n${turquoise}[+]${end} ${gray}DMARC configuration: ${end}\n"
	dig TXT _dmarc.${domain}| grep -i dmarc
}

function sendMail(){
	remitente="$1"
	echo -ne "\n${turquoise}[+]${end} ${gray}Enter the recipient's e-mail address: ${end}"
	read correoDestinatario
	swaks --from ${remitente} --to ${correoDestinatario} --body "Spoofed Test" -h-Subject "pwned"
	sleep 0.5
	echo -e "\n${turquoise}[+]${end} ${gray} Mail sent correctly.${end}\n"
}

declare -i parameter_counter=0

while getopts "d:s:h" arg; do
	case $arg in
		d) domain="$OPTARG"; let parameter_counter+=1;;
		s) remitente="$OPTARG"; let parameter_counter+=2;;
		h) ;;
	esac
done

if [ $parameter_counter -eq 0 ]; then
	helpPanel
elif [ $parameter_counter -eq 1 ]; then
	checkTodo "$domain"
elif [ $parameter_counter -eq 2 ]; then
	sendMail "$remitente"
fi
