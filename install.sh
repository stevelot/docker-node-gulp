#!/bin/bash

echo "FTP Wachtwoord (dev)"
KeyChainName="CredFtpDev"
KeyChainUser="test"
KeyChainPswd=$(security find-generic-password -w -s "$KeyChainName" -a "$KeyChainUser") > /dev/null 2>&1
len=${#KeyChainPswd}
if [ $len \> 0 ] ; then
  echo "Het wachtwoord opnieuw ingeven (j / leeg)? (huidige lengte: ${len})"
  read jn
  if [[ "$jn" == "j"  ||  "$jn" == "J" ]] ; then
    len=0
  fi
fi
if [ $len = 0 ] ; then
  security delete-generic-password -a "$KeyChainUser" -s "$KeyChainName" > /dev/null 2>&1
  echo "Geef het wachtwoord van de dev ftp server"
  #read -s KeyChainPswd  #Niet opvragen en niet meegeven in volgende regel
  security add-generic-password -s "$KeyChainName" -a "$KeyChainUser" -w #"$KeyChainPswd"
fi

KeyChainPswd=$(security find-generic-password -w -s "$KeyChainName" -a "$KeyChainUser")
len=${#KeyChainPswd}
if [ $len = 0 ] ; then
  echo "Fout, wachtwoord leeg, dit is nodig dus probeer opnieuw..."
  security delete-generic-password -a "$KeyChainUser" -s "$KeyChainName" > /dev/null 2>&1
  exit 1
fi



echo "Docker builden (lokaal)"
echo $(docker image ls -f reference=node --format "{{.Repository}}")

echo "Docker opnieuw bouwen (j / leeg)?"
read jn
if [[ "$jn" == "j"  ||  "$jn" == "J" ]] ; then
  #Opnieuw builden:
  docker build -t my-gulp-ftp .
fi
#start.sh executable maken
chmod +x start.sh
