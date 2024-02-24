USE GunzDB
GO

-----------------------------------------------------------------------------------------------------------
-- �۾��� ����

-- �ɸ��͵��� ����ϴ� ������ ������ �ڵ� ���̺� ���� ����
CREATE TABLE CharacterEquipmentSlotCode
(
	SlotID		INT,
	SlotType	VARCHAR(20)
	
	CONSTRAINT PK_CharacterEquipmentSlotCode PRIMARY KEY CLUSTERED (SlotID ASC)
)
GO

-- ������ ������ �ڵ� �Է�
INSERT CharacterEquipmentSlotCode VALUES(0, 'Head');
INSERT CharacterEquipmentSlotCode VALUES(1, 'Chest');
INSERT CharacterEquipmentSlotCode VALUES(2, 'Hands');
INSERT CharacterEquipmentSlotCode VALUES(3, 'Legs');
INSERT CharacterEquipmentSlotCode VALUES(4, 'Feet');
INSERT CharacterEquipmentSlotCode VALUES(5, 'FingerLeft');
INSERT CharacterEquipmentSlotCode VALUES(6, 'FingerRight');	
INSERT CharacterEquipmentSlotCode VALUES(7, 'Melee');
INSERT CharacterEquipmentSlotCode VALUES(8, 'Primary');
INSERT CharacterEquipmentSlotCode VALUES(9, 'Secondary');
INSERT CharacterEquipmentSlotCode VALUES(10, 'Custom1');
INSERT CharacterEquipmentSlotCode VALUES(11, 'Custom2');
INSERT CharacterEquipmentSlotCode VALUES(12, 'Avatar');
	
------------------------------------------------------------------------------------------------------------------------------------------------

-- Character ���̺� �����ϴ� �ɸ��͵��� ��� ������ ��� ����
-- ���� 1) �ð��� ���� �ɸ��� �����Դϴ�. ������, �Ҹ� ������ ��ġ ���ϳ� �����ؾ� �մϴ�.
--        �׷��� �ֽ��� ��� ���� ������ ���̺� ���Ե˴ϴ�.

-- ����, ������ �ɸ��͵��� ��� ������ ��� NULL�� ����
WITH T_CHAR AS
	(
		SELECT CID / CID AS HS, CID
		  FROM dbo.CHARACTER C WITH (TABLOCK)
		 WHERE DeleteFlag <> 0
		 GROUP BY CID
	)
	, T_EQ AS
	(
		SELECT CASE WHEN SlotID <> 1 THEN 1 ELSE 1 END AS HS, SlotID
		  FROM dbo.CharacterEquipmentSlotCode WITH (TABLOCK)
		 GROUP BY SlotID
	)
SELECT C.CID, E.SlotID, NULL AS CIID, NULL AS ItemID
  INTO CharacterEquipmentSlot
  FROM T_EQ E
  JOIN T_CHAR C
	ON E.HS = C.HS
OPTION (HASH JOIN);


-- �������� ���� �ɸ��͵��� ��� ������ ������ �������� �̿��Ͽ� �ϰ������� ����
SELECT	*
INTO	tmpCharacter
FROM	Character
WHERE	DeleteFlag = 0

INSERT	CharacterEquipmentSlot(CID, SlotID, CIID, ItemID)
	SELECT	CID, 0 AS SlotID, head_slot AS CIID, head_itemid AS ItemID
	FROM	tmpCharacter WITH (TABLOCK)

INSERT	CharacterEquipmentSlot(CID, SlotID, CIID, ItemID)
	SELECT	CID, 1 AS SlotID, chest_slot AS CIID, chest_itemid AS ItemID
	FROM	tmpCharacter WITH (TABLOCK)

INSERT	CharacterEquipmentSlot(CID, SlotID, CIID, ItemID)
	SELECT	CID, 2 AS SlotID, Hands_slot AS CIID, Hands_itemid AS ItemID
	FROM	tmpCharacter WITH (TABLOCK)
	
INSERT	CharacterEquipmentSlot(CID, SlotID, CIID, ItemID)
	SELECT	CID, 3 AS SlotID, Legs_slot AS CIID, Legs_itemid AS ItemID
	FROM	tmpCharacter WITH (TABLOCK)
	
INSERT	CharacterEquipmentSlot(CID, SlotID, CIID, ItemID)
	SELECT	CID, 4 AS SlotID, Feet_slot AS CIID, Feet_itemid AS ItemID
	FROM	tmpCharacter WITH (TABLOCK)
	
INSERT	CharacterEquipmentSlot(CID, SlotID, CIID, ItemID)
	SELECT	CID, 5 AS SlotID, fingerl_slot AS CIID, fingerl_itemid AS ItemID
	FROM	tmpCharacter WITH (TABLOCK)
		
INSERT	CharacterEquipmentSlot(CID, SlotID, CIID, ItemID)
	SELECT	CID, 6 AS SlotID, fingerr_slot AS CIID, fingerr_itemid AS ItemID
	FROM	tmpCharacter WITH (TABLOCK)

INSERT	CharacterEquipmentSlot(CID, SlotID, CIID, ItemID)
	SELECT	CID, 7 AS SlotID, melee_slot AS CIID, melee_itemid AS ItemID
	FROM	tmpCharacter WITH (TABLOCK)

INSERT	CharacterEquipmentSlot(CID, SlotID, CIID, ItemID)
	SELECT	CID, 8 AS SlotID, Primary_slot AS CIID, Primary_itemid AS ItemID
	FROM	tmpCharacter WITH (TABLOCK)
	
INSERT	CharacterEquipmentSlot(CID, SlotID, CIID, ItemID)
	SELECT	CID, 9 AS SlotID, Secondary_slot AS CIID, Secondary_itemid AS ItemID
	FROM	tmpCharacter WITH (TABLOCK)
	
INSERT	CharacterEquipmentSlot(CID, SlotID, CIID, ItemID)
	SELECT	CID, 10 AS SlotID, custom1_slot AS CIID, custom1_itemid AS ItemID
	FROM	tmpCharacter WITH (TABLOCK)

INSERT	CharacterEquipmentSlot(CID, SlotID, CIID, ItemID)
	SELECT	CID, 11 AS SlotID, custom2_slot AS CIID, custom2_itemid AS ItemID
	FROM	tmpCharacter WITH (TABLOCK)


-- Clustered Index �����	
ALTER TABLE dbo.CharacterEquipmentSlot WITH CHECK ADD CONSTRAINT PK_CharacterEquipmentSlot PRIMARY KEY CLUSTERED (CID ASC, SlotID ASC)
GO

-- SlotID Foreign Key ����
ALTER TABLE dbo.CharacterEquipmentSlot WITH CHECK ADD CONSTRAINT FK_CharacterEquipmentSlotCode_CharacterEquipmentSlot FOREIGN KEY(SlotID)
REFERENCES dbo.CharacterEquipmentSlotCode (SlotID)
GO


-- �ɸ��͸� �̸� �����ص״� ���̺� ����
DROP TABLE tmpCharacter

	
/*
	-- �Ʒ��� ���ʿ��� �����ʹ� ���Ŀ� �����ִ� ���� ��õ�մϴ�.
	
	ALTER TABLE Character DROP COLUMN head_slot;
	ALTER TABLE Character DROP COLUMN chest_slot;
	ALTER TABLE Character DROP COLUMN legs_slot;
	ALTER TABLE Character DROP COLUMN hands_slot;
	ALTER TABLE Character DROP COLUMN feet_slot;
	ALTER TABLE Character DROP COLUMN fingerl_slot;
	ALTER TABLE Character DROP COLUMN fingerr_slot;
	ALTER TABLE Character DROP COLUMN melee_slot;
	ALTER TABLE Character DROP COLUMN primary_slot;
	ALTER TABLE Character DROP COLUMN secondary_slot;
	ALTER TABLE Character DROP COLUMN custom1_slot;
	ALTER TABLE Character DROP COLUMN custom2_slot;
		
	ALTER TABLE Character DROP COLUMN head_ItemID;
	ALTER TABLE Character DROP COLUMN chest_ItemID;
	ALTER TABLE Character DROP COLUMN legs_ItemID;
	ALTER TABLE Character DROP COLUMN hands_ItemID;
	ALTER TABLE Character DROP COLUMN feet_ItemID;
	ALTER TABLE Character DROP COLUMN fingerl_ItemID;
	ALTER TABLE Character DROP COLUMN fingerr_ItemID;
	ALTER TABLE Character DROP COLUMN melee_ItemID;
	ALTER TABLE Character DROP COLUMN primary_ItemID;
	ALTER TABLE Character DROP COLUMN secondary_ItemID;
	ALTER TABLE Character DROP COLUMN custom1_ItemID;
	ALTER TABLE Character DROP COLUMN custom2_ItemID;
*/