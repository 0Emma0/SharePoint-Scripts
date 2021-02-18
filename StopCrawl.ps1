$searchapp = Get-SPEnterpriseSearchServiceApplication “Servicio de búsqueda”  
$contentsource = Get-SPEnterpriseSearchCrawlContentSource “Errepar On Line” -SearchApplication $searchapp  
$contentsource.StopCrawl()