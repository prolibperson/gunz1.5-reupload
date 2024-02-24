USE GunzDB
GO

--------------------------------------------------------------------------------------------------------
-- ����) �������鿡 '20100506'�� ������ �����ϴ� ������ ��¥�� �ٲ��ش�.
--      ��¥�� ���Ͽ� ���� �� �ɸ��͸� �����ϰ� ó���Ѵ�.
--		��) CAST('20100506' AS DATETIME) -> CAST(���糯¥ AS DATETIME)
--------------------------------------------------------------------------------------------------------
BEGIN TRAN ------------

	--------------------------------------------------------------------------------------------------------
	-- ������ �ɸ��͵��� ģ�� ����� ��� �����Ѵ�. 
	UPDATE	f
	SET		f.DeleteFlag = 1  
	FROM	dbo.SleepCharacterNHN t
		  , dbo.Friend f
	WHERE	t.CID = f.CID
	AND		t.RegDt = CAST('20100506' AS DATETIME);
	
	UPDATE	f
	SET		f.DeleteFlag = 1  
	FROM	dbo.SleepCharacterNHN t
		  , dbo.Friend f
	WHERE	t.CID = f.FriendCID
	AND		t.RegDt = CAST('20100506' AS DATETIME);
	
COMMIT TRAN ------------
GO