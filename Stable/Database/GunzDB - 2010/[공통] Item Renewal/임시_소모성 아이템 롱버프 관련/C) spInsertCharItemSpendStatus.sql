-- USE GunzDB
USE IGunzDB
GO

----------------------------------------------------------------------------------------------------------------------------------------
-- �۾��� ����

CREATE PROC dbo.spInsertCharacterBuffStatus
-- ALTER PROC dbo.spInsertCharItemSpendStatus
	@CID	INT
AS BEGIN
	SET NOCOUNT ON;
	
	INSERT	CharacterBuffStatus(CID)
	VALUES	(@CID);
	
	SELECT	@@IDENTITY AS CBID;	
END
GO

----------------------------------------------------------------------------------------------------------------------------------------
-- ���� ����
/*
DROP PROC dbo.spInsertCharacterBuffStatus
*/

