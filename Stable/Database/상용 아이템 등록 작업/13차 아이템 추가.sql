UPDATE Item SET HP=0, AP=0, MAXWT=0, TotalPoint=0, BountyPrice=0, SlugOutput=0, Gadget=0, SF=0, FR=0,CR=0,PR=0,LR=0, BlendColor=0, ModelName='', LimitSpeed=0, IsCashItem=1,
ResSex=3, Slot=2, 
ResLevel=7, Weight=12, Damage=20, Delay=220, Controllability=36, Magazine=12, MaxBullet=72, ReloadTime=4, 
Description='��ȭ���� ������� ����ϴ� ����. �ڽŵ��� �ٰ����� �̸��� �ٿ���.'
WHERE ItemID=504003

UPDATE Item SET HP=0, AP=0, MAXWT=0, TotalPoint=0, BountyPrice=0, SlugOutput=0, Gadget=0, SF=0, FR=0,CR=0,PR=0,LR=0, BlendColor=0, ModelName='', LimitSpeed=0, IsCashItem=1,
ResSex=3, Slot=2, 
ResLevel=15, Weight=14, Damage=24, Delay=200, Controllability=36, Magazine=13, MaxBullet=78, ReloadTime=4, 
Description='�����ڵ��� ���� �Ϲٴϸ� �ָ���� ���̾�ũ�ο쿡�� ����ϴ� ����'
WHERE ItemID=504004

UPDATE Item SET HP=0, AP=0, MAXWT=0, TotalPoint=0, BountyPrice=0, SlugOutput=1, Gadget=0, SF=0, FR=0,CR=0,PR=0,LR=0, BlendColor=0, ModelName='', LimitSpeed=0, IsCashItem=1,
ResSex=3, Slot=2, 
ResLevel=7, Weight=12, Damage=38, Delay=360, Controllability=36, Magazine=6, MaxBullet=48, ReloadTime=4, 
Description='��ȭ���� ������� ����ϴ� ������. �ڽŵ��� �ٰ����� �̸��� �ٿ���.'
WHERE ItemID=504501

UPDATE Item SET HP=0, AP=0, MAXWT=0, TotalPoint=0, BountyPrice=0, SlugOutput=1, Gadget=0, SF=0, FR=0,CR=0,PR=0,LR=0, BlendColor=0, ModelName='', LimitSpeed=0, IsCashItem=1,
ResSex=3, Slot=2, 
ResLevel=15, Weight=14, Damage=42, Delay=360, Controllability=36, Magazine=8, MaxBullet=64, ReloadTime=4, 
Description='�����ڵ��� ���� �Ϲٴϸ� �ָ���� ���̾�ũ�ο쿡�� ����ϴ� ������'
WHERE ItemID=504502

UPDATE Item SET HP=0, AP=0, MAXWT=0, TotalPoint=0, BountyPrice=0, SlugOutput=0, Gadget=0, SF=0, FR=0,CR=0,PR=0,LR=0, BlendColor=0, ModelName='', LimitSpeed=0, IsCashItem=1,
ResSex=3, Slot=2, 
ResLevel=7, Weight=28, Damage=35, Delay=1000, Controllability=50, Magazine=4, MaxBullet=16, ReloadTime=3, 
Description='��ȭ���� ������� ����ϴ� ����. �ڽŵ��� �ٰ����� �̸��� �ٿ���.'
WHERE ItemID=509001

UPDATE Item SET HP=0, AP=0, MAXWT=0, TotalPoint=0, BountyPrice=0, SlugOutput=0, Gadget=0, SF=0, FR=0,CR=0,PR=0,LR=0, BlendColor=0, ModelName='', LimitSpeed=0, IsCashItem=1,
ResSex=3, Slot=2, 
ResLevel=15, Weight=26, Damage=55, Delay=1400, Controllability=50, Magazine=4, MaxBullet=16, ReloadTime=3, 
Description='�����ڵ��� ���� �Ϲٴϸ� �ָ���� ���̾�ũ�ο쿡�� ����ϴ� ����'
WHERE ItemID=509002

UPDATE Item SET HP=0, AP=0, MAXWT=0, TotalPoint=0, BountyPrice=0, SlugOutput=1, Gadget=0, SF=0, FR=0,CR=0,PR=0,LR=0, BlendColor=0, ModelName='', LimitSpeed=0, IsCashItem=1,
ResSex=3, Slot=2, 
ResLevel=15, Weight=26, Damage=15, Delay=100, Controllability=70, Magazine=120, MaxBullet=240, ReloadTime=10, 
Description='�����ڵ��� ���� �Ϲٴϸ� �ָ���� ���̾�ũ�ο쿡�� ����ϴ� �ӽŰ�'
WHERE ItemID=508001







-- 
INSERT INTO CashShop (ItemID, NewItemOrder, CashPrice, RegDate, Opened, WebImgName) 
VALUES (504003, 0, 2500, GETDATE(), 0, '')
-- 
INSERT INTO CashShop (ItemID, NewItemOrder, CashPrice, RegDate, Opened, WebImgName) 
VALUES (504004, 0, 3500, GETDATE(), 0, '')
-- 
INSERT INTO CashShop (ItemID, NewItemOrder, CashPrice, RegDate, Opened, WebImgName) 
VALUES (504501, 0, 2500, GETDATE(), 0, '')
-- 
INSERT INTO CashShop (ItemID, NewItemOrder, CashPrice, RegDate, Opened, WebImgName) 
VALUES (504502, 0, 3500, GETDATE(), 0, '')
-- 
INSERT INTO CashShop (ItemID, NewItemOrder, CashPrice, RegDate, Opened, WebImgName) 
VALUES (509001, 0, 2500, GETDATE(), 0, '')
-- 
INSERT INTO CashShop (ItemID, NewItemOrder, CashPrice, RegDate, Opened, WebImgName) 
VALUES (509002, 0, 3500, GETDATE(), 0, '')
-- 
INSERT INTO CashShop (ItemID, NewItemOrder, CashPrice, RegDate, Opened, WebImgName) 
VALUES (508001, 0, 3500, GETDATE(), 0, '')


