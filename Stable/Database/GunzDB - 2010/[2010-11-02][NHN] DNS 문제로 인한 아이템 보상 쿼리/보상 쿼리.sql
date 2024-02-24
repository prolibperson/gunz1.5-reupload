USE GunzDB
GO


----------------------------------------------------------------------------------------------------------------
-- �������� ���� ��¥�� �������ָ� �Ǵ� ������

-- Type 1
-- �ٷ� ������Ʈ ���ֱ�
UPDATE	ai
SET		ai.RentHourPeriod = ai.RentHourPeriod + 72
FROM	AccountItem ai
WHERE	ai.RentDate IS NOT NULL
AND		ai.RentDate < '2010-10-28 00:00:00.0'
AND		DATEADD(hh, ai.RentHourPeriod, ai.RentDate) > '2010-10-26 18:40:00.0'
AND		DATEADD(hh, ai.RentHourPeriod, ai.RentDate)	> GETDATE()

UPDATE	ci
SET		ci.RentHourPeriod = ci.RentHourPeriod + 72
FROM	CharacterItem ci
WHERE	ci.RentDate IS NOT NULL
AND		ci.RentDate < '2010-10-28 00:00:00.0'
AND		DATEADD(hh, ci.RentHourPeriod, ci.RentDate) > '2010-10-26 18:40:00.0'
AND		DATEADD(hh, ci.RentHourPeriod, ci.RentDate)	> GETDATE()




/*
-- Type 2
-- ����, �ӽ� ���̺��� ���� ���� ��.. �� �� ���캸�� �������ֱ�!
SELECT	ai.*
INTO	TempAccountItem
FROM	AccountItem ai
WHERE	ai.RentDate IS NOT NULL
AND		ai.RentDate < '2010-10-28 00:00:00.0'
AND		DATEADD(hh, ai.RentHourPeriod, ai.RentDate) > '2010-10-26 18:40:00.0'
AND		DATEADD(hh, ai.RentHourPeriod, ai.RentDate)	> GETDATE()


SELECT	ci.*
INTO	TempCharacterItem
FROM	CharacterItem ci
WHERE	ci.RentDate IS NOT NULL
AND		ci.RentDate < '2010-10-28 00:00:00.0'
AND		DATEADD(hh, ci.RentHourPeriod, ci.RentDate) > '2010-10-26 18:40:00.0'
AND		DATEADD(hh, ci.RentHourPeriod, ci.RentDate)	> GETDATE()

UPDATE	ai
SET		ai.RentHourPeriod = ai.RentHourPeriod + 72
FROM	AccountItem ai JOIN TempAccountItem t
ON		ai.AIID = t.AIID


UPDATE	ci
SET		ci.RentHourPeriod = ci.RentHourPeriod + 72
FROM	CharacterItem ci JOIN TempCharacterItem t
ON		ci.CIID = t.CIID

DROP TABLE TempAccountItem;
DROP TABLE TempCharacterItem;
*/



----------------------------------------------------------------------------------------------------------------
-- ���Ӱ� �������� �־���� �Ǵ� ������

/*
SELECT	AID, ItemID, GETDATE(), 72
FROM	ItemPurchaseLogByCash l
WHERE	l.Date < '2010-10-28 00:00:00.0'
AND		DATEADD(hh, l.RentHourPeriod, l.Date) > '2010-10-26 18:40:00.0'
AND		DATEADD(hh, l.RentHourPeriod, l.Date) < GETDATE()
*/

INSERT AccountItem(AID, ItemID, RentDate, RentHourPeriod)
	SELECT	l.AID, l.ItemID, GETDATE(), 72
	FROM	ItemPurchaseLogByCash l
	WHERE	l.Date < '2010-10-28 00:00:00.0'
	AND		l.RentHourPeriod IS NOT NULL
	AND		DATEADD(hh, l.RentHourPeriod, l.Date) > '2010-10-26 18:40:00.0'
	AND		DATEADD(hh, l.RentHourPeriod, l.Date) < GETDATE()
	
	
-- INSERT �ϱ� ����, �Ʒ��� SELECT ������ �ѹ� Ȯ�� ��Ź�帳�ϴ�.
INSERT AccountItem(AID, ItemID, RentDate, RentHourPeriod)	
	SELECT	l.AID, r.ItemID, GETDATE(), 72
	FROM	(	SELECT	csi.CSSID, csi.CSID, cs.ItemID
				FROM	CashSetItem csi JOIN CashShop cs
				ON		cs.CSID = csi.CSID ) r, SetItemPurchaseLogByCash l
	WHERE	l.Date < '2010-10-28 00:00:00.0'
	AND		l.RentHourPeriod IS NOT NULL
	AND		DATEADD(hh, l.RentHourPeriod, l.Date) > '2010-10-26 18:40:00.0'
	AND		DATEADD(hh, l.RentHourPeriod, l.Date) < GETDATE()
	AND		r.CSSID = l.CSSID
	