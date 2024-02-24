USE GunzDB
GO

----------------------------------------------------------------------------------------------------------------------------------------
-- �۾��� ����

CREATE PROC dbo.spInsertDistributeItem  
-- ALTER PROC dbo.spInsertDistributeItem
	@CID			INT,  
	@ItemID			INT,
	@RentHourPeriod SMALLINT
AS BEGIN

	SET NOCOUNT ON;

	INSERT INTO CharacterItem (CID, ItemID, RegDate, RentDate, RentHourPeriod, Cnt)   
	VALUES (@CID, @ItemID, GETDATE(), GETDATE(), @RentHourPeriod, 1);  

	SELECT 0 AS 'Ret', @@IDENTITY as ORDERCIID    
END
GO


----------------------------------------------------------------------------------------------------------------------------------------
-- ���� ����
/*
DROP PROC spGetCharEquipmentInfoByAID
*/
