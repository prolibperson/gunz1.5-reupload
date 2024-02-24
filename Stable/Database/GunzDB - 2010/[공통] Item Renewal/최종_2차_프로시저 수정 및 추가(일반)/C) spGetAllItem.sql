USE GunzDB
GO

-------------------------------------------------------------------------------------------------------------------------
-- �۾��� ����

CREATE PROC dbo.spGetAllItem
-- ALTER PROC dbo.spGetAllItem
AS BEGIN

	SET NOCOUNT ON;
	
	SELECT	ItemID, ResSex, ResLevel, Slot, Weight, BountyPrice, Damage, Delay
			, Controllability, MaxBullet, Magazine, ReloadTime, HP, AP
			, IsCashItem, IsSpendableItem
	FROM	Item(NOLOCK)
	
END
GO


-------------------------------------------------------------------------------------------------------------------------
-- ���� ����
/*
DROP PROC spBringBackAccountGambleItem
*/