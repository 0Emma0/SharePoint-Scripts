Add-PSSnapin Microsoft.SharePoint.PowerShell -ErrorAction SilentlyContinue
#Aplica umbral de vista a todas las listas de SharePoint
#Get All Web Applications
$WebAppsCollection = Get-SPWebApplication
 
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
                    Write-host "La lista no tiene umbral de vista >>" "$List"
					Write-host "Site Collection donde se encuentra la lista" $web.URL
					$SiteCollection = $web.URL
                    $weblist = Get-SPWeb $SiteCollection
                    $ActivaUmral = $weblist.Lists["$List"]
                    $ActivaUmral.EnableThrottling = $true
                    $ActivaUmral.Update()	
					Write-host "Se cambio la propiedad de umbral a:" $ActivaUmral.EnableThrottling 
                }
            }
        }
    }
}