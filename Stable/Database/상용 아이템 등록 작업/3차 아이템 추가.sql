UPDATE Item SET TotalPoint=0, BountyPrice=0, Damage=0, Delay=0, Controllability=0, Magazine=0, ReloadTime=0, SlugOutput=0, Gadget=0, SF=0, FR=0,CR=0,PR=0,LR=0, BlendColor=0, ModelName='', MaxBullet=0, LimitSpeed=0, IsCashItem=1,
ResSex=1, ResLevel=0,Slot=4,Weight=4, HP=1, AP=2, MAXWT=0, 
Description='�δ���� �����ϱ� ���� ������ �ΰ�. �����Ϳ��� �ڽ��� �����ϱ� ���� ����ϱ⵵ �Ѵ�.'
WHERE ItemID=520004

UPDATE Item SET TotalPoint=0, BountyPrice=0, Damage=0, Delay=0, Controllability=0, Magazine=0, ReloadTime=0, SlugOutput=0, Gadget=0, SF=0, FR=0,CR=0,PR=0,LR=0, BlendColor=0, ModelName='', MaxBullet=0, LimitSpeed=0, IsCashItem=1,
ResSex=1, ResLevel=0,Slot=4,Weight=4, HP=1, AP=2, MAXWT=0, 
Description='�����ְ� ������ �����ϱ⿡ ���� ������ �ΰ�. �м� �Ǽ������� ����ϰ� �Ѵ�.'
WHERE ItemID=520005

UPDATE Item SET TotalPoint=0, BountyPrice=0, Damage=0, Delay=0, Controllability=0, Magazine=0, ReloadTime=0, SlugOutput=0, Gadget=0, SF=0, FR=0,CR=0,PR=0,LR=0, BlendColor=0, ModelName='', MaxBullet=0, LimitSpeed=0, IsCashItem=1,
ResSex=1, ResLevel=0,Slot=4,Weight=4, HP=1, AP=2, MAXWT=0, 
Description='������ �ս��� ���밡���� ������ �ΰ�. ������ õ���� �Ϳ��� ������� �������� �ִ�.'
WHERE ItemID=520006

UPDATE Item SET TotalPoint=0, BountyPrice=0, Damage=0, Delay=0, Controllability=0, Magazine=0, ReloadTime=0, SlugOutput=0, Gadget=0, SF=0, FR=0,CR=0,PR=0,LR=0, BlendColor=0, ModelName='', MaxBullet=0, LimitSpeed=0, IsCashItem=1,
ResSex=1, ResLevel=0,Slot=4,Weight=4, HP=1, AP=2, MAXWT=0, 
Description='��Ư�� ������ ����� �������� ������ �ΰ�.'
WHERE ItemID=520007


UPDATE Item SET TotalPoint=0, BountyPrice=0, Damage=0, Delay=0, Controllability=0, Magazine=0, ReloadTime=0, SlugOutput=0, Gadget=0, SF=0, FR=0,CR=0,PR=0,LR=0, BlendColor=0, ModelName='', MaxBullet=0, LimitSpeed=0, IsCashItem=1,
ResSex=2, ResLevel=0,Slot=4,Weight=4, HP=1, AP=2, MAXWT=0, 
Description='�δ���� �����ϱ� ���� ������ �ΰ�. �����Ϳ��� �ڽ��� �����ϱ� ���� ����ϱ⵵ �Ѵ�.'
WHERE ItemID=520504

UPDATE Item SET TotalPoint=0, BountyPrice=0, Damage=0, Delay=0, Controllability=0, Magazine=0, ReloadTime=0, SlugOutput=0, Gadget=0, SF=0, FR=0,CR=0,PR=0,LR=0, BlendColor=0, ModelName='', MaxBullet=0, LimitSpeed=0, IsCashItem=1,
ResSex=2, ResLevel=0,Slot=4,Weight=4, HP=1, AP=2, MAXWT=0, 
Description='�����ְ� ������ �����ϱ⿡ ���� ������ �ΰ�. �м� �Ǽ������� ����ϰ� �Ѵ�.'
WHERE ItemID=520505

UPDATE Item SET TotalPoint=0, BountyPrice=0, Damage=0, Delay=0, Controllability=0, Magazine=0, ReloadTime=0, SlugOutput=0, Gadget=0, SF=0, FR=0,CR=0,PR=0,LR=0, BlendColor=0, ModelName='', MaxBullet=0, LimitSpeed=0, IsCashItem=1,
ResSex=2, ResLevel=0,Slot=4,Weight=4, HP=1, AP=2, MAXWT=0, 
Description='������ �ս��� ���밡���� �ΰ�. ������ õ���� �Ϳ��� ������� �������� �ִ�.'
WHERE ItemID=520506

UPDATE Item SET TotalPoint=0, BountyPrice=0, Damage=0, Delay=0, Controllability=0, Magazine=0, ReloadTime=0, SlugOutput=0, Gadget=0, SF=0, FR=0,CR=0,PR=0,LR=0, BlendColor=0, ModelName='', MaxBullet=0, LimitSpeed=0, IsCashItem=1,
ResSex=2, ResLevel=0,Slot=4,Weight=4, HP=1, AP=2, MAXWT=0, 
Description='��Ư�� ������ ����� �������� ������ �ΰ�.'
WHERE ItemID=520507


-- ���� �и��͸��� �ΰ�
INSERT INTO CashShop (ItemID, NewItemOrder, CashPrice, RegDate, Opened, WebImgName) 
VALUES (520004, 0, 800, GETDATE(), 0, '')

-- ���� �ι��� �ΰ�
INSERT INTO CashShop (ItemID, NewItemOrder, CashPrice, RegDate, Opened, WebImgName) 
VALUES (520005, 0, 800, GETDATE(), 0, '')

-- ���� ����﹫�� �ΰ�
INSERT INTO CashShop (ItemID, NewItemOrder, CashPrice, RegDate, Opened, WebImgName) 
VALUES (520006, 0, 800, GETDATE(), 0, '')

-- ���� ������ �ΰ�
INSERT INTO CashShop (ItemID, NewItemOrder, CashPrice, RegDate, Opened, WebImgName) 
VALUES (520007, 0, 800, GETDATE(), 0, '')

-- ���� �и��͸��� �ΰ�
INSERT INTO CashShop (ItemID, NewItemOrder, CashPrice, RegDate, Opened, WebImgName) 
VALUES (520504, 0, 800, GETDATE(), 0, '')

-- ���� �ι��� �ΰ�
INSERT INTO CashShop (ItemID, NewItemOrder, CashPrice, RegDate, Opened, WebImgName) 
VALUES (520505, 0, 800, GETDATE(), 0, '')

-- ���� ����﹫�� �ΰ�
INSERT INTO CashShop (ItemID, NewItemOrder, CashPrice, RegDate, Opened, WebImgName) 
VALUES (520506, 0, 800, GETDATE(), 0, '')

-- ���� ������ �ΰ�
INSERT INTO CashShop (ItemID, NewItemOrder, CashPrice, RegDate, Opened, WebImgName) 
VALUES (520507, 0, 800, GETDATE(), 0, '')
