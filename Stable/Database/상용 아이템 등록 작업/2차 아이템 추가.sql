UPDATE Item SET TotalPoint=0, BountyPrice=0, Damage=0, Delay=0, Controllability=0, Magazine=0, ReloadTime=0, SlugOutput=0, Gadget=0, SF=0, FR=0,CR=0,PR=0,LR=0, BlendColor=0, ModelName='', MaxBullet=0, LimitSpeed=0, IsCashItem=1,
ResSex=1, ResLevel=15,Slot=4,Weight=4, HP=3, AP=6, MAXWT=0, 
Description='��ȭ���� �缳 ���� �ų�������� ������� ������. £�� ��Ʈ���� �������̴� ����'
WHERE ItemID=520003

UPDATE Item SET TotalPoint=0, BountyPrice=0, Damage=0, Delay=0, Controllability=0, Magazine=0, ReloadTime=0, SlugOutput=0, Gadget=0, SF=0, FR=0,CR=0,PR=0,LR=0, BlendColor=0, ModelName='', MaxBullet=0, LimitSpeed=0, IsCashItem=1,
ResSex=1, ResLevel=15,Slot=6,Weight=4, HP=3, AP=12, MAXWT=0, 
Description='��ȭ���� �缳 ���� �ų�������� ������� �尩'
WHERE ItemID=522002

UPDATE Item SET TotalPoint=0, BountyPrice=0, Damage=0, Delay=0, Controllability=0, Magazine=0, ReloadTime=0, SlugOutput=0, Gadget=0, SF=0, FR=0,CR=0,PR=0,LR=0, BlendColor=0, ModelName='', MaxBullet=0, LimitSpeed=0, IsCashItem=1,
ResSex=1, ResLevel=15,Slot=8,Weight=4, HP=3, AP=15, MAXWT=0, 
Description='��ȭ���� �缳 ���� �ų�������� ������� ���� ����'
WHERE ItemID=524002

UPDATE Item SET TotalPoint=0, BountyPrice=0, Damage=0, Delay=0, Controllability=0, Magazine=0, ReloadTime=0, SlugOutput=0, Gadget=0, SF=0, FR=0,CR=0,PR=0,LR=0, BlendColor=0, ModelName='', MaxBullet=0, LimitSpeed=0, IsCashItem=1,
ResSex=1, ResLevel=15,Slot=5,Weight=15, HP=4, AP=22, MAXWT=0, 
Description='��ȭ���� �缳 ���� �ų�������� ������� ���� ����Ʈ�� ����.'
WHERE ItemID=521002

UPDATE Item SET TotalPoint=0, BountyPrice=0, Damage=0, Delay=0, Controllability=0, Magazine=0, ReloadTime=0, SlugOutput=0, Gadget=0, SF=0, FR=0,CR=0,PR=0,LR=0, BlendColor=0, ModelName='', MaxBullet=0, LimitSpeed=0, IsCashItem=1,
ResSex=1, ResLevel=15,Slot=7,Weight=14, HP=3, AP=24, MAXWT=0, 
Description='��ȭ���� �缳 ���� �ų�������� ������� ����.'
WHERE ItemID=523002

UPDATE Item SET TotalPoint=0, BountyPrice=0, Damage=0, Delay=0, Controllability=0, Magazine=0, ReloadTime=0, SlugOutput=0, Gadget=0, SF=0, FR=0,CR=0,PR=0,LR=0, BlendColor=0, ModelName='', MaxBullet=0, LimitSpeed=0, IsCashItem=1,
ResSex=2, ResLevel=15,Slot=4,Weight=4, HP=3, AP=6, MAXWT=0, 
Description='��ȭ���� �缳 ���� �ų�������� ������� ����'
WHERE ItemID=520503

UPDATE Item SET TotalPoint=0, BountyPrice=0, Damage=0, Delay=0, Controllability=0, Magazine=0, ReloadTime=0, SlugOutput=0, Gadget=0, SF=0, FR=0,CR=0,PR=0,LR=0, BlendColor=0, ModelName='', MaxBullet=0, LimitSpeed=0, IsCashItem=1,
ResSex=2, ResLevel=15,Slot=6,Weight=4, HP=3, AP=12, MAXWT=0, 
Description='��ȭ���� �缳 ���� �ų�������� ������� ���尩. �ε巯�� �䳢�з� �������Ǿ� �ִ�.'
WHERE ItemID=522502

UPDATE Item SET TotalPoint=0, BountyPrice=0, Damage=0, Delay=0, Controllability=0, Magazine=0, ReloadTime=0, SlugOutput=0, Gadget=0, SF=0, FR=0,CR=0,PR=0,LR=0, BlendColor=0, ModelName='', MaxBullet=0, LimitSpeed=0, IsCashItem=1,
ResSex=2, ResLevel=15,Slot=8,Weight=4, HP=3, AP=15, MAXWT=0, 
Description='��ȭ���� �缳 ���� �ų�������� ������� �Ź�. ��ȭ�������� ưư�ϰ� ���������.'
WHERE ItemID=524502

UPDATE Item SET TotalPoint=0, BountyPrice=0, Damage=0, Delay=0, Controllability=0, Magazine=0, ReloadTime=0, SlugOutput=0, Gadget=0, SF=0, FR=0,CR=0,PR=0,LR=0, BlendColor=0, ModelName='', MaxBullet=0, LimitSpeed=0, IsCashItem=1,
ResSex=2, ResLevel=15,Slot=5,Weight=15, HP=4, AP=22, MAXWT=0, 
Description='��ȭ���� �缳 ���� �ų�������� ������� ������ ��������Ʈ �� ����.'
WHERE ItemID=521502

UPDATE Item SET TotalPoint=0, BountyPrice=0, Damage=0, Delay=0, Controllability=0, Magazine=0, ReloadTime=0, SlugOutput=0, Gadget=0, SF=0, FR=0,CR=0,PR=0,LR=0, BlendColor=0, ModelName='', MaxBullet=0, LimitSpeed=0, IsCashItem=1,
ResSex=2, ResLevel=15,Slot=7,Weight=14, HP=3, AP=24, MAXWT=0, 
Description='��ȭ���� �缳 ���� �ų�������� ������� ������ ����.'
WHERE ItemID=523502


-- ���� �ų������ ������
INSERT INTO CashShop (ItemID, NewItemOrder, CashPrice, RegDate, Opened, WebImgName) 
VALUES (520003, 0, 1100, GETDATE(), 0, '')

-- ���� �ų������ �尩
INSERT INTO CashShop (ItemID, NewItemOrder, CashPrice, RegDate, Opened, WebImgName) 
VALUES (522002, 0, 1200, GETDATE(), 0, '')

-- ���� �ų������ ���� ����
INSERT INTO CashShop (ItemID, NewItemOrder, CashPrice, RegDate, Opened, WebImgName) 
VALUES (524002, 0, 1400, GETDATE(), 0, '')

-- ���� �ų������ ���� ����Ʈ
INSERT INTO CashShop (ItemID, NewItemOrder, CashPrice, RegDate, Opened, WebImgName) 
VALUES (521002, 0, 2300, GETDATE(), 0, '')

-- ���� �ų������ �������
INSERT INTO CashShop (ItemID, NewItemOrder, CashPrice, RegDate, Opened, WebImgName) 
VALUES (523002, 0, 2000, GETDATE(), 0, '')

-- 
INSERT INTO CashShop (ItemID, NewItemOrder, CashPrice, RegDate, Opened, WebImgName) 
VALUES (520503, 0, 1100, GETDATE(), 0, '')

-- 
INSERT INTO CashShop (ItemID, NewItemOrder, CashPrice, RegDate, Opened, WebImgName) 
VALUES (522502, 0, 1200, GETDATE(), 0, '')

-- 
INSERT INTO CashShop (ItemID, NewItemOrder, CashPrice, RegDate, Opened, WebImgName) 
VALUES (524502, 0, 1400, GETDATE(), 0, '')

-- 
INSERT INTO CashShop (ItemID, NewItemOrder, CashPrice, RegDate, Opened, WebImgName) 
VALUES (521502, 0, 2300, GETDATE(), 0, '')

-- 
INSERT INTO CashShop (ItemID, NewItemOrder, CashPrice, RegDate, Opened, WebImgName) 
VALUES (523502, 0, 2000, GETDATE(), 0, '')



INSERT INTO CashSetShop (Name, Description, CashPrice, NewItemOrder, RegDate, ResSex, ResLevel, Weight, Opened, WebImgName)
VALUES ('���� �ų������ ��Ʈ', '��ȭ���� �缳 ���� �ų�������� ������ Ư�� ��Ʈ�ǻ��̴�.', 7200, 0, GETDATE(), 1, 15, 41, 1,
'')

INSERT INTO CashSetShop (Name, Description, CashPrice, NewItemOrder, RegDate, ResSex, ResLevel, Weight, Opened, WebImgName)
VALUES ('���� �ų������ ��Ʈ', '��ȭ���� �缳 ���� �ų�������� ������ ��Ʈ�ǻ��̴�.', 7200, 0, GETDATE(), 2, 15, 41, 1,
'')

