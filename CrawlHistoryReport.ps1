Add-PSSnapin Microsoft.SharePoint.Powershell -ErrorAction SilentlyContinue
 
#Lista el servicio de búsqueda
$SSAName = "Servicio de búsqueda"
$SSA = Get-SPEnterpriseSearchServiceApplication | where {$_.Name -like $SSAName} #Indicar el nombre del servicio de búsqueda
 
#Lista todos los origenes de contenido
$ContentSources = Get-SPEnterpriseSearchCrawlContentSource -SearchApplication $SSA #| where {$_.Name -eq $ContentSourceName}
$ReportDate = Get-Date -format "dd-MM-yyyy"

 
#CSS Styles para la tabla
$style = "Crawl History Report - Search Service Application EOL: "
$style = $style + "<style>BODY{font-family: Arial; font-size: 10pt;}"
$style = $style + "TABLE{border: 1px solid black; }"
$style = $style + "TH{border: 1px solid black; background: #dddddd; padding: 5px; }"
$style = $style + "TD{border: 1px solid black; padding: 2px; }"
$style = $style + "</style>"

# Cuerpo de Mail
$EmailBodyHistory = $ContentSources | Select @{Name="Content Source";Expression={$_.Name}}, CrawlState, SuccessCount, WarningCount, ErrorCount,CrawlStarted,CrawlCompleted,  @{label="LastCrawlDuration";expression={$_.CrawlCompleted - $_.CrawlStarted}}  | ConvertTo-Html -Head $style
 
# Configuración de Mail
# Lista el Servidor de Correo
$EmailServer = (Get-SPWebApplication -IncludeCentralAdministration | Where { $_.IsAdministrationWebApplication } ) | %{$_.outboundmailserviceinstance.server} | Select Address
 
$From = "CrawlReport@errepar.com"
$recipients = "Emmanuel Gutierrez <Emmanuel.Gutierrez@errepar.com>"#, Claudio Leonel Gallardo <Claudio.Gallardo@errepar.com>, Jorge Suarez <Jorge.Suarez@errepar.com>"
[string[]]$To = $recipients.Split(',')
$Subject = "Crawl History Report EOL con fecha: "+$ReportDate
$Body = "Hola equipo,<br /><br />Estoy probando el siguiente reporte automatico desde PowerShell con fecha $ReportDate <br /><br />" + $EmailBodyHistory
 
# Envia resultados por Mail
Send-MailMessage -smtpserver $EmailServer.Address -from $from -to $To -subject $subject -body $body -BodyAsHtml


