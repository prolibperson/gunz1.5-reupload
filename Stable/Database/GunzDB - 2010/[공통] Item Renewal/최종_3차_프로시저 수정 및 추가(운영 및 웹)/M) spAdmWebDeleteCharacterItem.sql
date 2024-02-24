USE GunzDB
GO

-------------------------------------------------------------------------------------------------------------------------
-- �۾��� ����
EXEC sp_rename 'spAdmWebDeleteCharacterItem', 'BackUp_spAdmWebDeleteCharacterItem';
GO

CREATE PROC dbo.spAdmWebDeleteCharacterItem  
-- ALTER PROC dbo.spAdmWebDeleteCharacterItem
	@CID		INT
	, @CIID		INT
	, @ItemID	INT
	, @GMID		VARCHAR(20)  
	, @Ret		INT OUTPUT  
AS BEGIN

	SET NOCOUNT ON ;

	IF NOT EXISTS (SELECT CID FROM Character(NOLOCK) WHERE CID = @CID) BEGIN  
		SET @Ret = 0;
		RETURN @Ret;
	END  

	-- �����Ϸ��� �������� �����ϰ� �ִٸ� ���� �������ľ� ��.
	
	BEGIN TRAN -------------- 
		
		UPDATE	CharacterEquipmentSlot
		SET		CIID = NULL, ItemID = NULL
		WHERE	CID = @CID
		AND		CIID = @CIID;
		
		IF (0 <> @@ERROR) BEGIN
			ROLLBACK TRAN  
			SET @Ret = 0  
			RETURN @Ret
		END  
				
		UPDATE	CharacterItem 
		SET		CID = NULL
		WHERE	CIID = @CIID 
		AND		CID = @CID 
		AND		ItemID = @ItemID	
		
		IF (0 <> @@ERROR) BEGIN
			ROLLBACK TRAN  
			SET @Ret = 0  
			RETURN @Ret
		END  
		
	COMMIT TRAN -------------  

	SET @Ret = 1  
	RETURN @Ret
END  
-------------------------------------------------------------------------------------------------------------------------
-- ���� ����
/*
DROP PROC spAdmWebDeleteCharacterItem
EXEC sp_rename 'BackUp_spAdmWebDeleteCharacterItem', 'spAdmWebDeleteCharacterItem';
*/

