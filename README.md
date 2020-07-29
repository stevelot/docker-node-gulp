
### Doel
Op een eenduidige (en simpele) manier lokaal ontwikkelen en je aanpassingen meteen nakijken op de lokatie waar ze moeten komen (via apex bv).

### Prerequisites
- Docker Desktop (windows 10 pro) moet geinstalleerd zijn.
- Toegang tot de dev sftp server is nodig 😎 dus ook het wachtwoord!

### Gebruik
- Checkout naar een eigen te kiezen working directory
- Stel het wachtwoord in (dit wordt geëncrypteerd lokaal opgelaan in windows) en maak de docker image -> via het script (in powershell: ``.\install.ps1``). Dit moet je enkel de 1e keer doen, tenzij je wilt rebuilden of het wachtwoord aanpassen.
- Start de docker container via het powershell script ``.\gulp.ps1``
- Controleer of alles werkt door bijvjoorbeeld het bestand ``src/themes/.../css/test.html`` aan te maken/passen. In het terminal venster krijg je meldingen van een nieuwe upload.
- Test of het bestand is aangemaakt/aangepast op de server: https://web.server.host.name/a/themes/.../css/test.html

### Extra
- ``gulp-sftp`` bevat sinds de upgrade van gulp naar versie 4.x een fout, daarom is een git referentie gelegd ipv de versie 0.1.5 in package.json
- Het entrypoint is een scirpt dit kan je zelf naar wens aanpassen zonder de image opnieuw te moeten maken.
- Na afsluiten gulp kan je dit zelf weer opstarten of extra npm componenten installeren en vervolgens testen. Nadien __kan__ je deze dan in package.json opslaan en de image rebuilden voor blijvend gebruik (via het install.ps1 script).
- Bij het kopiëren van dit project moet je opletten dat enkele mappen/bestanden in de ``svn:ignore`` of ``git:ignore`` list staan: 
__``node_modules``=belangrijk!!__, ``CredFtpDev.xml.ignore`` en ``package-lock.json``
