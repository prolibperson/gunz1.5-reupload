/* ������ ���� */
CREATE PROC [spBuyCashItem]
	@UserID		varchar(20)
,	@CSID		int
,	@Cash		int
AS

DECLARE @ItemID		int
DECLARE @AID		int

/* Account�� ������ RETURN 0 */
SELECT @AID=AID FROM Account where UserID = @UserID

IF @AID IS NULL
BEGIN
	RETURN 0

END
ELSE
BEGIN
	SELECT @ItemID = cs.ItemID FROM CashShop cs
	WHERE @CSID = cs.csid

	if @ItemID IS NOT NULL
	BEGIN
		/* ���� ������ ���� */
		INSERT INTO AccountItem (AID, ItemID)
		Values	(@AID, @ItemID)

		/* �α� ���� */
		INSERT INTO ItemPurchaseLogByCash
		(ItemID, AID, Date, Cash)
		VALUES
		(@ItemID, @AID, GETDATE(), @Cash)

		RETURN 1
	END
	ELSE
	BEGIN
		RETURN 0
	END
END

Go

--------------------------------------------------------------------------
/* ��Ʈ ������ ���� */
CREATE PROC [spBuyCashSetItem]
	@UserID		varchar(20)
,	@CSSID		int
,	@Cash		int
AS

DECLARE @ItemID		int
DECLARE @AID		int

/* Account�� ������ RETURN 0 */
SELECT @AID=AID FROM Account where UserID = @UserID

IF @AID IS NULL
BEGIN
	RETURN 0
END
ELSE
BEGIN

	BEGIN TRAN --------------------------------------------

		DECLARE curBuyCashSetItem INSENSITIVE CURSOR
		FOR
			SELECT csid FROM CashSetItem WHERE CSSID = @CSSID
		FOR READ ONLY

		OPEN curBuyCashSetItem

		DECLARE @varCSID int
		DECLARE @sql varchar(100)

		FETCH FROM curBuyCashSetItem INTO @varCSID

		WHILE @@FETCH_STATUS = 0
		BEGIN
			SELECT @ItemID = cs.ItemID FROM CashShop cs	WHERE @varCSID = cs.csid

			IF @ItemID IS NOT NULL
			BEGIN
				/* ���� ������ ���� */
				INSERT INTO AccountItem (AID, ItemID) Values	(@AID, @ItemID)
			END
	
			FETCH FROM curBuyCashSetItem INTO @varCSID
		END

		CLOSE curBuyCashSetItem
		DEALLOCATE curBuyCashSetItem

		/* �α� ���� */
		INSERT INTO SetItemPurchaseLogByCash (AID, CSSID, Date, Cash)
		VALUES (@AID, @CSSID, GETDATE(), @Cash)

	COMMIT TRAN ------------------------------------------

	RETURN 1
END

Go
--------------------------------------------------------------------------

/* �űԾ����� ���� */
CREATE PROC [spGetNewCashItem]
	@ItemCount	int 	= 0
AS

IF @ItemCount != 0
BEGIN
	SET ROWCOUNT @ItemCount
END

	SELECT cs.csid AS CSID, i.name AS Name, i.Slot AS Slot, 
		i.CashPrice AS Cash, i.WebImgName As WebImgName,
		i.ResSex AS ResSex, i.ResLevel AS ResLevel, i.Weight AS Weight,
		i.Description AS Description
	FROM CashShop cs, Item i
	WHERE i.ItemID = cs.ItemID AND cs.IsNewItem = 1
	order by cs.csid desc
Go



/* ������ ����Ʈ �������� */
CREATE PROC [spGetCashItemList]
	@ItemType	int,
	@Page		int,
	@PageCount	int OUTPUT
AS

DECLARE @Rows int

SELECT @Rows = @Page * 8	/* ���������� 8���� �����ش� */
SET ROWCOUNT @Rows

IF @ItemType = 1 /* �������� */
BEGIN
	SELECT @PageCount = (COUNT(*) + 7) / 8
	FROM CashShop cs, Item i
	WHERE i.ItemID = cs.ItemID AND i.Slot = 1

	SELECT cs.csid AS CSID, i.name AS Name, i.Slot AS Slot,
		i.CashPrice AS Cash, i.WebImgName As WebImgName,
		i.ResSex AS ResSex, i.ResLevel AS ResLevel, i.Weight AS Weight,
		i.Description AS Description, cs.RegDate As RegDate, cs.IsNewItem
	INTO #tempcashitem1
	FROM CashShop cs, Item i
	WHERE i.ItemID = cs.ItemID AND i.Slot = 1
	
	SELECT *
	FROM (SELECT TOP 8 * FROM #tempcashitem1 a ORDER BY a.csid asc) a
	ORDER BY a.csid desc

	DROP TABLE #tempcashitem1
END
ELSE
IF @ItemType=2 		/* ���Ÿ����� */
BEGIN
	SELECT @PageCount = (COUNT(*) + 7) / 8
	FROM CashShop cs, Item i
	WHERE i.ItemID = cs.ItemID AND i.Slot = 2

	SELECT cs.csid AS CSID, i.name AS Name, i.Slot AS Slot,
		i.CashPrice AS Cash, i.WebImgName As WebImgName,
		i.ResSex AS ResSex, i.ResLevel AS ResLevel, i.Weight AS Weight,
		i.Description AS Description, cs.RegDate As RegDate, cs.IsNewItem
	INTO #tempcashitem2
	FROM CashShop cs, Item i
	WHERE i.ItemID = cs.ItemID AND i.Slot = 2
	
	SELECT *
	FROM (SELECT TOP 8 * FROM #tempcashitem2 a ORDER BY a.csid asc) a
	ORDER BY a.csid desc

	DROP TABLE #tempcashitem2

END
ELSE
IF @ItemType=3 		/* �� */
BEGIN
	SELECT @PageCount = (COUNT(*) + 7) / 8
	FROM CashShop cs, Item i
	WHERE i.ItemID = cs.ItemID AND i.Slot BETWEEN 4 AND 8

	SELECT cs.csid AS CSID, i.name AS Name, i.Slot AS Slot,
		i.CashPrice AS Cash, i.WebImgName As WebImgName,
		i.ResSex AS ResSex, i.ResLevel AS ResLevel, i.Weight AS Weight,
		i.Description AS Description, cs.RegDate As RegDate, cs.IsNewItem
	INTO #tempcashitem3
	FROM CashShop cs, Item i
	WHERE i.ItemID = cs.ItemID AND i.Slot BETWEEN 4 AND 8
	
	SELECT *
	FROM (SELECT TOP 8 * FROM #tempcashitem3 a ORDER BY a.csid asc) a
	ORDER BY a.csid desc

	DROP TABLE #tempcashitem3

END
ELSE
IF @ItemType=4 		/* Ư�������� */
BEGIN
	SELECT @PageCount = (COUNT(*) + 7) / 8
	FROM CashShop cs, Item i
	WHERE i.ItemID = cs.ItemID AND i.Slot = 3

	SELECT cs.csid AS CSID, i.name AS Name, i.Slot AS Slot,
		i.CashPrice AS Cash, i.WebImgName As WebImgName,
		i.ResSex AS ResSex, i.ResLevel AS ResLevel, i.Weight AS Weight,
		i.Description AS Description, cs.RegDate As RegDate, cs.IsNewItem
	INTO #tempcashitem4
	FROM CashShop cs, Item i
	WHERE i.ItemID = cs.ItemID AND i.Slot = 3
	
	SELECT *
	FROM (SELECT TOP 8 * FROM #tempcashitem4 a ORDER BY a.csid asc) a
	ORDER BY a.csid desc

	DROP TABLE #tempcashitem4
END


Go


/* ��Ʈ ������ ��� �������� */
CREATE PROC [spGetCashSetItemList]
	@Page		int,
	@PageCount	int OUTPUT
AS

DECLARE @Rows int

SELECT @Rows = @Page * 8	/* ���������� 8���� �����ش� */
SET ROWCOUNT @Rows

SELECT @PageCount = (COUNT(*) + 7) / 8 FROM CashSetShop

SELECT CSSID AS CSSID, Name AS Name, CashPrice AS Cash, WebImgName AS WebImgName, 
	ResSex AS ResSex, ResLevel AS ResLevel,
	Description AS Description, RegDate AS RegDate, IsNewItem As IsNewItem
INTO #tempcashsetitem
FROM CashSetShop css

SELECT * 
FROM (SELECT TOP 8 * FROM #tempcashsetitem a ORDER BY a.cssid asc) a
ORDER BY a.cssid DESC

DROP TABLE #tempcashsetitem

Go



/* ��Ʈ �������� ���ξ����� ��� ���� */
CREATE PROC [spGetCashSetItemComposition]
	@CSSID		int
AS

SELECT cs.csid AS CSID, i.name AS Name, i.ItemTypeID AS ItemType, 
	i.CashPrice AS Cash, i.WebImgName As WebImgName,
	i.ResSex AS ResSex, i.ResLevel AS ResLevel, i.Weight AS Weight,
	i.Description AS Description, cs.RegDate As RegDate

FROM CashSetItem csi, CashShop cs, Item i
WHERE @CSSID = csi.CSSID AND csi.csid = cs.csid
	AND cs.ItemID = i.ItemID

Go


/* �������� �� ���� ���� */
CREATE PROC [spGetCashItemInfo]
	@CSID		int
AS
	SELECT cs.csid AS CSID, i.name AS Name, i.Slot AS Slot, 
		i.CashPrice AS Cash, i.WebImgName As WebImgName,
		i.ResSex AS ResSex, i.ResLevel AS ResLevel, i.Weight AS Weight,
		i.Damage AS Damage, i.Delay AS Delay, i.Controllability AS Controllability,
		i.Magazine AS Magazine, i.MaxBullet AS MaxBullet, i.ReloadTime AS ReloadTime, 
		i.HP AS HP, i.AP AS AP,	i.MAXWT AS MaxWeight, 
		i.FR AS FR, i.CR AS CR, i.PR AS PR, i.LR AS LR,
		i.Description AS Description, cs.IsNewItem
	FROM CashShop cs, Item i
	WHERE i.ItemID = cs.ItemID AND cs.csid = @CSID
Go





/* ������ �˻� */
CREATE PROC [spSearchCashItem]
	@Slot		tinyint,
	@ResSex		tinyint,
	@ResMinLevel	int,
	@ResMaxLevel	int,
	@ItemName	varchar(256) = ''
AS

IF @ItemName = ''
BEGIN
	SELECT cs.csid AS CSID, i.name AS Name, i.Slot AS Slot, 
		i.CashPrice AS Cash, i.WebImgName As WebImgName,
		i.ResSex AS ResSex, i.ResLevel AS ResLevel, i.Weight AS Weight,
		i.Description AS Description, cs.IsNewItem
	FROM CashShop cs, Item i
	WHERE i.ItemID = cs.ItemID AND i.Slot = @Slot AND
		(i.ResSex = @ResSex OR i.ResSex = 3) AND
		i.ResLevel >= @ResMinLevel AND
		i.ResLevel <= @ResMaxLevel
	order by cs.csid desc
END
ELSE
BEGIN
	SELECT cs.csid AS CSID, i.name AS Name, i.Slot AS Slot, 
		i.CashPrice AS Cash, i.WebImgName As WebImgName,
		i.ResSex AS ResSex, i.ResLevel AS ResLevel, i.Weight AS Weight,
		i.Description AS Description, cs.IsNewItem
	FROM CashShop cs, Item i
	WHERE i.ItemID = cs.ItemID AND i.Slot = @Slot AND
		(i.ResSex = @ResSex OR i.ResSex = 3) AND
		i.ResLevel >= @ResMinLevel AND
		i.ResLevel <= @ResMaxLevel AND 
		i.Name LIKE '%@ItemName%'
	order by cs.csid desc
END
Go











-- ���ӿ��� �ʿ��� �������ν��� ----------------------------------------
CREATE PROC [spSelectAccountItem]
	@AID			int
AS

SELECT AIID, AID, ItemID FROM AccountItem
WHERE AID=@AID ORDER BY AIID
Go

