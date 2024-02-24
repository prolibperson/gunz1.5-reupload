USE GunzDB
GO
-------------------------------------------------------------------------------------------------------------------------
-- �۾��� ����
EXEC sp_rename 'spAdmWebInsertSetItem', 'BackUp_spAdmWebInsertSetItem';
GO

CREATE PROC dbo.spAdmWebInsertSetItem
-- ALTER PROC dbo.spAdmWebInsertSetItem
	@UserID				VARCHAR(20)  
	, @CSSID			INT
	, @RentHourPeriod	SMALLINT
	, @GMID				VARCHAR(20)
	, @Ret				INT OUTPUT
AS BEGIN

	SET NOCOUNT ON;

	DECLARE @AID INT;
	SELECT @AID = AID FROM Account WHERE UserID = @UserID;

	-- �����ϴ� �������� �˻�.    
	IF @AID IS NULL BEGIN    
		SET @Ret = 0;
		RETURN @Ret;
	END    
	ELSE BEGIN
	
		DECLARE @RentDate  DATETIME;

		-- @RentHourPeriod���� ������ �Ⱓ������ �˻�.    
		IF @RentHourPeriod = 0 OR @RentHourPeriod IS NULL BEGIN
		
			-- �Ⱓ�� �������� ��� ���� ������ �Ǹ� ���� �˻�    
			DECLARE @RentType	TINYINT
			DECLARE @RCSSPID	INT

			SELECT @RentType = RentType FROM CashSetShop(NOLOCK) WHERE CSSID = @CSSID;
			
			IF @RentType = 1 BEGIN    
				SELECT	@RCSSPID = RCSSPID 
				FROM	RentCashSetShopPrice 
				WHERE	CSSID = @CSSID 
				AND		RentHourPeriod IS NULL
				
				IF (@RCSSPID IS NULL) BEGIN    
					SET @Ret = 0;
					RETURN @Ret;
				END    
			END    

			-- �Ϲ� �������� ���
			SET @RentDate = NULL;
		END    
		ELSE BEGIN    
			SET @RentDate = GETDATE()    
		END


		BEGIN TRAN -------------------    

			DECLARE curBuyCashSetItem  INSENSITIVE CURSOR 
			FOR    
				SELECT	CSID 
				FROM	CashSetItem(NOLOCK) 
				WHERE	CSSID = @CSSID    
			FOR READ ONLY    


			OPEN curBuyCashSetItem     

			DECLARE @varCSID  INT
			DECLARE @ItemID   INT

			FETCH FROM curBuyCashSetItem INTO @varCSID    

			WHILE (@@FETCH_STATUS = 0) BEGIN 
			   
				SELECT	@ItemID = cs.ItemID
				FROM	CashShop cs(NOLOCK)
				WHERE	cs.CSID = @varCSID

				IF (@ItemID IS NOT NULL) BEGIN
					-- ������ ����.    
					INSERT INTO AccountItem(AID, ItemID, RentDate, RentHourPeriod, Cnt)    
					VALUES (@AID, @ItemID, @RentDate, @RentHourPeriod, 1)
				END

				FETCH curBuyCashSetItem INTO @varCSID    
			END    

			CLOSE curBuyCashSetItem     
			DEALLOCATE curBuyCashSetItem

		COMMIT TRAN ------------------   
		
		SET @Ret = 1;
		RETURN @Ret;
	END   
END

-------------------------------------------------------------------------------------------------------------------------
-- ���� ����
/*
DROP PROC spAdmWebInsertSetItem
EXEC sp_rename 'BackUp_spAdmWebInsertSetItem', 'spAdmWebInsertSetItem';
*/

