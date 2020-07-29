
Write-Output "FTP Wachtwoord (dev)"
$CredPath = 'CredFtpDev.xml.ignore'
$len = 0
if(Test-Path -Path $CredPath){
  $len = ((Import-CliXml -Path $CredPath).GetNetworkCredential().Password).Length
}
if($len -gt 0){
  $jn = Read-Host -Prompt "Het wachtwoord opnieuw ingeven (j / leeg)? (huidige lengte: ${len})"
  if($jn -eq 'j' -or $jn -eq 'J'){
    #Wachtwoord opnieuw vragen
    $len = 0
  }
}
if($len -eq 0){
  $CredFtpDev = Get-Credential -Message "Geef het wachtwoord van de dev ftp server" -User "sftp.server.host.name\user"
  $CredFtpDev | Export-CliXml -Path $CredPath
}


Write-Output "Docker builden (lokaal)"
Write-Output $(docker image ls -f reference=node --format "{{.Repository}}")

$jn = Read-Host -Prompt "Docker opnieuw bouwen (j / leeg)?"
if($jn -eq 'j' -or $jn -eq 'J'){
  #Opnieuw builden:
  $len = 0
}
if($len -eq 0){
  docker build -t my-gulp-ftp .
}
