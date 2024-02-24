-- ���̺� ���� -------------------------------------
----------------------------------------------------
ALTER TABLE CharacterItem ADD RentDate DATETIME null DEFAULT NULL
ALTER TABLE CharacterItem ADD RentHourPeriod SMALLINT null DEFAULT NULL
ALTER TABLE CharacterItem ADD Cnt SMALLINT NULL DEFAULT NULL

ALTER TABLE AccountItem ADD RentDate DATETIME null DEFAULT NULL
ALTER TABLE AccountItem ADD RentHourPeriod SMALLINT null DEFAULT NULL
ALTER TABLE AccountItem ADD Cnt SMALLINT NULL DEFAULT NULL


-- �������ν��� �߰� -------------------------------
----------------------------------------------------
-- ĳ���ٲܶ� 
CREATE PROC [spCheckExpireRentItem]
	@AID			int
AS

Go



















-- �������ν��� ���� -------------------------------
----------------------------------------------------
/* ĳ���� ������ ���� */
CREATE PROC [spSelectCharItem]
	@CID		int
AS
SELECT CIID, ItemID, RentHourPeriod - DateDiff(hh, RentDate, GETDATE()) AS RentPeriodRemainder, Cnt
FROM CharacterItem 
WHERE CID=@CID ORDER BY CIID

GO


CREATE PROC [spSelectAccountItem]
	@AID			int
AS

SELECT AIID, ItemID, RentHourPeriod - DateDiff(hh, RentDate, GETDATE()) AS RentPeriodRemainder, Cnt
FROM AccountItem
WHERE AID=@AID ORDER BY AIID

GO




-- â�� ������ �� ĳ���ͷ� �������� ----------
CREATE PROC [spBringAccountItem]
	@AID		int,
	@CID		int,
	@AIID		int
AS
SET NoCount On

DECLARE @ItemID int
DECLARE @CAID int
DECLARE @OrderCIID int

DECLARE @RentDate			DATETIME
DECLARE @RentHourPeriod		SMALLINT
DECLARE @Cnt				SMALLINT

SELECT @ItemID=ItemID, @RentDate=RentDate, @RentHourPeriod=RentHourPeriod, @Cnt=Cnt
FROM AccountItem WHERE AIID = @AIID


SELECT @CAID = AID FROM Character WHERE CID=@CID

IF @ItemID IS NOT NULL AND @CAID = @AID
BEGIN
	BEGIN TRAN ----------------
	DELETE FROM AccountItem WHERE AIID = @AIID
	INSERT INTO CharacterItem (CID, ItemID, RegDate, RentDate, RentHourPeriod, Cnt)
	VALUES (@CID, @ItemID, GETDATE(), @RentDate, @RentHourPeriod, @Cnt)

	SET @OrderCIID = @@IDENTITY

	INSERT INTO BringAccountItemLog	(ItemID, AID, CID, Date)
	VALUES (@ItemID, @AID, @CID, GETDATE())

	COMMIT TRAN ---------------

	

	SELECT @OrderCIID AS ORDERCIID, @ItemID AS ItemID, @RentHourPeriod - DateDiff(hh, @RentDate, GETDATE()) AS RentPeriodRemainder
END

GO


-- �� ĳ���� ĳ���������� â�� �ֱ� ---------
CREATE PROC [spBringBackAccountItem]
	@AID		int,
	@CID		int,
	@CIID		int
AS

DECLARE @ItemID int
DECLARE @RentDate		DATETIME
DECLARE @RentHourPeriod	SMALLINT
DECLARE @Cnt			SMALLINT

DECLARE @HeadCIID 	int
DECLARE @ChestCIID	int
DECLARE @HandsCIID	int
DECLARE @LegsCIID	int
DECLARE @FeetCIID	int
DECLARE @FingerLCIID	int
DECLARE @FingerRCIID	int
DECLARE @MeleeCIID	int
DECLARE @PrimaryCIID	int
DECLARE @SecondaryCIID	int
DECLARE @Custom1CIID	int
DECLARE @Custom2CIID	int

SELECT 
@HeadCIID=head_slot, @ChestCIID=chest_slot, @HandsCIID=hands_slot, 
@LegsCIID=legs_slot, @FeetCIID=feet_slot, @FingerLCIID=fingerl_slot, @FingerRCIID=fingerr_slot, 
@MeleeCIID=melee_slot, @PrimaryCIID=primary_slot, @SecondaryCIID=secondary_slot, 
@Custom1CIID=custom1_slot, @Custom2CIID=custom2_slot
FROM Character(nolock) WHERE cid=@CID AND aid=@AID

SELECT @ItemID=ItemID, @RentDate=RentDate, @RentHourPeriod=RentHourPeriod, @Cnt=Cnt
FROM CharacterItem WHERE CIID=@CIID AND CID=@CID

IF ((@ItemID IS NOT NULL) AND (@ItemID >= 400000) AND
   (@HeadCIID IS NULL OR @HeadCIID != @CIID) AND
   (@ChestCIID IS NULL OR @ChestCIID != @CIID) AND 
   (@HandsCIID IS NULL OR @HandsCIID != @CIID) AND
   (@LegsCIID IS NULL OR @LegsCIID != @CIID) AND 
   (@FeetCIID IS NULL OR @FeetCIID != @CIID) AND
   (@FingerLCIID IS NULL OR @FingerLCIID != @CIID) AND 
   (@FingerRCIID IS NULL OR @FingerRCIID != @CIID) AND
   (@MeleeCIID IS NULL OR @MeleeCIID != @CIID) AND 
   (@PrimaryCIID IS NULL OR @PrimaryCIID != @CIID) AND
   (@SecondaryCIID IS NULL OR @SecondaryCIID != @CIID) AND 
   (@Custom1CIID IS NULL OR @Custom1CIID != @CIID) AND
   (@Custom2CIID IS NULL OR @Custom2CIID != @CIID))
BEGIN
	BEGIN TRAN -------------
	UPDATE CharacterItem SET CID=NULL WHERE CIID=@CIID AND CID=@CID
	INSERT INTO AccountItem (AID, ItemID, RentDate, RentHourPeriod, Cnt) 
	VALUES (@AID, @ItemID, @RentDate, @RentHourPeriod, @Cnt)
	COMMIT TRAN -----------
END

GO




----------------------------------------------------
-- ĳ���͸� ���� ��
spDeleteChar			-> �����Ұ� ����
spDeleteCharItem		-> �����Ұ� ����
spGetCharInfoExByCID	-> �����Ұ� ����
spGetCharList			-> �����Ұ� ����
spInsertChar			-> �����Ұ� ����
spInsertCharItem		-> ����� ������ �� ����. ���߿� �������� �Ⱓ������ �����ؾ���
spSelectCharItem		-> �����Ұ� ����


-- �߾����ุ ���°�
spSelectAccountItem		-> �����



-- ���� ����
spBuyCashItem				-> �����Ұ;��� -> ���߿� �ݸ����۾��� �����ؾ���
spBuyCashSetItem			-> �����Ұ;��� -> ���߿� �ݸ����۾��� �����ؾ���
spConfirmBuyCashItem		-> �����Ұ;��� -> ���߿� �ݸ����۾��� �����ؾ���
spIsRepeatBuySameCashItem	-> �����Ұ;��� -> ���߿� �ݸ����۾��� �����ؾ���
spPresentCashItem			-> �����Ұ;��� -> ���߿� �ݸ����۾��� �����ؾ���
spPresentCashSetItem		-> �����Ұ;��� -> ���߿� �ݸ����۾��� �����ؾ���


-- ���� ���°�
spBringAccountItem		-> �����. cpp�� ����Ǿ��Ѵ�.
spBringbackAccountItem	-> �����.






