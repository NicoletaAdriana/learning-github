CREATE PROCEDURE dbo.rptEVO_Etichete_Celule_WMS_Cutii                               
@WMSDeliveryPackageId int        
                   
AS                       
BEGIN             
        
                  
set nocount on                       
SET ANSI_WARNINGS OFF                       
         
        
select WMSDeliveryPackageId, WMSDeliveryPackageCode as ItemName1, WMSDeliveryPackageName, BarCode as Barcode1 
from WMSDeliveryPackage                  
where WMSDeliveryPackageId = @WMSDeliveryPackageId       
      
end                     