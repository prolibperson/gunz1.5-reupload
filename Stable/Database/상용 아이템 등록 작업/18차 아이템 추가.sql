-- ������
UPDATE Item SET TotalPoint=0, BountyPrice=0, Damage=0, Delay=0, Controllability=0, Magazine=0, ReloadTime=0, SlugOutput=0, Gadget=0, SF=0, FR=0,CR=0,PR=0,LR=0, BlendColor=0, ModelName='', MaxBullet=0, LimitSpeed=100, IsCashItem=1,
ResSex=1, ResLevel=15,Slot=4,Weight=4, HP=2, AP=8, MAXWT=0, 
Description='������ ����Ʈ �δ��� �׷��̴���Ʈ�� ������ ���� ����'
WHERE ItemID=520016

UPDATE Item SET TotalPoint=0, BountyPrice=0, Damage=0, Delay=0, Controllability=0, Magazine=0, ReloadTime=0, SlugOutput=0, Gadget=0, SF=0, FR=0,CR=0,PR=0,LR=0, BlendColor=0, ModelName='', MaxBullet=0, LimitSpeed=100, IsCashItem=1,
ResSex=1, ResLevel=15,Slot=6,Weight=4, HP=2, AP=14, MAXWT=0, 
Description='������ ����Ʈ �δ��� �׷��̴���Ʈ�� ������ ���� �尩.'
WHERE ItemID=522011

UPDATE Item SET TotalPoint=0, BountyPrice=0, Damage=0, Delay=0, Controllability=0, Magazine=0, ReloadTime=0, SlugOutput=0, Gadget=0, SF=0, FR=0,CR=0,PR=0,LR=0, BlendColor=0, ModelName='', MaxBullet=0, LimitSpeed=100, IsCashItem=1,
ResSex=1, ResLevel=15,Slot=8,Weight=4, HP=2, AP=17, MAXWT=0, 
Description='������ ����Ʈ �δ��� �׷��̴���Ʈ�� ������ ���� ����.'
WHERE ItemID=524011

UPDATE Item SET TotalPoint=0, BountyPrice=0, Damage=0, Delay=0, Controllability=0, Magazine=0, ReloadTime=0, SlugOutput=0, Gadget=0, SF=0, FR=0,CR=0,PR=0,LR=0, BlendColor=0, ModelName='', MaxBullet=0, LimitSpeed=100, IsCashItem=1,
ResSex=1, ResLevel=15,Slot=5,Weight=15, HP=3, AP=24, MAXWT=0, 
Description='������ ����Ʈ �δ��� �׷��̴���Ʈ�� ������ ���� ��Ʈ.'
WHERE ItemID=521011

UPDATE Item SET TotalPoint=0, BountyPrice=0, Damage=0, Delay=0, Controllability=0, Magazine=0, ReloadTime=0, SlugOutput=0, Gadget=0, SF=0, FR=0,CR=0,PR=0,LR=0, BlendColor=0, ModelName='', MaxBullet=0, LimitSpeed=100, IsCashItem=1,
ResSex=1, ResLevel=15,Slot=7,Weight=14, HP=2, AP=26, MAXWT=0, 
Description='������ ����Ʈ �δ��� �׷��̴���Ʈ�� ������ ���� ����.'
WHERE ItemID=523011

-- ������
UPDATE Item SET TotalPoint=0, BountyPrice=0, Damage=0, Delay=0, Controllability=0, Magazine=0, ReloadTime=0, SlugOutput=0, Gadget=0, SF=0, FR=0,CR=0,PR=0,LR=0, BlendColor=0, ModelName='', MaxBullet=0, LimitSpeed=100, IsCashItem=1,
ResSex=2, ResLevel=15,Slot=4,Weight=4, HP=2, AP=8, MAXWT=0, 
Description='������ ����Ʈ �δ��� �׷��̴���Ʈ�� ������ ���� ����.'
WHERE ItemID=520516

UPDATE Item SET TotalPoint=0, BountyPrice=0, Damage=0, Delay=0, Controllability=0, Magazine=0, ReloadTime=0, SlugOutput=0, Gadget=0, SF=0, FR=0,CR=0,PR=0,LR=0, BlendColor=0, ModelName='', MaxBullet=0, LimitSpeed=100, IsCashItem=1,
ResSex=2, ResLevel=15,Slot=6,Weight=4, HP=2, AP=14, MAXWT=0, 
Description='������ ����Ʈ �δ��� �׷��̴���Ʈ�� ������ ���� �尩.'
WHERE ItemID=522511

UPDATE Item SET TotalPoint=0, BountyPrice=0, Damage=0, Delay=0, Controllability=0, Magazine=0, ReloadTime=0, SlugOutput=0, Gadget=0, SF=0, FR=0,CR=0,PR=0,LR=0, BlendColor=0, ModelName='', MaxBullet=0, LimitSpeed=100, IsCashItem=1,
ResSex=2, ResLevel=15,Slot=8,Weight=4, HP=2, AP=17, MAXWT=0, 
Description='������ ����Ʈ �δ��� �׷��̴���Ʈ�� ������ ���� ����.'
WHERE ItemID=524511

UPDATE Item SET TotalPoint=0, BountyPrice=0, Damage=0, Delay=0, Controllability=0, Magazine=0, ReloadTime=0, SlugOutput=0, Gadget=0, SF=0, FR=0,CR=0,PR=0,LR=0, BlendColor=0, ModelName='', MaxBullet=0, LimitSpeed=100, IsCashItem=1,
ResSex=2, ResLevel=15,Slot=5,Weight=15, HP=3, AP=24, MAXWT=0, 
Description='������ ����Ʈ �δ��� �׷��̴���Ʈ�� ������ ���� ��Ʈ.'
WHERE ItemID=521511

UPDATE Item SET TotalPoint=0, BountyPrice=0, Damage=0, Delay=0, Controllability=0, Magazine=0, ReloadTime=0, SlugOutput=0, Gadget=0, SF=0, FR=0,CR=0,PR=0,LR=0, BlendColor=0, ModelName='', MaxBullet=0, LimitSpeed=100, IsCashItem=1,
ResSex=2, ResLevel=15,Slot=7,Weight=14, HP=2, AP=26, MAXWT=0, 
Description='������ü�� ���õ� ��������� ������ ����. ������.'
WHERE ItemID=523511



-- �Ⱓ�������̹Ƿ�
-- ����
INSERT INTO CashShop (ItemID, NewItemOrder, CashPrice, RegDate, Opened, WebImgName, RentType)
VALUES (520016, 0, 500, GETDATE(), 0, '', 2)
-- �尩
INSERT INTO CashShop (ItemID, NewItemOrder, CashPrice, RegDate, Opened, WebImgName, RentType)
VALUES (522011, 0, 600, GETDATE(), 0, '', 2)
-- �Ź�
INSERT INTO CashShop (ItemID, NewItemOrder, CashPrice, RegDate, Opened, WebImgName, RentType)
VALUES (524011, 0, 700, GETDATE(), 0, '', 2)
-- ����
INSERT INTO CashShop (ItemID, NewItemOrder, CashPrice, RegDate, Opened, WebImgName, RentType)
VALUES (521011, 0, 1100, GETDATE(), 0, '', 2)
-- ����
INSERT INTO CashShop (ItemID, NewItemOrder, CashPrice, RegDate, Opened, WebImgName, RentType)
VALUES (523011, 0, 900, GETDATE(), 0, '', 2)

-- ����
INSERT INTO CashShop (ItemID, NewItemOrder, CashPrice, RegDate, Opened, WebImgName, RentType)
VALUES (520516, 0, 500, GETDATE(), 0, '', 2)
-- �尩
INSERT INTO CashShop (ItemID, NewItemOrder, CashPrice, RegDate, Opened, WebImgName, RentType)
VALUES (522511, 0, 600, GETDATE(), 0, '', 2)
-- �Ź�
INSERT INTO CashShop (ItemID, NewItemOrder, CashPrice, RegDate, Opened, WebImgName, RentType)
VALUES (524511, 0, 700, GETDATE(), 0, '', 2)
-- ����
INSERT INTO CashShop (ItemID, NewItemOrder, CashPrice, RegDate, Opened, WebImgName, RentType)
VALUES (521511, 0, 1100, GETDATE(), 0, '', 2)
-- ����
INSERT INTO CashShop (ItemID, NewItemOrder, CashPrice, RegDate, Opened, WebImgName, RentType)
VALUES (523511, 0, 900, GETDATE(), 0, '', 2)


--



INSERT INTO CashSetShop (Name, Description, CashPrice, NewItemOrder, RegDate, ResSex, ResLevel, Weight, Opened, WebImgName, RentType)
VALUES ('���� �׷��̴���Ʈ ��Ʈ', '���������̿����� �� ���� �׷��̴���Ʈ �δ��� ������ �����ǻ��̴�.', 3800, 0, GETDATE(), 1, 15, 41, 0, '', 2)

INSERT INTO CashSetShop (Name, Description, CashPrice, NewItemOrder, RegDate, ResSex, ResLevel, Weight, Opened, WebImgName, RentType)
VALUES ('���� �׷��̴���Ʈ ��Ʈ', '���������̿����� �� ���� �׷��̴���Ʈ �δ��� ������ �����ǻ��̴�.', 3800, 0, GETDATE(), 2, 15, 41, 0, '', 2)


-- ������Ʈ
--INSERT INTO CashSetItem (CSSID, CSID) VALUES (, )
-- ������Ʈ
--INSERT INTO CashSetItem (CSSID, CSID) VALUES (, )


-- ���ݸ��
---
DECLARE @ret int
DECLARE @csid_male int
DECLARE @csid_female int

DECLARE @hourperiod1 int
DECLARE @hourperiod2 int
DECLARE @hourperiod3 int
DECLARE @hourperiod4 int

DECLARE @price1 int
DECLARE @price2 int
DECLARE @price3 int
DECLARE @price4 int

SELECT @csid_male=380, @csid_female=385
SELECT @hourperiod1 = 168, @price1 = 700
SELECT @hourperiod2 = 360, @price2 = 900
SELECT @hourperiod3 = 720, @price3 = 1300
SELECT @hourperiod4 = NULL, @price4 = 1800


-- ����
EXEC spInsertRentCashShopPrice @csid_male, @hourperiod1, @price1
EXEC spInsertRentCashShopPrice @csid_male, @hourperiod2, @price2
EXEC spInsertRentCashShopPrice @csid_male, @hourperiod3, @price3
EXEC spInsertRentCashShopPrice @csid_male, @hourperiod4, @price4

-- ����
EXEC spInsertRentCashShopPrice @csid_female, @hourperiod1, @price1
EXEC spInsertRentCashShopPrice @csid_female, @hourperiod2, @price2
EXEC spInsertRentCashShopPrice @csid_female, @hourperiod3, @price3
EXEC spInsertRentCashShopPrice @csid_female, @hourperiod4, @price4





-- ��Ʈ ���ݸ��
DECLARE @ret int
DECLARE @cssid_male int
DECLARE @cssid_female int

DECLARE @hourperiod1 int
DECLARE @hourperiod2 int
DECLARE @hourperiod3 int
DECLARE @hourperiod4 int

DECLARE @price1 int
DECLARE @price2 int
DECLARE @price3 int
DECLARE @price4 int

SELECT @cssid_male=72, @cssid_female=73
SELECT @hourperiod1 = 168, @price1 = 2800
SELECT @hourperiod2 = 360, @price2 = 3500
SELECT @hourperiod3 = 720, @price3 = 4800
SELECT @hourperiod4 = NULL, @price4 = 6300

-- ����
EXEC spInsertRentCashSetShopPrice @cssid_male, @hourperiod1, @price1
EXEC spInsertRentCashSetShopPrice @cssid_male, @hourperiod2, @price2
EXEC spInsertRentCashSetShopPrice @cssid_male, @hourperiod3, @price3
EXEC spInsertRentCashSetShopPrice @cssid_male, @hourperiod4, @price4

-- ����
EXEC spInsertRentCashSetShopPrice @cssid_female, @hourperiod1, @price1
EXEC spInsertRentCashSetShopPrice @cssid_female, @hourperiod2, @price2
EXEC spInsertRentCashSetShopPrice @cssid_female, @hourperiod3, @price3
EXEC spInsertRentCashSetShopPrice @cssid_female, @hourperiod4, @price4
