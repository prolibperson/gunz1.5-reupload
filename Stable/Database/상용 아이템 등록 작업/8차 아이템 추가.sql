-- ������
UPDATE Item SET TotalPoint=0, BountyPrice=0, Damage=0, Delay=0, Controllability=0, Magazine=0, ReloadTime=0, SlugOutput=0, Gadget=0, SF=0, FR=0,CR=0,PR=0,LR=0, BlendColor=0, ModelName='', MaxBullet=0, LimitSpeed=100, IsCashItem=1,
ResSex=1, ResLevel=7,Slot=4,Weight=4, HP=1, AP=5, MAXWT=0,
Description='������ ��ĩ�Ÿ��� �Ҹ���� ����, ����ֽ��� ������ ����'
WHERE ItemID=520010

UPDATE Item SET TotalPoint=0, BountyPrice=0, Damage=0, Delay=0, Controllability=0, Magazine=0, ReloadTime=0, SlugOutput=0, Gadget=0, SF=0, FR=0,CR=0,PR=0,LR=0, BlendColor=0, ModelName='', MaxBullet=0, LimitSpeed=100, IsCashItem=1,
ResSex=1, ResLevel=7,Slot=6,Weight=3, HP=1, AP=10, MAXWT=0,
Description='������ ��ĩ�Ÿ��� �Ҹ���� ����, ����ֽ��� ������ �尩'
WHERE ItemID=522005


UPDATE Item SET TotalPoint=0, BountyPrice=0, Damage=0, Delay=0, Controllability=0, Magazine=0, ReloadTime=0, SlugOutput=0, Gadget=0, SF=0, FR=0,CR=0,PR=0,LR=0, BlendColor=0, ModelName='', MaxBullet=0, LimitSpeed=100, IsCashItem=1,
ResSex=1, ResLevel=7,Slot=8,Weight=3, HP=1, AP=12, MAXWT=0,
Description='������ ��ĩ�Ÿ��� �Ҹ���� ����, ����ֽ��� ������ �Ź�'
WHERE ItemID=524005


UPDATE Item SET TotalPoint=0, BountyPrice=0, Damage=0, Delay=0, Controllability=0, Magazine=0, ReloadTime=0, SlugOutput=0, Gadget=0, SF=0, FR=0,CR=0,PR=0,LR=0, BlendColor=0, ModelName='', MaxBullet=0, LimitSpeed=100, IsCashItem=1,
ResSex=1, ResLevel=7,Slot=5,Weight=14, HP=3, AP=18, MAXWT=0,
Description='������ ��ĩ�Ÿ��� �Ҹ���� ����, ����ֽ��� ������ ����'
WHERE ItemID=521005


UPDATE Item SET TotalPoint=0, BountyPrice=0, Damage=0, Delay=0, Controllability=0, Magazine=0, ReloadTime=0, SlugOutput=0, Gadget=0, SF=0, FR=0,CR=0,PR=0,LR=0, BlendColor=0, ModelName='', MaxBullet=0, LimitSpeed=100, IsCashItem=1,
ResSex=1, ResLevel=7,Slot=7,Weight=13, HP=3, AP=17, MAXWT=0,
Description='������ ��ĩ�Ÿ��� �Ҹ���� ����, ����ֽ��� ������ ����'
WHERE ItemID=523005


-- ������
UPDATE Item SET TotalPoint=0, BountyPrice=0, Damage=0, Delay=0, Controllability=0, Magazine=0, ReloadTime=0, SlugOutput=0, Gadget=0, SF=0, FR=0,CR=0,PR=0,LR=0, BlendColor=0, ModelName='', MaxBullet=0, LimitSpeed=100, IsCashItem=1,
ResSex=2, ResLevel=7,Slot=4,Weight=4, HP=1, AP=5, MAXWT=0,
Description='������ ��ĩ�Ÿ��� �Ҹ���� ����, ����ֽ��� ������ ����'
WHERE ItemID=520510


UPDATE Item SET TotalPoint=0, BountyPrice=0, Damage=0, Delay=0, Controllability=0, Magazine=0, ReloadTime=0, SlugOutput=0, Gadget=0, SF=0, FR=0,CR=0,PR=0,LR=0, BlendColor=0, ModelName='', MaxBullet=0, LimitSpeed=100, IsCashItem=1,
ResSex=2, ResLevel=7,Slot=6,Weight=3, HP=1, AP=10, MAXWT=0,
Description='������ ��ĩ�Ÿ��� �Ҹ���� ����, ����ֽ��� ������ �尩'
WHERE ItemID=522505


UPDATE Item SET TotalPoint=0, BountyPrice=0, Damage=0, Delay=0, Controllability=0, Magazine=0, ReloadTime=0, SlugOutput=0, Gadget=0, SF=0, FR=0,CR=0,PR=0,LR=0, BlendColor=0, ModelName='', MaxBullet=0, LimitSpeed=100, IsCashItem=1,
ResSex=2, ResLevel=7,Slot=8,Weight=3, HP=1, AP=12, MAXWT=0,
Description='������ ��ĩ�Ÿ��� �Ҹ���� ����, ����ֽ��� ������ �Ź�'
WHERE ItemID=524505


UPDATE Item SET TotalPoint=0, BountyPrice=0, Damage=0, Delay=0, Controllability=0, Magazine=0, ReloadTime=0, SlugOutput=0, Gadget=0, SF=0, FR=0,CR=0,PR=0,LR=0, BlendColor=0, ModelName='', MaxBullet=0, LimitSpeed=100, IsCashItem=1,
ResSex=2, ResLevel=7,Slot=5,Weight=14, HP=3, AP=18, MAXWT=0,
Description='������ ��ĩ�Ÿ��� �Ҹ���� ����, ����ֽ��� ������ ����'
WHERE ItemID=521505


UPDATE Item SET TotalPoint=0, BountyPrice=0, Damage=0, Delay=0, Controllability=0, Magazine=0, ReloadTime=0, SlugOutput=0, Gadget=0, SF=0, FR=0,CR=0,PR=0,LR=0, BlendColor=0, ModelName='', MaxBullet=0, LimitSpeed=100, IsCashItem=1,
ResSex=2, ResLevel=7,Slot=7,Weight=13, HP=3, AP=17, MAXWT=0,
Description='������ ��ĩ�Ÿ��� �Ҹ���� ����, ����ֽ��� ������ ����'
WHERE ItemID=523505




--
INSERT INTO CashShop (ItemID, NewItemOrder, CashPrice, RegDate, Opened, WebImgName)
VALUES (520010, 0, 1000, GETDATE(), 0, '')
--
INSERT INTO CashShop (ItemID, NewItemOrder, CashPrice, RegDate, Opened, WebImgName)
VALUES (522005, 0, 1000, GETDATE(), 0, '')
--
INSERT INTO CashShop (ItemID, NewItemOrder, CashPrice, RegDate, Opened, WebImgName)
VALUES (524005, 0, 1200, GETDATE(), 0, '')
--
INSERT INTO CashShop (ItemID, NewItemOrder, CashPrice, RegDate, Opened, WebImgName)
VALUES (521005, 0, 2000, GETDATE(), 0, '')
--
INSERT INTO CashShop (ItemID, NewItemOrder, CashPrice, RegDate, Opened, WebImgName)
VALUES (523005, 0, 1800, GETDATE(), 0, '')

--
INSERT INTO CashShop (ItemID, NewItemOrder, CashPrice, RegDate, Opened, WebImgName)
VALUES (520510, 0, 1000, GETDATE(), 0, '')
--
INSERT INTO CashShop (ItemID, NewItemOrder, CashPrice, RegDate, Opened, WebImgName)
VALUES (522505, 0, 1000, GETDATE(), 0, '')
--
INSERT INTO CashShop (ItemID, NewItemOrder, CashPrice, RegDate, Opened, WebImgName)
VALUES (524505, 0, 1200, GETDATE(), 0, '')
--
INSERT INTO CashShop (ItemID, NewItemOrder, CashPrice, RegDate, Opened, WebImgName)
VALUES (521505, 0, 2000, GETDATE(), 0, '')
--
INSERT INTO CashShop (ItemID, NewItemOrder, CashPrice, RegDate, Opened, WebImgName)
VALUES (523505, 0, 1800, GETDATE(), 0, '')


--



INSERT INTO CashSetShop (Name, Description, CashPrice, NewItemOrder, RegDate, ResSex, ResLevel, Weight, Opened, WebImgName)
VALUES ('���� ����ֽ� ��Ʈ', '������ ��ĩ�Ÿ��� �Ҹ���� ����, ����ֽ��� ���� ���� ��Ʈ.', 6300, 0, GETDATE(), 1, 7, 37, 0, '')

INSERT INTO CashSetShop (Name, Description, CashPrice, NewItemOrder, RegDate, ResSex, ResLevel, Weight, Opened, WebImgName)
VALUES ('���� ����ֽ� ��Ʈ', '������ ��ĩ�Ÿ��� �Ҹ���� ����, ����ֽ��� ���� ���� ��Ʈ.', 6300, 0, GETDATE(), 2, 7, 37, 0, '')

--INSERT INTO CashSetItem (CSSID, CSID) VALUES (, )
