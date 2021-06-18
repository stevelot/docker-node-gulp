#!/bin/bash

#Nakijken of het wachtwoord gekend is, zoniet vragen om dit in te stellen
KeyChainName="CredFtpDev"
KeyChainUser="test"
KeyChainPswd=$(security find-generic-password -w -s "$KeyChainName" -a "$KeyChainUser") > /dev/null 2>&1
len=${#KeyChainPswd}
if [ $len \= 0 ] ; then
  echo "Wachtwoord niet gekend, run sh install.sh"
  exit 1
else
  FtpPass="$KeyChainPswd"
fi



#Nakijken of docker gebuild is, zoniet builden:
MyImage=$(docker image ls -f reference=my-gulp-ftp --format "{{.Repository}}")
if [[ $MyImage != 'my-gulp-ftp' ]] ; then
  echo "Docker image niet gekend, run .\install.ps1"
  exit 1
fi

docker run -it --rm \
           -v "/_/prj/node_modules" \
           -v "$(pwd):/_/prj" \
           -w "/_/prj" \
           -e FTP_PASS="${FtpPass}" \
           my-gulp-ftp


        #    --entrypoint "bash" \
        #    --entrypoint "sh start.sh" \
        #    --entrypoint " sh /_/prj/start.sh" \