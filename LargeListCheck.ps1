Add-PSSnapin Microsoft.SharePoint.PowerShell -ErrorAction SilentlyContinue
 
#Get All Web Applications
$WebAppsCollection = Get-SPWebApplication
 
#Array to Hold Result - PSObjects
$LargeListsResult = @()
$ReportDate = Get-Date -format "dd-MM-yyyy"
 
foreach($WebApp in $WebAppsCollection)
{
    #Get the Throttling Limit of the Web App
    $Threshold = $WebApp.MaxItemsPerThrottledOperation
 
    foreach($Site in $WebApp.Sites)
    {
        foreach($Web in $Site.AllWebs)
        {
           # Write-host "Scanning site:"$Web.URL
             
            foreach($List in $Web.Lists)
            {
	        if($List.EnableThrottling -ne "True")
                {
                    $Result = New-Object PSObject
                    $Result | Add-Member NoteProperty Title($list.Title)
                    $Result | Add-Member NoteProperty URL($web.URL)
                    $Result | Add-Member NoteProperty Count($list.ItemCount)
		            $Result | Add-Member NoteProperty Threshold($list.EnableThrottling)
                     
                    #Add the object with property to an Array
                    $LargeListsResult += $Result   							
                }
            }
        }
    }
}
					if ($LargeListsResult -ne $null){
					# Cuerpo de Mail
	                $EmailBodyHistory = $LargeListsResult | ConvertTo-Html -Head $style 
	                # Lista el Servidor de Correo
	                $EmailServer = (Get-SPWebApplication -IncludeCentralAdministration | Where { $_.IsAdministrationWebApplication } ) | %{$_.outboundmailserviceinstance.server} | Select Address
					# ConfiguraciÃ³n de Mail
	                $From = "SharePointCheckThreshold@contoso.com"
	                $recipients = "Emmanuel Gutierrez <Emmanuel.Gutierrez@contoso.com>"
	                [string[]]$To = $recipients.Split(',')
	                $Subject = "Hay listas de SharePoint sin umbral de vista: "+$ReportDate
	                $Body = "WARNING!!!,<br /><br />Las siguientes listas no tienen umbral de vista a la fecha $ReportDate <br /><br />" + $EmailBodyHistory
 
                    # Envia resultados por Mail
	                Send-MailMessage -smtpserver $EmailServer.Address -from $from -to $To -subject $subject -body $body -BodyAsHtml
                     }  
					else{
					Write-host "Todas las listas tienen umbral de vista aplicado"
					}