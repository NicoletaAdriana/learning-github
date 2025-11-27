if exists( select * from sysobjects where id = object_id(N'[WMS_DissociateItemBarcode]') and OBJECTPROPERTY(id,N'IsProcedure') = 1 )
   drop procedure [WMS_DissociateItemBarcode] 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE  [dbo].[WMS_DissociateItemBarcode]  
	@ItemId int,        
	@MeasuringUnitId int,        
	@Barcode varchar(255) ,       
	@vRes int output,        
	@vMessage varchar(255) output    
AS  
BEGIN  
	set @vRes = 0              

 
	if(@MeasuringUnitId is null)      
	select @MeasuringUnitId = MeasuringUnitId from Item (nolock) where ItemId = @ItemId
 
 
	DELETE top(1) FROM ItemBarCode  
	WHERE  BarCode = @Barcode;
 
	DECLARE @FMDCodePropertyId int, @Marker1 varchar(2), @FMDCode varchar(14)      
	SELECT @FMDCodePropertyId = PropertyId from Property where upper(PropertyCode) = 'FMDCODE'      
	SET @Marker1 = '01'      
	SELECT @FMDCode = SUBSTRING(@Barcode, len(@Marker1)+1, 14)       
 
      
	update ItemProperty 
	set DefaultValue = NULL
	where PropertyId = @FMDCodePropertyId and DefaultValue  LIKE  '%'+@FMDCode+'%'   and ItemId = @ItemId
 
	DELETE top(1) FROM ItemBarCode  
	WHERE  BarCode = @FMDCode
END
GO
