UPDATE Item SET HP=0, AP=0, MAXWT=0, TotalPoint=0, BountyPrice=0, SlugOutput=1, Gadget=0, SF=0, FR=0,CR=0,PR=0,LR=0, BlendColor=0, ModelName='', LimitSpeed=0, IsCashItem=1,
ResSex=3, Slot=2, 
ResLevel=0, Weight=28, Damage=14, Delay=85, Controllability=90, Magazine=40, MaxBullet=200, ReloadTime=5, 
Description='�ʺ� ���谡���� �ַ� ����ϴ� SMG. ���ε��� ���ʵ��� źâ�� �ҹ������Ͽ� �Ǹ��ϰ� �ִµ� �ϴ�.'
WHERE ItemID=505001

UPDATE Item SET HP=0, AP=0, MAXWT=0, TotalPoint=0, BountyPrice=0, SlugOutput=1, Gadget=0, SF=0, FR=0,CR=0,PR=0,LR=0, BlendColor=0, ModelName='', LimitSpeed=0, IsCashItem=1,
ResSex=3, Slot=2, 
ResLevel=0, Weight=12, Damage=18, Delay=250, Controllability=36, Magazine=12, MaxBullet=72, ReloadTime=4, 
Description='�ʺ� ���谡���� �ַ� ����ϴ� ����.'
WHERE ItemID=504001

UPDATE Item SET HP=0, AP=0, MAXWT=0, TotalPoint=0, BountyPrice=0, SlugOutput=1, Gadget=0, SF=0, FR=0,CR=0,PR=0,LR=0, BlendColor=0, ModelName='', LimitSpeed=0, IsCashItem=1,
ResSex=3, Slot=2, 
ResLevel=7, Weight=28, Damage=16, Delay=95, Controllability=90, Magazine=40, MaxBullet=200, ReloadTime=5, 
Description='��ȭ���� ������� ����ϴ� SMG. �ڽŵ��� �ٰ����� �̸��� �ٿ���.'
WHERE ItemID=505002

UPDATE Item SET HP=0, AP=0, MAXWT=0, TotalPoint=0, BountyPrice=0, SlugOutput=1, Gadget=0, SF=0, FR=0,CR=0,PR=0,LR=0, BlendColor=0, ModelName='', LimitSpeed=0, IsCashItem=1,
ResSex=3, Slot=2, 
ResLevel=7, Weight=18, Damage=15, Delay=110, Controllability=30, Magazine=36, MaxBullet=180, ReloadTime=5, 
Description='��ȭ���� ������� ����ϴ� ����. �ڽŵ��� �ٰ����� �̸��� �ٿ���.'
WHERE ItemID=507001

UPDATE Item SET HP=0, AP=0, MAXWT=0, TotalPoint=0, BountyPrice=0, SlugOutput=1, Gadget=0, SF=0, FR=0,CR=0,PR=0,LR=0, BlendColor=0, ModelName='', LimitSpeed=0, IsCashItem=1,
ResSex=3, Slot=2, 
ResLevel=7, Weight=18, Damage=7, Delay=1100, Controllability=60, Magazine=5, MaxBullet=25, ReloadTime=5, 
Description='��ȭ���� ������� ����ϴ� ����. �ڽŵ��� �ٰ����� �̸��� �ٿ���.'
WHERE ItemID=506001

UPDATE Item SET HP=0, AP=0, MAXWT=0, TotalPoint=0, BountyPrice=0, SlugOutput=1, Gadget=0, SF=0, FR=0,CR=0,PR=0,LR=0, BlendColor=0, ModelName='', LimitSpeed=0, IsCashItem=1,
ResSex=3, Slot=2, 
ResLevel=15, Weight=28, Damage=16, Delay=90, Controllability=80, Magazine=40, MaxBullet=200, ReloadTime=5, 
Description='�����ڵ��� ���� �Ϲٴϸ� �ָ���� ���̾�ũ�ο쿡�� ����ϴ� SMG'
WHERE ItemID=505003

UPDATE Item SET HP=0, AP=0, MAXWT=0, TotalPoint=0, BountyPrice=0, SlugOutput=1, Gadget=0, SF=0, FR=0,CR=0,PR=0,LR=0, BlendColor=0, ModelName='', LimitSpeed=0, IsCashItem=1,
ResSex=3, Slot=2, 
ResLevel=15, Weight=18, Damage=16, Delay=100, Controllability=30, Magazine=36, MaxBullet=180, ReloadTime=5, 
Description='�����ڵ��� ���� �Ϲٴϸ� �ָ���� ���̾�ũ�ο쿡�� ����ϴ� ����'
WHERE ItemID=507002

UPDATE Item SET HP=0, AP=0, MAXWT=0, TotalPoint=0, BountyPrice=0, SlugOutput=1, Gadget=0, SF=0, FR=0,CR=0,PR=0,LR=0, BlendColor=0, ModelName='', LimitSpeed=0, IsCashItem=1,
ResSex=3, Slot=2, 
ResLevel=15, Weight=18, Damage=7, Delay=900, Controllability=60, Magazine=5, MaxBullet=25, ReloadTime=5, 
Description='�����ڵ��� ���� �Ϲٴϸ� �ָ���� ���̾�ũ�ο쿡�� ����ϴ� ����'
WHERE ItemID=506002







-- 
INSERT INTO CashShop (ItemID, NewItemOrder, CashPrice, RegDate, Opened, WebImgName) 
VALUES (505001, 0, 1500, GETDATE(), 1, '')

-- 
INSERT INTO CashShop (ItemID, NewItemOrder, CashPrice, RegDate, Opened, WebImgName) 
VALUES (504001, 0, 1500, GETDATE(), 1, '')

-- 
INSERT INTO CashShop (ItemID, NewItemOrder, CashPrice, RegDate, Opened, WebImgName) 
VALUES (505002, 0, 2500, GETDATE(), 1, '')

-- 
INSERT INTO CashShop (ItemID, NewItemOrder, CashPrice, RegDate, Opened, WebImgName) 
VALUES (507001, 0, 2500, GETDATE(), 1, '')

-- 
INSERT INTO CashShop (ItemID, NewItemOrder, CashPrice, RegDate, Opened, WebImgName) 
VALUES (506001, 0, 2500, GETDATE(), 1, '')

-- 
INSERT INTO CashShop (ItemID, NewItemOrder, CashPrice, RegDate, Opened, WebImgName) 
VALUES (505003, 0, 3500, GETDATE(), 1, '')

-- 
INSERT INTO CashShop (ItemID, NewItemOrder, CashPrice, RegDate, Opened, WebImgName) 
VALUES (507002, 0, 3500, GETDATE(), 1, '')

-- 
INSERT INTO CashShop (ItemID, NewItemOrder, CashPrice, RegDate, Opened, WebImgName) 
VALUES (506002, 0, 3500, GETDATE(), 1, '')







