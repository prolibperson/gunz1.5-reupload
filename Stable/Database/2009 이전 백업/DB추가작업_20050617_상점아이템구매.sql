-- ���ӳ� �������� ������ ����
-- Ex) EXEC spBuyBountyItem 1077, 7, 100
CREATE   PROC [spBuyBountyItem]
	@CID		INT,
	@ItemID		INT,
	@Price		INT
AS
BEGIN
	DECLARE @OrderCIID	int
	DECLARE @Bounty	INT

	BEGIN TRAN
		-- �ܾװ˻�
		SELECT @Bounty=BP FROM Character(NOLOCK) WHERE CID=@CID
		IF @Bounty IS NULL OR @Bounty < @Price
		BEGIN
			ROLLBACK
			RETURN 0
		END

		-- Bounty ����
		UPDATE Character SET BP=BP-@Price WHERE CID=@CID
		IF @@ERROR <> 0
		BEGIN
			ROLLBACK
			RETURN (-1)
		END

		-- Item �߰�
		INSERT INTO CharacterItem (CID, ItemID, RegDate) Values (@CID, @ItemID, GETDATE())
		IF @@ERROR <> 0
		BEGIN
			ROLLBACK
			RETURN (-1)
		END

		SELECT @OrderCIID = @@IDENTITY
		
		-- Item ���ŷα� �߰�
		INSERT INTO ItemPurchaseLogByBounty (ItemID, CID, Date, Bounty, CharBounty, Type)
		VALUES (@ItemID, @CID, GETDATE(), @Price, @Bounty, '����')

		SELECT @OrderCIID as ORDERCIID
	COMMIT TRAN

	RETURN 1
END
GO


-- ���ӳ� �������� ������ �Ǹ�
CREATE   PROC [spSellBountyItem]
	@CID		INT,
	@ItemID		INT,
	@CIID		INT,
	@Price		INT,
	@CharBP		INT
AS
BEGIN
	BEGIN TRAN
		-- Item ����
		UPDATE CharacterItem SET CID=NULL WHERE CID=@CID AND CIID=@CIID
		IF (@@ERROR <> 0) OR (@@ROWCOUNT = 0)
		BEGIN
			ROLLBACK
			RETURN (-1)
		END

		-- Bounty ����
		UPDATE Character SET BP=BP+@Price WHERE CID=@CID
		IF (@@ERROR <> 0) OR (@@ROWCOUNT = 0)
		BEGIN
			ROLLBACK
			RETURN (-1)
		END

		-- Item �Ǹ� �α� �߰�
		INSERT INTO ItemPurchaseLogByBounty (ItemID, CID, Date, Bounty, CharBounty, Type)
		VALUES (@ItemID, @CID, GETDATE(), @Price, @CharBP, '�Ǹ�')

		SELECT 1 as Ret
	COMMIT TRAN

	RETURN 1
END
GO

