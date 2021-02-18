#----------------------------------------------------------------------------- 
# Name:               Get-SPSearchCrawlLogs.ps1  
# Description:         This script will show you the crawl logs with the error: 
#                    ":Error from SharePoint site: *** Index was outside the bounds of the array" 
# Usage:            Run the function with the name of your Search Service 
# By:                 Ivan Josipovic, Softlanding.ca 
#----------------------------------------------------------------------------- 
function Get-SPSearchCrawlLogs ($SearchServiceName){ 
$ssa = Get-SPEnterpriseSearchServiceApplication | Where-Object {$_.Name -eq $SearchServiceName}  
$ssaContent = new-object Microsoft.Office.Server.Search.Administration.Content($ssa)  
$logViewer = New-Object Microsoft.Office.Server.Search.Administration.Logviewer $ssa  
$ErrorList = $logViewer.GetAllStatusMessages() | Select ErrorId  
$crawlLogFilters = New-Object Microsoft.Office.Server.Search.Administration.CrawlLogFilters;  
$crawlLogFilters.AddFilter("MessageId", "377");  
$startNum = 0;  
$errorItems += $logViewer.GetCurrentCrawlLogData($crawlLogFilters, ([ref] $startNum));  
WHILE($startNum -ne -1){ 
    $crawlLogFilters.AddFilter(“StartAt”, $startNum); 
    $startNum = 0; 
    $errorItems += $logViewer.GetCurrentCrawlLogData($crawlLogFilters, ([ref] $startNum)); 
} 
$errorItems | select DisplayURL 
} 
Get-SPSearchCrawlLogs -SearchServiceName "Servicio de búsqueda" 