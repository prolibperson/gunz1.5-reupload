USE GunzDB
GO

----------------------------------------------------------------------------------------------------------------------------------------
-- �۾��� ����
EXEC sp_rename 'spBuyBountyItem', 'BackUp_spBuyBountyItem'
GO

CREATE PROC dbo.spBuyBountyItem
-- ALTER PROC dbo.spBuyBountyItem
	@CID				INT,  
	@ItemID				INT,
	@ItemCount			INT,
	@Price				INT,
	@IsSpendableItem	INT,
	@RentHourPeriod		INT = NULL	
AS BEGIN
	SET NOCOUNT ON
	
	DECLARE @Bounty INT;
	DECLARE @OrderCIID INT;
	DECLARE @Cnt INT;
	
	IF( @RentHourPeriod IS NULL ) BEGIN
		SET @RentHourPeriod = 0;
	END
	
	DECLARE @CurDate DATETIME;
	SET @CurDate = GETDATE();

	BEGIN TRAN ----------------------------	
	
		-- �ܾװ˻� => Bounty ����      
		UPDATE	dbo.Character 
		SET		BP = BP - @Price 
		WHERE	CID = @CID 
		AND		(BP - @Price >= 0);
		
		IF( 0 <> @@ERROR OR 0 = @@ROWCOUNT ) BEGIN      
			ROLLBACK TRAN
			SELECT -1 AS 'Ret'
			RETURN;
		END      		
		
		IF( @IsSpendableItem = 1 ) BEGIN
					
			-- �̹� ���� �ִ��� Ȯ���غ���.
			SELECT	@OrderCIID = CIID 
			FROM	CharacterItem(NOLOCK) 
			WHERE	CID = @CID 
			AND		ItemID = @ItemID;
		
			-- �̹� ���� ���� �ʴٸ� ���� �߰����ش�.
			IF( @OrderCIID IS NOT NULL ) BEGIN
			
				UPDATE	dbo.CharacterItem				-- Item �߰�
				SET		Cnt = Cnt + @ItemCount
				WHERE	CIID = @OrderCIID
				AND		CID = @CID;
				
				IF( 0 <> @@ERROR OR 0 = @@ROWCOUNT ) BEGIN      
					ROLLBACK TRAN
					SELECT -2 AS 'Ret'
					RETURN;
				END
										
			END ELSE BEGIN
			
				INSERT INTO CharacterItem (CID, ItemID, RegDate, RentDate, RentHourPeriod, Cnt)
				Values (@CID, @ItemID, @CurDate, @CurDate, @RentHourPeriod, @ItemCount)
				
				IF( 0 <> @@ERROR OR 0 = @@ROWCOUNT ) BEGIN      
					ROLLBACK TRAN
					SELECT -3 AS 'Ret'
					RETURN;
				END
				
				SELECT @OrderCIID = @@IDENTITY;	
			END
						
		END
		ELSE BEGIN
				
			INSERT dbo.CharacterItem (CID, ItemID, RegDate, RentDate, RentHourPeriod, Cnt)
			Values (@CID, @ItemID, @CurDate, @CurDate, @RentHourPeriod, @ItemCount)
			
			SELECT @OrderCIID = @@IDENTITY;	
			
			IF( 0 <> @@ERROR OR 0 = @@ROWCOUNT ) BEGIN      
				ROLLBACK TRAN
				SELECT -4 AS 'Ret'
				RETURN;
			END
						
		END 
		
		-- Item ���ŷα� �߰�      
		INSERT INTO ItemPurchaseLogByBounty (ItemID, CID, Date, Bounty, CharBounty, Type)
		VALUES (@ItemID, @CID, @CurDate, @Price, @Bounty, '����')
		
		IF( 0 <> @@ERROR OR 0 = @@ROWCOUNT ) BEGIN      
			ROLLBACK TRAN
			SELECT -5 AS 'Ret'
			RETURN;
		END
		
	COMMIT TRAN ----------------------------
		
	SELECT 0 AS 'Ret', @OrderCIID AS 'ORDERCIID'
END


----------------------------------------------------------------------------------------------------------------------------------------
-- ���� ����
/*
DROP PROC spBuyBountyItem
EXEC sp_rename 'BackUp_spBuyBountyItem', 'spBuyBountyItem'
*/
