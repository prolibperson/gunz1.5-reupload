UPDATE Item SET HP=0, AP=0, MAXWT=0, TotalPoint=0, BountyPrice=0, SlugOutput=0, Gadget=0, SF=0, FR=0,CR=0,PR=0,LR=0, BlendColor=0, ModelName='', LimitSpeed=100, IsCashItem=1,
ResSex=3, Slot=1,
ResLevel=0, Weight=4, Damage=9, Delay=90, Controllability=0, Magazine=0, MaxBullet=0, ReloadTime=0,
Description='���谡���� ���� �淮ȭ�� �ǿ����� �ܰ�'
WHERE ItemID=500001

UPDATE Item SET HP=0, AP=0, MAXWT=0, TotalPoint=0, BountyPrice=0, SlugOutput=0, Gadget=0, SF=0, FR=0,CR=0,PR=0,LR=0, BlendColor=0, ModelName='', LimitSpeed=100, IsCashItem=1,
ResSex=3, Slot=1,
ResLevel=0, Weight=9, Damage=16, Delay=60, Controllability=0, Magazine=0, MaxBullet=0, ReloadTime=0,
Description='���谡���� ���� �淮ȭ�� �ǿ����� ���'
WHERE ItemID=502001

UPDATE Item SET HP=0, AP=0, MAXWT=0, TotalPoint=0, BountyPrice=0, SlugOutput=0, Gadget=0, SF=0, FR=0,CR=0,PR=0,LR=0, BlendColor=0, ModelName='', LimitSpeed=100, IsCashItem=1,
ResSex=3, Slot=1,
ResLevel=7, Weight=4, Damage=10, Delay=80, Controllability=0, Magazine=0, MaxBullet=0, ReloadTime=0,
Description='�������� �˻簡 ����س� Ư���� ����� �ܰ�'
WHERE ItemID=500002

UPDATE Item SET HP=0, AP=0, MAXWT=0, TotalPoint=0, BountyPrice=0, SlugOutput=0, Gadget=0, SF=0, FR=0,CR=0,PR=0,LR=0, BlendColor=0, ModelName='', LimitSpeed=100, IsCashItem=1,
ResSex=3, Slot=1,
ResLevel=7, Weight=8, Damage=17, Delay=50, Controllability=0, Magazine=0, MaxBullet=0, ReloadTime=0,
Description='�������� �˻簡 ����س� Ư���� ����� ���'
WHERE ItemID=502002

UPDATE Item SET HP=0, AP=0, MAXWT=0, TotalPoint=0, BountyPrice=0, SlugOutput=0, Gadget=0, SF=0, FR=0,CR=0,PR=0,LR=0, BlendColor=0, ModelName='', LimitSpeed=100, IsCashItem=1,
ResSex=3, Slot=1,
ResLevel=15, Weight=6, Damage=11, Delay=80, Controllability=0, Magazine=0, MaxBullet=0, ReloadTime=0,
Description='���κ��� ���س����� ������ �ܰ�.'
WHERE ItemID=500003

UPDATE Item SET HP=0, AP=0, MAXWT=0, TotalPoint=0, BountyPrice=0, SlugOutput=0, Gadget=0, SF=0, FR=0,CR=0,PR=0,LR=0, BlendColor=0, ModelName='', LimitSpeed=100, IsCashItem=1,
ResSex=3, Slot=1,
ResLevel=15, Weight=10, Damage=19, Delay=50, Controllability=0, Magazine=0, MaxBullet=0, ReloadTime=0,
Description='���κ��� ���س����� ������ ���.'
WHERE ItemID=502003


--
INSERT INTO CashShop (ItemID, NewItemOrder, CashPrice, RegDate, Opened, WebImgName)
VALUES (500001, 0, 1500, GETDATE(), 0, '')

--
INSERT INTO CashShop (ItemID, NewItemOrder, CashPrice, RegDate, Opened, WebImgName)
VALUES (502001, 0, 1500, GETDATE(), 0, '')

--
INSERT INTO CashShop (ItemID, NewItemOrder, CashPrice, RegDate, Opened, WebImgName)
VALUES (500002, 0, 2500, GETDATE(), 0, '')

--
INSERT INTO CashShop (ItemID, NewItemOrder, CashPrice, RegDate, Opened, WebImgName)
VALUES (502002, 0, 2500, GETDATE(), 0, '')

--
INSERT INTO CashShop (ItemID, NewItemOrder, CashPrice, RegDate, Opened, WebImgName)
VALUES (500003, 0, 3500, GETDATE(), 0, '')

--
INSERT INTO CashShop (ItemID, NewItemOrder, CashPrice, RegDate, Opened, WebImgName)
VALUES (502003, 0, 3500, GETDATE(), 0, '')

--INSERT INTO CashSetItem (CSSID, CSID) VALUES (, )
