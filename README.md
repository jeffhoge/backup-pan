# backup-pan
Powershell script to backup multiple Palo Alto Networks firewalls

This script will perform bulk backups of Palo Alto firewalls. It will build a separate folder in the "backuppath" location for each firewall. Each backup will be date & time stamped. You will need to set your firewall hostnames and API keys in the separate CSV file.

To generate the API keys, go here in your web browser of choice (sub in "firewall", "username", "password" for your own values):
https://firewall/api/?type=keygen&user=username&password=password

1. Create a folder somewhere on your machine for the script to run (in this example, it'll be in the same location where backups are stored).
2. Place the CSV file in this folder.
3. Edit the two variables at the top of the .ps1 file to equal your path for backups and the path for the csv file.
4. Generate an API key for each of your firewalls in your web browser (instructions are in the .ps1 file's comments).
5. Plug in your firewalls' hostnames into the left column and each corresponding API key in the right column in the CSV file.
6. Run the .ps1 file - you can now perform bulk backups.

Optionally, you can set a Windows scheduled task to run powershell.exe.

Add arguments: -executionpolicy bypass .\backup-pan.ps1
Start in: [path of your script]
