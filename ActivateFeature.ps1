Add-PSSnapin Microsoft.SharePoint.PowerShell -ErrorAction SilentlyContinue
 
#SharePoint Web Site
$Web = Get-SPWeb "http://iusgestion.errepar.com/sitios/Erreius"
#Feature a Activar
$FeatureToActivate = Get-SPFeature | Where {$_.DisplayName -eq "Docx2HtmlSPHandler_DocxHtmlSPHandler"}
 
#Chequeo si está activa se reactiva
   $FeatureActivated = Get-SPFeature -Web $Web | Where {$_.displayname -eq $FeatureToActivate.DisplayName}
  
   if($FeatureActivated -ne $null)
   {
      Disable-SPFeature -Identity $FeatureToActivate -URL $Web.URL -Confirm:$False
	  Enable-SPFeature -Identity $FeatureToActivate -URL $Web.URL -Confirm:$False
	  Write-Host "Se reactivo la Feature en: "$Web.Url
	  echo $FeatureToActivate "La feature estaba activada en "$Web.Url "Se desactivo y activo nuevamente" > C:\Scripts\ActivateFeature.log
   }
   else
   {
      #Activar Feature
      Enable-SPFeature -Identity $FeatureToActivate -URL $Web.URL -Confirm:$False
      Write-Host "Feature activada en "$Web.Url
	  echo $FeatureToActivate "La Feature fue activada en "$Web.Url > C:\Scripts\ActivateFeature.log
   }
