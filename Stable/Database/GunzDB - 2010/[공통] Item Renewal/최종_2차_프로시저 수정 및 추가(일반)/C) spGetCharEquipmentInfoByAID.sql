USE GunzDB
GO

----------------------------------------------------------------------------------------------------------------------------------------
-- �۾��� ����

CREATE PROC dbo.spGetCharEquipmentInfoByAID
-- ALTER PROC dbo.spGetCharEquipmentInfoByAID
	@AID		INT, 
	@CharNum	SMALLINT
AS BEGIN
	SET NOCOUNT ON;
	
	DECLARE @CID INT
	SELECT @CID = CID FROM Character(NOLOCK) WHERE AID = @AID AND CharNum = @CharNum        
      
	SELECT	SlotID, ItemID, CIID
	FROM	CharacterEquipmentSlot(NOLOCK)
	WHERE	CID = @CID 
END

----------------------------------------------------------------------------------------------------------------------------------------
-- ���� ����
/*
DROP PROC spGetCharEquipmentInfoByAID
*/