$searchapp = Get-SPEnterpriseSearchServiceApplication �Servicio de b�squeda�  
$contentsource = Get-SPEnterpriseSearchCrawlContentSource �Errepar On Line� -SearchApplication $searchapp  
$contentsource.StopCrawl()