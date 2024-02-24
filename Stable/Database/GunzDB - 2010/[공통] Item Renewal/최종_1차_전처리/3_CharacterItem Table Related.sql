USE GunzDB
GO

-----------------------------------------------------------------------------------------------------------
-- �۾��� ����

-- CharacterItem ���̺��� Cnt �÷��� 1�� ��� �ʱ�ȭ�Ѵ�.
-- ���� 1) Cnt �÷��� ���� ��� ������ش�(INT��)
-- ���� 2) �ð��� ���� �ɸ��� �����̹Ƿ�, ���� ��ġ�� ���� ����!
--        (�ð��� �ʹ� �÷� �ɸ� ���, DBA �Ǵܿ� ���� ó���Ѵ�)
UPDATE	CharacterItem
SET		Cnt = 1


-- CharacterItem ���̺��� Cnt �÷��� ���� Default ���� ������ �Ǵ�.
-- ���� 1) �̹� ���� ���, ������ ���� ������ �����Ѵ�.
--        (ex. ALTER TABLE CharacterItem DROP CONSTRAINT DF__CharacterIt__Cnt__10766AC2)
ALTER TABLE dbo.CharacterItem ADD CONSTRAINT DF_CharacterItem_Cnt DEFAULT(1) FOR Cnt


-- �ɸ��͵��� �����ϰ� �ִ� �׺� �����۵��� �����ִ� ����
-- ���� 1) ���� ��ġ�� ��, �����Ű�� �ʾƵ� �ȴ�(�׷��Ƿ� �ϴ� �ּ�ó��)
/*
SELECT	gi.Name, ci.*
INTO	CharacterGambleItem
FROM	CharacterItem ci(NOLOCK), GambleItem gi(NOLOCK)
WHERE	ci.ItemID = gi.GIID

DELETE	ci
FROM	CharacterItem ci, CharacterGambleItem cg
WHERE	ci.CIID = cg.CIID

INSERT CharacterItem(CID, ItemID, RentDate, RentHourPeriod, Cnt)
	SELECT	cg.CID, cg.ItemID, GETDATE(), 0, COUNT(cg.ItemID) AS ItemCnt
	FROM	CharacterGambleItem cg(NOLOCK)
	GROUP BY cg.CID, cg.ItemID HAVING COUNT(cg.ItemID) > 1

DROP TABLE CharacterGambleItem;	
*/



-----------------------------------------------------------------------------------------------------------
-- ���� ����

/*	
SELECT	ci.*
INTO	CharacterGambleItemForRollBack
FROM	CharacterItem ci(NOLOCK), GambleItem gi(NOLOCK)
WHERE	ci.ItemID = gi.GIID
AND		ci.Cnt > 1
	
DELETE	ci
FROM	CharacterItem ci, CharacterGambleItemForRollBack cg
WHERE	ci.CIID = cg.CIID
	

DECLARE @CID		INT
DECLARE	@ItemID		INT
DECLARE	@Cnt		INT
DECLARE @RentDate	DATETIME	

DECLARE Curs CURSOR FAST_FORWARD FOR   
	SELECT cg.CID, cg.ItemID, cg.RentDate, cg.Cnt
	FROM   CharacterGambleItemForRollBack cg
	
OPEN Curs
FETCH NEXT FROM Curs INTO @CID, @ItemID, @RentDate, @Cnt

WHILE( @@FETCH_STATUS = 0 ) BEGIN
	
	INSERT CharacterItem(CID, ItemID, RentDate, Cnt)
	VALUES(@CID, @ItemID, @RentDate, NULL)		
	
	IF (0 <> @@ERROR) BEGIN  
		ROLLBACK TRAN;  
		CLOSE Curs;  
		DEALLOCATE Curs;  
		RETURN;  
	END

	SET @Cnt = @Cnt - 1
	
	IF( @Cnt = 0 ) BEGIN
		FETCH NEXT FROM Curs INTO @CID, @ItemID, @RentDate, @Cnt
	END
END  

CLOSE Curs  
DEALLOCATE Curs  

DROP TABLE CharacterGambleItemForRollBack;
*/