USE GunzDB
GO
-------------------------------------------------------------------------------------------------------------------------
-- �۾��� ����
EXEC sp_rename 'spWebResetChar', 'BackUp_spWebResetChar';
GO

-- ĳ���� �ʱ�ȭ  
CREATE PROC dbo.spWebResetChar
-- ALTER PROC dbo.spWebResetChar
	@CID  INT
AS BEGIN  
	
	SET NOCOUNT ON;
	
	BEGIN TRAN ----------------
		UPDATE	Character 
		SET		Level = 1, XP = 0, BP = 0, GameCount = 0, KillCount = 0, DeathCount = 0		
		WHERE	CID = @CID;
		IF (@@ERROR <> 0) OR (@@ROWCOUNT = 0) BEGIN
			ROLLBACK TRAN;
			RETURN;
		END
				
		UPDATE	CharacterEquipmentSlot
		SET		CIID = NULL, ItemID = NULL		
		WHERE	CID = @CID;
		IF (@@ERROR <> 0) OR (@@ROWCOUNT = 0) BEGIN
			ROLLBACK TRAN;
			RETURN;
		END
					
		UPDATE	CharacterItem 
		SET		CID = NULL 
		WHERE	CID = @CID 
		AND		ItemID < 500000  
		
		IF (@@ERROR <> 0) OR (@@ROWCOUNT = 0) BEGIN
			ROLLBACK TRAN;
			RETURN;
		END
		
	COMMIT TRAN ---------------
END  

-------------------------------------------------------------------------------------------------------------------------
-- ���� ����
/*
DROP PROC spWebResetChar
EXEC sp_rename 'BackUp_spWebResetChar', 'spWebResetChar';
*/
