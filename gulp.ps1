
#Nakijken of het wachtwoord gekend is, zoniet vragen om dit in te stellen
$CredPath = 'CredFtpDev.xml.ignore'
if(-Not (Test-Path -Path $CredPath)){
  Write-Error "Wachtwoord niet gekend, run .\install.ps1"
  exit
}
$FtpPass = ((Import-CliXml -Path $CredPath).GetNetworkCredential().Password) #.password, .username, .domain


#Nakijken of docker gebuild is, zoniet builden:
$MyImage = docker image ls -f reference=my-gulp-ftp --format "{{.Repository}}"
if(-Not ($MyImage -eq 'my-gulp-ftp')){
  Write-Error "Docker image niet gekend, run .\install.ps1"
  exit
}

docker run -it --rm `
           -v "/_/prj/node_modules" `
           -v "$(Get-Location):/_/prj" `
           -e FTP_PASS="${FtpPass}" `
           my-gulp-ftp
#docker run -it --rm `                    #run -interactive&tty-tunnel  --container opkuisen/wissen na afsluiten
#           -v "/_/prj/node_modules" `    #Exclude deze folder! Deze blijft dus behouden zoals deze in de docker image zit
#           -v "$(Get-Location):/_/prj" ` #Gebruik deze folder, (uitgezonderd de bovenliggende excludend node_modules map)
#           -e FTP_PASS="${FtpPass}" `    #Wachtwoord doorgeven, dit willen we NIET in svn/git opslaan
#           my-gulp-ftp                   #Opstarten van deze docker image (=referentie naam image) (zonder container naam)

#           -w /_docker `
#           -w "/_/$((Get-Item .).Name)" `