$errorsFileName = "L:\CrawlLogs.csv"
$ssa = Get-SPEnterpriseSearchServiceApplication -Identity "Servicio de búsqueda"
$logs = New-Object Microsoft.Office.Server.Search.Administration.CrawlLog $ssa
$logs.GetCrawledUrls($false,10000,"",$false,1,2,-1,[System.DateTime]::MinValue,[System.DateTime]::MaxValue) | export-csv -notype $errorsFileName