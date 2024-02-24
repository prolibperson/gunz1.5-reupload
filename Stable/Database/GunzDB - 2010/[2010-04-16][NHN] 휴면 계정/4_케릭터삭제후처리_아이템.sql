USE GunzDB
GO

--------------------------------------------------------------------------------------------------------
-- ����) �������鿡 '20100506'�� ������ �����ϴ� ������ ��¥�� �ٲ��ش�.
--      ��¥�� ���Ͽ� ���� �� �ɸ��͸� �����ϰ� ó���Ѵ�.
--		��) CAST('20100506' AS DATETIME) -> CAST(���糯¥ AS DATETIME)
--------------------------------------------------------------------------------------------------------
BEGIN TRAN ------------

	--------------------------------------------------------------------------------------------------------
	-- ������ �ɸ��͵鿡�� �ִ� ĳ�� �������� ��� �߾� �������� ������, ��� �����Ѵ�.
	INSERT INTO dbo.AccountItem(AID, ItemID, RentDate, RentHourPeriod)
		SELECT	t.AID, ci.ItemID, ci.RentDate, ci.RentHourPeriod
		FROM	dbo.SleepCharacterNHN t
			  , dbo.CharacterItem ci
		WHERE	ci.CID = t.CID 	
		AND		ci.ItemID >= 500000
		AND		t.RegDt = CAST('20100506' AS DATETIME);
		
		
	DELETE	ci
	FROM	dbo.SleepCharacterNHN t, dbo.CharacterItem ci
	WHERE	ci.CID = t.CID 	
	AND		ci.ItemID >= 500000
	AND		t.RegDt = CAST('20100506' AS DATETIME);


COMMIT TRAN ------------
GO