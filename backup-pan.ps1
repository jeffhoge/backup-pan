# This script will perform bulk backups of Palo Alto firewalls. 
# It will build a separate folder in the "backuppath" location for each firewall. 
# Each backup will be date & time stamped.
# You will need to set your firewall hostnames and API keys in the separate CSV file.
#
# To generate the API keys, go here (sub in "firewall", "username", "password"): https://firewall/api/?type=keygen&user=username&password=password
# CSV file format = firewall,key,optional comments
#
# Please define the two variables below:

$backuppath = "C:\admin\palo\config backups"
$devicecsv = "C:\admin\palo\config backups\devices.csv"

# The following optional subproceudre will trust any untrusted certs you may have on your firewall. Comment it out if it's not needed.

add-type @"
    using System.Net;
    using System.Security.Cryptography.X509Certificates;
    public class TrustAllCertsPolicy : ICertificatePolicy {
        public bool CheckValidationResult(
            ServicePoint srvPoint, X509Certificate certificate,
            WebRequest request, int certificateProblem) {
            return true;
        }
    }
"@
[System.Net.ServicePointManager]::CertificatePolicy = New-Object TrustAllCertsPolicy

Import-Csv $devicecsv -Header firewall,key | ForEach-Object {

    New-Item -ItemType Directory -Force -Path $backuppath\$($_.firewall)
    $date = Get-Date
#   write-host "$($_.firewall)/api/?type=export&category=configuration&key=$($_.key)"
    Invoke-WebRequest -Uri "https://$($_.firewall)/api/?type=export&category=configuration&key=$($_.key)" | Out-File "$backuppath\$($_.firewall)\$($date.ToString('yyyy-MM-dd_HH-mm-ss')).xml"

}
