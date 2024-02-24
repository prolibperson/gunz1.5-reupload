CREATE PROC dbo.spChangeGambleItemToRewardItem
-- ALTER PROC dbo.spChangeGambleItemToRewardItem
	@CID			INT
	, @CIID			INT 
	, @GIID			INT
	, @RewardItemID INT
AS BEGIN
	SET NOCOUNT ON  
  
	DECLARE @RentHourPeriod smallint  
  
	SELECT	@RentHourPeriod = RentHourPeriod  
	FROM	GambleRewardItem gri(NOLOCK)  
	WHERE	GIID = @GIID 
	AND		(ItemIDMale = @RewardItemID OR ItemIDFemale = @RewardItemID)  
  
	IF (@RentHourPeriod IS NULL)
	BEGIN  
		SELECT -1 as 'Ret'  
		RETURN  
	END  
  
	BEGIN TRAN -----------
		IF( @RentHourPeriod = 0 ) BEGIN
			-- ������ �������� ���, RentDate�� NULL�� �ǵ��� �ٲ��ش�.
			UPDATE	CharacterItem  
			SET		ItemID = @RewardItemID, RentHourPeriod = @RentHourPeriod
			WHERE	CID = @CID 
			AND		CIID = @CIID 
			AND		ItemID = @GIID 
		END
		ELSE BEGIN
			UPDATE	CharacterItem  
			SET		ItemID = @RewardItemID, RentHourPeriod = @RentHourPeriod, RentDate = GETDATE()  
			WHERE	CID = @CID 
			AND		CIID = @CIID 
			AND		ItemID = @GIID 
		END
		 
		
		IF (0 <> @@ERROR) OR (0 = @@ROWCOUNT) BEGIN  
		   ROLLBACK TRAN  
		   SELECT -2 AS 'Ret'  
		   RETURN  
		END  
  
		INSERT INTO LogDB..GambleLog(CID, GIID, RewardItemID, RegDate)  
		VALUES (@CID, @GIID, @RewardItemID, GETDATE())  
	  
		IF (0 <> @@ERROR) OR (0 = @@ROWCOUNT) BEGIN  
			ROLLBACK TRAN;  
			SELECT -3 AS 'Ret'  
			RETURN  
		END  
	  
	COMMIT TRAN ---------
  
	SELECT 1 AS 'Ret'  
END  