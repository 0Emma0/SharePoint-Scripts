#Get SharePoint Content database sizes
Add-PSSnapin Microsoft.SharePoint.PowerShell -ErrorAction SilentlyContinue
$date = Get-Date -Format "dd-MM-yyyy" #Variables that you can change to fit your environment
$TXTFile = "L:\ReportsSPContentDatabase_$date.txt"
# $SMTPServer = "yourmailserver"
# $emailFrom = "SharePointReports@company.com"
# $emailTo = "youradmin@company.com"
# $subject = "Content Database size reports"
# $emailBody = "Daily/Weekly/Monthly report on Content databases"
 
$webapps = Get-SPWebApplication
foreach($webapp in $webapps)
{
$ContentDatabases = $webapp.ContentDatabases
Add-Content -Path $TXTFile -Value "Content databases for $($webapp.url)"
foreach($ContentDatabase in $ContentDatabases)
{
$ContentDatabaseSize = [Math]::Round(($ContentDatabase.disksizerequired/1GB),2)
Add-Content -Path $TXTFile -Value "-     $($ContentDatabase.Name): $($ContentDatabaseSize)GB"
}
}
# if(!($SMTPServer) -OR !($emailFrom) -OR !($emailTo))
# {
# Write-Host "No e-mail being sent, if you do want to send an e-mail, please enter the values for the following variables: $SMTPServer, $emailFrom and $emailTo."
# }
# else
# {
# Send-MailMessage -SmtpServer $SMTPServer -From $emailFrom -To $emailTo -Subject $subject -Body $emailBody -Attachment $TXTFile
# }