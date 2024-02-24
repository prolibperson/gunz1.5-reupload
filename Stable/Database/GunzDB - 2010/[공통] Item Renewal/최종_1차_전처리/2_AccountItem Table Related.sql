USE GunzDB
GO

-----------------------------------------------------------------------------------------------------------
-- �۾��� ����

-- AccountItem ���̺��� Cnt �÷��� 1�� ��� �ʱ�ȭ�Ѵ�.
-- ���� 1) Cnt �÷��� ���� ��� ������ش�(INT��)
-- ���� 2) �ð��� ���� �ɸ��� �����̹Ƿ�, ���� ��ġ�� ���� ����!
--        (�ð��� �ʹ� �÷� �ɸ� ���, DBA �Ǵܿ� ���� ó���Ѵ�)
UPDATE	AccountItem
SET		Cnt = 1

-- AccountItem ���̺��� Cnt �÷��� ���� Default ���� ������ �Ǵ�.
-- ���� 1) �̹� ���� ���, ������ ���� ������ �����Ѵ�.
--        (ex. ALTER TABLE dbo.AccountItem DROP CONSTRAINT DF__AccountItem_Cnt_1352D76D)
ALTER TABLE dbo.AccountItem ADD CONSTRAINT DF_AccountItem_Cnt DEFAULT(1) FOR Cnt


-- �߾����࿡ �ִ� �׺� �����۵��� �����ִ� ����
-- ���� 1) ���� ��ġ�� ��, �����Ű�� �ʾƵ� �ȴ�(�׷��Ƿ� �ϴ� �ּ�ó��)
/*
SELECT	gi.Name, ai.*
INTO	AccountGambleItem
FROM	AccountItem ai(NOLOCK), GambleItem gi(NOLOCK)
WHERE	ai.ItemID = gi.GIID
	
DELETE	ai
FROM	AccountItem ai, AccountGambleItem ag
WHERE	ai.AIID = ag.AIID

INSERT AccountItem(AID, ItemID, RentDate, RentHourPeriod, Cnt)
	SELECT	ag.AID, ag.ItemID, GETDATE(), 0, COUNT(ag.ItemID) AS ItemCnt
	FROM	AccountGambleItem ag(NOLOCK)
	GROUP BY ag.AID, ag.ItemID HAVING COUNT(ag.ItemID) > 1
*/			


	




-----------------------------------------------------------------------------------------------------------
-- ���� ����
/*

SELECT	ai.*
INTO	AccountGambleItemForRollBack
FROM	AccountItem ai(NOLOCK), GambleItem gi(NOLOCK)
WHERE	ai.ItemID = gi.GIID
AND		ai.Cnt > 1

DELETE	ai
FROM	AccountItem ai, AccountGambleItemForRollBack ag
WHERE	ai.AIID = ag.AIID
	
	
DECLARE @AID		INT
DECLARE	@ItemID		INT
DECLARE	@Cnt		INT
DECLARE @RentDate	DATETIME	

DECLARE Curs CURSOR FAST_FORWARD FOR   
SELECT ag.AID, ag.ItemID, ag.RentDate, ag.Cnt
FROM   AccountGambleItemForRollBack ag

OPEN Curs
FETCH NEXT FROM Curs INTO @AID, @ItemID, @RentDate, @Cnt

WHILE( @@FETCH_STATUS = 0 ) BEGIN
	
	INSERT AccountItem(AID, ItemID, RentDate, Cnt)
	VALUES(@AID, @ItemID, @RentDate, NULL)		
	
	IF (0 <> @@ERROR) BEGIN  
		ROLLBACK TRAN;  
		CLOSE Curs;  
		DEALLOCATE Curs;  
		RETURN;  
	END

	SET @Cnt = @Cnt - 1
	
	IF( @Cnt = 0 ) BEGIN
		FETCH NEXT FROM Curs INTO @AID, @ItemID, @RentDate, @Cnt
	END
END

CLOSE Curs
DEALLOCATE Curs
		
DROP TABLE AccountGambleItemForRollBack;
DROP TABLE AccountItemMoveLog;

*/