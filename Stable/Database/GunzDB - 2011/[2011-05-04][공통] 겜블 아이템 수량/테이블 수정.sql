USE IGunzDB
GO

------------------------------------------------------------------------------------------

ALTER TABLE dbo.GambleRewardItem ADD ItemCnt INT DEFAULT(0);
ALTER TABLE dbo.GambleRewardItem ADD CONSTRAINT CK_GambleRewardItem_ItemCnt CHECK (ItemCnt > 0)

UPDATE  dbo.GambleRewardItem
SET     ItemCnt = 1;


------------------------------------------------------------------------------------------

USE LogDB
GO

ALTER TABLE dbo.GambleLog ADD RentHourPeriod INT;
ALTER TABLE dbo.GambleLog ADD ItemCnt INT;


------------------------------------------------------------------------------------------


SELECT  *
FROM    GambleRewardItem
WHERE   GIID = 1001001

INSERT dbo.GambleItem(GIID, Name, Price, RegDate, StartDate, LifeTimeHour, Opened, IsCash, Description)
VALUES (2000001, '�׽�Ʈ �̱� ������ 1', 100, '2011-05-04 00:00:00.0', '2011-05-04 00:00:00.0', 0, 1, 0, '�׽�Ʈ �̱� �������Դϴ�.');

INSERT  dbo.GambleItem(GIID, Name, Price, RegDate, StartDate, LifeTimeHour, Opened, IsCash, Description)
VALUES (2000002, '�׽�Ʈ �̱� ������ 2', 100, '2011-05-04 00:00:00.0', '2011-05-04 00:00:00.0', 0, 1, 0, '�׽�Ʈ �̱� �������Դϴ�.');

INSERT dbo.GambleRewardItem(GIID, ItemIDMale, ItemIDFemale, RentHourPeriod, RatePerThousand, ItemCnt)
VALUES (2000001, 13, 13, 0, 1000, 10);

INSERT dbo.GambleRewardItem(GIID, ItemIDMale, ItemIDFemale, RentHourPeriod, RatePerThousand, ItemCnt)
VALUES (2000002, 40001, 40001, 0, 1000, 1);

INSERT Item(ItemID, Name, ResSex, ResLevel, Slot, IsCashItem)
VALUES (2000001, '�׽�Ʈ �̱� ������ 1', 3, 0, 3, 0);

INSERT Item(ItemID, Name, ResSex, ResLevel, Slot, IsCashItem)
VALUES (2000002, '�׽�Ʈ �̱� ������ 2', 3, 0, 3, 0);

/*
DELETE AccountItem WHERE ItemID = 2000001 OR ItemID = 2000002
DELETE CharacterItem WHERE ItemID = 2000001 OR ItemID = 2000002
DELETE Item WHERE ItemID = 2000001 OR ItemID = 2000002
DELETE GambleRewardItem WHERE GIID = 2000001 OR GIID = 2000002
*/

UPDATE  CI
SET     Cnt = 100
FROM    CharacterItem CI
WHERE   CI.ItemID = 2000001 OR CI.ItemID = 2000002