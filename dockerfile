
FROM node:latest 
                 #AS my-gulp-ftp
WORKDIR /_/prj
COPY package.json ./
RUN npm install -g gulp gulp-cli \
 && npm install
ENTRYPOINT ["./start.sh"]
#ENTRYPOINT ["/bin/bash"]
#ENTRYPOINT ["gulp"]




#npm install -g gulp gulp-cli
#
#npm install
#
#npm run gulp
#
#gulp
#
#nodejs: console.log('Hello ' + process.env.FTP_PASS)
#
#  docker run -ti --rm -w /_docker `
#>>             -v "/usr/local/lib/node_modules/npm" `
#>>             -v "${PS_DCR_TK_HOME}/node+npm/node_modules:/usr/local/lib/node_modules" `
#>>             -v "$(Get-Location):/_/$((Get-Item .).Name)" `
#>>             -w "/_/$((Get-Item .).Name)" `
#               -e FTP_PASS="$((Import-CliXml -Path 'CredFtpDev.xml.ignore').GetNetworkCredential().Password)" `
#>>             node node --version