-- ���̺� ������ ����
ALTER TABLE CashShop ADD RentType tinyint
ALTER TABLE CashSetShop ADD RentType tinyint


ALTER TABLE ItemPurchaseLogByCash ADD RentHourPeriod int NULL
ALTER TABLE SetItemPurchaseLogByCash ADD RentHourPeriod int NULL
ALTER TABLE CashItemPresentLog ADD RentHourPeriod int NULL



-- �Ⱓ�� ������ ���� ���̺�
CREATE TABLE RentCashShopPrice(
	RCSPID		int 		IDENTITY PRIMARY KEY,
	CSID 		int		FOREIGN KEY REFERENCES CashShop(CSID)
					ON UPDATE CASCADE 
					ON DELETE NO ACTION,
	RentHourPeriod 	smallint,
	CashPrice 	int 
)

CREATE INDEX RentCashShopPriceIndex ON RentCashShopPrice (CSID)
go


-- �Ⱓ�� ��Ʈ ������ ���� ���̺�
CREATE TABLE RentCashSetShopPrice(
	RCSSPID 	int 		IDENTITY PRIMARY KEY,
	CSSID 		int		FOREIGN KEY REFERENCES CashSetShop(CSSID)
					ON UPDATE CASCADE
					ON DELETE NO ACTION,
	RentHourPeriod 	smallint,
	CashPrice 	int 
)

CREATE INDEX RentCashSetShopPriceIndex ON RentCashSetShopPrice (CSSID)


-- �Ⱓ�� ������ ��ǰ ���� �Է�
CREATE PROC [spInsertRentCashShopPrice]
	@CSID			int
,	@RentHourPeriod		smallint
,	@CashPrice		int
AS
	INSERT INTO RentCashShopPrice (CSID, RentHourPeriod, CashPrice)
	VALUES (@CSID, @RentHourPeriod, @CashPrice)
GO


-- �Ⱓ�� ��Ʈ ������ ��ǰ ���� �Է�
CREATE PROC [spInsertRentCashSetShopPrice]
	@CSSID		int,
	@RentHourPeriod	smallint,
	@CashPrice	int
AS
	INSERT INTO RentCashSetShopPrice(CSSID, RentHourPeriod, CashPrice) 
	VALUES (@CSSID, @RentHourPeriod, @CashPrice)
GO


-- �Ⱓ�� ������ ��ǰ ���� ����
CREATE PROC [spGetRentCashShopPrice]
	@CSID		int
AS
	SELECT RentHourPeriod, CashPrice 
	FROM RentCashShopPrice WHERE CSID = @CSID
	ORDER BY CashPrice
GO


-- �Ⱓ�� ��Ʈ ������ ��ǰ ���� ����
CREATE  PROC [spGetRentCashSetShopPrice]
	@CSSID		int
AS
	SELECT RentHourPeriod, CashPrice 
	FROM RentCashSetShopPrice WHERE CSSID = @CSSID
	ORDER BY CashPrice
GO



-- cash shop���� �ŷ��� �������� accountitme�� �߰�.
CREATE  PROC [spBuyCashItem]
	@UserID		varchar(20),
	@CSID		int,
	@Cash		int,
	@RentHourPeriod smallint = NULL
AS
	SET NoCount On

	DECLARE @AID		int
	DECLARE @ItemID		int

	-- Account �˻�
	SELECT @AID = AID FROM Account WHERE UserID = @UserID
	IF @AID IS NULL
	BEGIN
		RETURN 0
	END
	ELSE
	BEGIN
		SELECT @ItemID = ItemID FROM CashShop cs (NOLOCK) WHERE cs.CSID = @CSID

		IF @ItemID IS NOT NULL
		BEGIN 

			BEGIN TRAN

			DECLARE @RentDate	datetime

			-- @RentHourPeriod���� ������ �Ⱓ������ �˻�.
			IF @RentHourPeriod = 0 OR @RentHourPeriod IS NULL
			BEGIN
				SET @RentDate = NULL
			END
			ELSE
			BEGIN
				SET @RentDate = GETDATE()
			END

			-- ������ ����.
			INSERT INTO accountitem(AID, ItemID, RentDate, RentHourPeriod) 
			VALUES (@AID, @ItemID, @RentDate, @RentHourPeriod)

			-- ������ �ŷ� log����.
			INSERT INTO ItemPurchaseLogByCash(AID, ItemID, Date, RentHourPeriod, Cash) 
			VALUES (@AID, @ItemID, GETDATE(), @RentHourPeriod, @Cash)

			COMMIT TRAN

			RETURN 1

		END	
		ELSE
		BEGIN
			RETURN 0
		END
	END

	RETURN 1
GO





-- cash set shop���� �ŷ��� �������� accountitme�� �߰�.
CREATE   PROC [spBuyCashSetItem]
	@UserID		varchar(20),
	@CSSID		int,
	@Cash		int,
	@RentHourPeriod smallint = NULL
AS
	SET NoCount On

	DECLARE @AID		int
	
	SELECT @AID = AID FROM Account WHERE UserID = @UserID

	-- �����ϴ� �������� �˻�.
	IF @AID IS NULL
	BEGIN
		RETURN 0
	END
	ELSE
	BEGIN

		BEGIN TRAN

		DECLARE curBuyCashSetItem 	INSENSITIVE CURSOR

		FOR
			SELECT CSID FROM CashSetItem (NOLOCK) WHERE CSSID = @CSSID
		FOR READ ONLY

		OPEN curBuyCashSetItem 

		DECLARE @varCSID		int
		DECLARE @ItemID			int
		DECLARE @RentDate		datetime			

		FETCH FROM curBuyCashSetItem INTO @varCSID

		-- @RentHourPeriod���� ������ �Ⱓ������ �˻�.
		IF @RentHourPeriod = 0 OR @RentHourPeriod IS NULL
		BEGIN
			SET @RentDate = NULL
		END
		ELSE
		BEGIN
			SET @RentDate = GETDATE()
		END


		WHILE @@FETCH_STATUS = 0
		BEGIN
			SELECT @ItemID = cs.ItemID
			FROM CashShop cs (NOLOCK) 
			WHERE cs.CSID = @varCSID 

			IF @ItemID IS NOT NULL
			BEGIN
				-- ������ ����.
				INSERT INTO AccountItem(AID, ItemID, RentDate, RentHourPeriod)
				VALUES (@AID, @ItemID, @RentDate, @RentHourPeriod)
			END

			FETCH curBuyCashSetItem  INTO @varCSID
		END

		CLOSE curBuyCashSetItem 
		DEALLOCATE curBuyCashSetItem 

		-- ��Ʈ ������ ���� �α�.
		INSERT INTO SetItemPurchaseLogByCash (AID, CSSID, Date, RentHourPeriod, Cash)
		VALUES (@AID, @CSSID, GETDATE(), @RentHourPeriod, @Cash)

		COMMIT TRAN
		RETURN 1
	END
GO



-- ���� ������ �����ϱ�
CREATE PROC [spPresentCashItem]
	@SenderUserID	varchar(20)
,	@ReceiverUserID	varchar(20)
,	@CSID		int
,	@Cash		int
,	@RentHourPeriod	smallint = NULL
AS
	SET NoCount On

	DECLARE	@ItemID		int
	DECLARE @ReceiverAID	int

	SELECT @ReceiverAID = AID FROM Account (NOLOCK) WHERE UserID = @ReceiverUserID
	
	IF @ReceiverAID IS NULL
	BEGIN
		RETURN 0
	END
	ELSE
	BEGIN
		BEGIN TRAN

		SELECT @ItemID = ItemID FROM CashShop (NOLOCK) WHERE CSID = @CSID

		IF @ItemID IS NOT NULL
		BEGIN
			DECLARE @RentDate 	datetime
				
			-- @RentHourPeriod���� ������ �Ⱓ������ �˻�.
			IF @RentHourPeriod = 0 OR @RentHourPeriod IS NULL
			BEGIN
				SET @RentDate = NULL
			END
			ELSE
			BEGIN
				SET @RentDate = GETDATE()
			END

			
			-- ������ ����.
			INSERT INTO AccountItem (AID, ItemID, RentDate, RentHourPeriod)
			VALUES (@ReceiverAID, @ItemID, @RentDate, @RentHourPeriod)

			-- ���� �α� ����.
			INSERT INTO CashItemPresentLog (SenderUserID, ReceiverAID, CSID, Date, Cash, RentHourPeriod)
			VALUES (@SenderUserID, @ReceiverAID, @CSID, GETDATE(), @Cash, @RentHourPeriod)
		END
		ELSE
		BEGIN
			RETURN 0
		END

		COMMIT TRAN
		RETURN 1
	END
GO



-- ��Ʈ ������ �����ϱ�.
CREATE PROC [spPresentCashSetItem]
	@SenderUserID	varchar(20)
,	@ReceiverUserID	varchar(20)
,	@CSSID		int
,	@Cash		int
,	@RentHourPeriod	smallint = NULL
AS
	SET NoCount On

	DECLARE @ReceiverAID	int

	SELECT @ReceiverAID = AID FROM Account WHERE UserID = @ReceiverUserID

	IF @ReceiverAID IS NOT NULL
	BEGIN

		BEGIN TRAN

			DECLARE curBuyCashSetItem 	INSENSITIVE CURSOR

			FOR
				SELECT CSID FROM CashSetItem WHERE CSSID = @CSSID
			FOR READ ONLY

			OPEN curBuyCashSetItem

			DECLARE @varCSID	int
			DECLARE @RentDate	datetime
			DECLARE @ItemID		int

			FETCH FROM curBuyCashSetItem INTO @varCSID

			-- @RentHourPeriod���� ������ �Ⱓ������ �˻�.
			IF @RentHourPeriod = 0 OR @RentHourPeriod IS NULL
			BEGIN
				SET @RentDate = NULL
			END
			ELSE
			BEGIN
				SET @RentDate = GETDATE()
			END


			WHILE @@FETCH_STATUS = 0
			BEGIN
				SELECT @ItemID = ItemID FROM CashShop WHERE CSID = @varCSID

				IF @ItemID IS NOT NULL
				BEGIN	
					-- ������ ����.
					INSERT INTO AccountItem (AID, ItemID, RentDate, RentHourPeriod)
					VALUES (@ReceiverAID, @ItemID, @RentDate, @RentHourPeriod)
				END
				
				FETCH FROM curBuyCashSetItem INTO @varCSID
			END

		CLOSE curBuyCashSetItem
		DEALLOCATE curBuyCashSetItem

		-- ��Ʈ������ ���� �α� ����.
		INSERT INTO CashItemPresentLog (SenderUserID, ReceiverAID, CSSID, Date, RentHourPeriod, Cash)
		VALUES (@SenderUserID, @ReceiverAID, @CSSID, GETDATE(), @RentHourPeriod, @Cash)

		COMMIT TRAN
		RETURN 1

	END
	ELSE
	BEGIN
		RETURN 0
	END


GO


-- �Ϲݾ����� �Ⱓ���� ���ݾ˾ƺ���
CREATE PROC [spGetRentCashShopPriceByHour]
	@CSID		int
,	@RentHourPeriod	smallint
AS
	SELECT CashPrice 
	FROM RentCashShopPrice 
	WHERE CSID = @CSID AND RentHourPeriod = @RentHourPeriod
GO


-- ��Ʈ������ �Ⱓ���� ���ݾ˾ƺ���
CREATE PROC [spGetRentCashSetShopPriceByHour]
	@CSSID		int
,	@RentHourPeriod	smallint
AS
	SELECT CashPrice
	FROM RentCashSetShopPrice 
	WHERE CSSID = @CSSID AND RentHourPeriod = @RentHourPeriod
GO
