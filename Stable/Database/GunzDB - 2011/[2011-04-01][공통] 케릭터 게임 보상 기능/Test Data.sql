--------------------------------------------------------------------------------------------------------------------------------------------

EXEC spInsertBattleTimeRewardDescription '������ �� �������� - �ڵ� ����', '2011-04-26 00:00:00.0', '2011-04-29 00:00:00.0', 5, 20, 0, '1111111', '���� ������ ���� 3�ÿ� ���µ˴ϴ�.', 1;
EXEC spInsertBattleTimeRewardDescription '�׳� �ڵ� ����(�׽�Ʈ - Type 1)', '2011-04-26 00:00:00.0', '2011-04-29 00:00:00.0', 1, 0, 0, '0000000', '���Ѵ�� �׳� �޴� �̺�Ʈ�Դϴ�.', 1;
EXEC spInsertBattleTimeRewardDescription '�׳� �ڵ� ����(�׽�Ʈ - Type 2)', '2011-04-26 00:00:00.0', '9999-12-31 00:00:00.0', 5, 0, 0, '1111111', '���� ���Ѵ�� �׳� �޴� �̺�Ʈ�Դϴ�.', 1;


--------------------------------------------------------------------------------------------------------------------------------------------

INSERT dbo.BattleTimeRewardItemList(BRID, ItemIDMale, ItemIDFemale, RentHourPeriod, RatePerThousand) VALUES (1, 1001005, 1001005, 0, 1000)

INSERT dbo.BattleTimeRewardItemList(BRID, ItemIDMale, ItemIDFemale, RentHourPeriod, RatePerThousand) VALUES (2, 1001001, 1001001, 0, 400)
INSERT dbo.BattleTimeRewardItemList(BRID, ItemIDMale, ItemIDFemale, RentHourPeriod, RatePerThousand) VALUES (2, 1, 1, 0, 200)
INSERT dbo.BattleTimeRewardItemList(BRID, ItemIDMale, ItemIDFemale, RentHourPeriod, ItemCnt, RatePerThousand) VALUES (2, 40103, 40103, 0, 100, 400)

INSERT dbo.BattleTimeRewardItemList(BRID, ItemIDMale, ItemIDFemale, RentHourPeriod, RatePerThousand) VALUES (3, 1001002, 1001002, 0, 1000)


/*
UPDATE dbo.BattletimeRewardItem SET RatePerThousand = 200 WHERE BRIID = 1;
UPDATE dbo.BattletimeRewardItem SET RatePerThousand = 200 WHERE BRIID = 2;
UPDATE dbo.BattletimeRewardItem SET RatePerThousand = 200 WHERE BRIID = 3;
UPDATE dbo.BattletimeRewardItem SET RatePerThousand = 200 WHERE BRIID = 4;
UPDATE dbo.BattletimeRewardItem SET RatePerThousand = 200 WHERE BRIID = 5;

UPDATE dbo.BattletimeRewardItem SET RatePerThousand = 50 WHERE BRIID = 1;
UPDATE dbo.BattletimeRewardItem SET RatePerThousand = 200 WHERE BRIID = 2;
UPDATE dbo.BattletimeRewardItem SET RatePerThousand = 300 WHERE BRIID = 3;
UPDATE dbo.BattletimeRewardItem SET RatePerThousand = 400 WHERE BRIID = 4;
UPDATE dbo.BattletimeRewardItem SET RatePerThousand = 50 WHERE BRIID = 5;
*/

/*
SELECT o.*, m.*
  FROM sys.objects o
  JOIN sys.sql_modules m
    ON o.object_id = m.object_id
 WHERE o.type = 'P';
*/