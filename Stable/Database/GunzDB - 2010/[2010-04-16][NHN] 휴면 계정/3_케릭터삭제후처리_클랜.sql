USE GunzDB
GO

--------------------------------------------------------------------------------------------------------
-- ����) �������鿡 '20100506'�� ������ �����ϴ� ������ ��¥�� �ٲ��ش�.
--      ��¥�� ���Ͽ� ���� �� �ɸ��͸� �����ϰ� ó���Ѵ�.
--		��) CAST('20100506' AS DATETIME) -> CAST(���糯¥ AS DATETIME)
--------------------------------------------------------------------------------------------------------
BEGIN TRAN ------------

	--------------------------------------------------------------------------------------------------------
	-- ������ �ɸ��͵� �߿�, Ŭ�� �����Ͱ� ���� ���, Ŭ�� ��� ��, ��� Ż���Ų��.		
	UPDATE	c
	SET		c.DeleteName = c.Name, c.Name = NULL, c.DeleteFlag = 1, c.DeleteDate = GETDATE()
	FROM	dbo.SleepCharacterNHN t
		  , dbo.Clan c 
	WHERE	c.MasterCID = t.CID	
	AND		t.RegDt = CAST('20100506' AS DATETIME);
				

	--------------------------------------------------------------------------------------------------------
	-- ������ �ɸ��͵� �߿�, Ŭ���� ���� �ִ� ����� ��� Ż���Ų��.
	DELETE	c
	FROM	dbo.SleepCharacterNHN t
		  , dbo.ClanMember c 
	WHERE	c.CID = t.CID
	AND		t.RegDt = CAST('20100506' AS DATETIME);
	
		
	--------------------------------------------------------------------------------------------------------
	-- �ƹ��� ���� Ŭ���� ���� ���, Ŭ���� ����ų��? -_-;;	
	UPDATE Clan
	SET	   DeleteName = Name, Name = NULL, DeleteFlag = 1, DeleteDate = GETDATE()
	WHERE  DeleteFlag = 0 
	AND	   NOT EXISTS(SELECT 1 FROM ClanMember cm WHERE cm.CLID = Clan.CLID);	
	
COMMIT TRAN ------------
GO