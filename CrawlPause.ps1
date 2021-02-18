$SSA = Get-SPEnterpriseSearchServiceApplication -Identity "Servicio de búsqueda"
$ContentSource = $SSA | Get-SPEnterpriseSearchCrawlContentSource -Identity "Errepar On Line"
Write-Host $ContentSource.CrawlState
if (($ContentSource.CrawlStatus  -eq "CrawlingIncremental" ) -or ($ContentSource.CrawlStatus  -eq "CrawlingFull" ))
{
                $ContentSource.PauseCrawl()
                Write-Host "Pausing the current Crawl"
}
Write-host $ContentSource.CrawlState