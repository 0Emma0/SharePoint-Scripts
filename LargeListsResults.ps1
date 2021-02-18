Add-PSSnapin Microsoft.SharePoint.PowerShell -ErrorAction SilentlyContinue
 
#Get All Web Applications
$WebAppsCollection = Get-SPWebApplication
 
#Array to Hold Result - PSObjects
$LargeListsResult = @()
 
foreach($WebApp in $WebAppsCollection)
{
    #Get the Throttling Limit of the Web App
    $Threshold = $WebApp.MaxItemsPerThrottledOperation
 
    foreach($Site in $WebApp.Sites)
    {
        foreach($Web in $Site.AllWebs)
        {
            Write-host "Scanning site:"$Web.URL
             
            foreach($List in $Web.Lists)
            {
                if($list.ItemCount -gt $Threshold)
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
Write-host "Total Number of Large Lists Found:"$LargeListsResult.Count -f Green
 
#Export the result Array to CSV file
$LargeListsResult | Export-CSV "c:\LargeListData.csv" -NoTypeInformation       


#Read more: https://www.sharepointdiary.com/2015/03/powershell-to-find-all-large-lists-exceeding-threshold-limit.html#ixzz6Y2sEQ9cG