function Get-SP2010ProductKey {   
    $map="BCDFGHJKMPQRTVWXY2346789"
    $value = (get-itemproperty "HKLM:\SOFTWARE\Microsoft\Office\14.0\Registration\{90140000-110D-0000-1000-0000000FF1CE}").digitalproductid[0x34..0x42] 
    $ProductKey = "" 
    for ($i = 24; $i -ge 0; $i--) {
      $r = 0
      for ($j = 14; $j -ge 0; $j--) {
        $r = ($r * 256) -bxor $value[$j]
        $value[$j] = [math]::Floor([double]($r/24))
        $r = $r % 24
      }
      $ProductKey = $map[$r] + $ProductKey
      if (($i % 5) -eq 0 -and $i -ne 0) {
        $ProductKey = "-" + $ProductKey
      }
    }
    $ProductKey
}
#Call the function
Get-SP2010ProductKey


#Read more: http://www.sharepointdiary.com/2013/07/recover-sharepoint-2007-2010-product-key.html#ixzz4gacPuA8l