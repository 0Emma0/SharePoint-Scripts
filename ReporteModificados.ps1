$SPWeb = Get-SPWeb "http://eolgestion.errepar.com/sitios/eolgestion"
$List = $SPWeb.Lists

foreach($i in $List)
{
#$b = $i.DefaultView.Url
$c = $i.LastItemModifiedDate
$d = $i.Title
$e = $i.ItemCount
$f = $i.Items
$a = $d + ";" +  $e + ";" + $c + ";" + $f

$a 

}

#| Out-File -FilePath L:\Reportes\EOLGestion_UltimaModificacion.csv -Append -Encoding ASCII