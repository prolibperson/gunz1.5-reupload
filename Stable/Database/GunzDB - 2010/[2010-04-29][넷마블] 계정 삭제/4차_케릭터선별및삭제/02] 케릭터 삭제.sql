--USE GunzdB
USE TGunzDB
GO

BEGIN TRAN -------------
	EXEC sp_helpindex Character
	
	DROP INDEX dbo.Character.IX_Character_Name
	DROP INDEX dbo.Character.IX_Character_DeleteFlag	
	DROP INDEX dbo.Character.IX_Character_AID_CharNum
	DROP INDEX dbo.Character.IX_Character_AID_DeleteFlag
			
		 
	UPDATE	c 
	SET		c.DeleteName = c.Name, c.Name = '', c.CharNum = -1, c.DeleteFlag = 1
	FROM	dbo.Character c 
			, dbo.CharacterDeleteTarget t	 	
	WHERE	c.CID = t.CID
	AND		c.DeleteFlag = 0;
	
		
	CREATE INDEX IX_Character_Name				ON dbo.Character(Name)
	CREATE INDEX IX_Character_DeleteFlag		ON dbo.Character(DeleteFlag)
	CREATE INDEX IX_Character_AID_CharNum		ON dbo.Character(AID, CharNum)
	CREATE INDEX IX_Character_AID_DeleteFlag	ON dbo.Character(AID, DeleteFlag)	
COMMIT TRAN ------------



----------------------------------------------------------------------------------------------
-- Step 1. ������ �ɸ��͵�� ���õ� ������ ����
----------------------------------------------------------------------------------------------
BEGIN TRAN ------------	
	INSERT INTO dbo.AccountItem(AID, ItemID, RentDate, RentHourPeriod)
		SELECT	t.AID, ci.ItemID, ci.RentDate, ci.RentHourPeriod
		FROM	dbo.CharacterDeleteTarget t
				, dbo.CharacterItem ci
		WHERE	ci.CID = t.CID 	
		AND		ci.ItemID >= 500000
		
		
	DELETE	ci
	FROM	dbo.CharacterDeleteTarget t
			, dbo.CharacterItem ci
	WHERE	ci.CID = t.CID 	
	AND		ci.ItemID >= 500000
COMMIT TRAN ------------



----------------------------------------------------------------------------------------------
-- Step 2. ������ �ɸ��͵�� ���õ� Ŭ�� ����
----------------------------------------------------------------------------------------------
BEGIN TRAN ------------	
	EXEC sp_helpindex Clan
	
	DROP INDEX dbo.Clan.IX_Clan_DeleteFlag
	DROP INDEX dbo.Clan.IX_Clan_Name
	
	-- �������� �ɸ��Ͱ� �����Ǹ� Ŭ���� ���	
	UPDATE	c
	SET		c.DeleteName = c.Name, c.Name = NULL, c.DeleteFlag = 1, c.DeleteDate = GETDATE()
	FROM	dbo.CharacterDeleteTarget t
			, dbo.Clan c 
	WHERE	c.MasterCID = t.CID	
	
	
	CREATE INDEX IX_Clan_Name		ON dbo.Clan(Name)
	CREATE INDEX IX_Clan_DeleteFlag	ON dbo.Clan(DeleteFlag)
				

	-- ������ �ɸ��͵� �߿�, Ŭ���� ���� �ִ� ����� ��� Ż���Ų��.
	DELETE	c
	FROM	dbo.CharacterDeleteTarget t
		  , dbo.ClanMember c 
	WHERE	c.CID = t.CID
	
		
	-- �ƹ��� ���� Ŭ���� ���� ���, Ŭ���� ���
	UPDATE Clan
	SET	   DeleteName = Name, Name = NULL, DeleteFlag = 1, DeleteDate = GETDATE()
	WHERE  DeleteFlag = 0 
	AND	   NOT EXISTS(SELECT 1 FROM ClanMember cm WHERE cm.CLID = Clan.CLID);	
	
	
	
COMMIT TRAN ------------



----------------------------------------------------------------------------------------------
-- Step 3. ������ �ɸ��͵�� ���õ� ģ�� ����
----------------------------------------------------------------------------------------------
BEGIN TRAN ------------
	EXEC sp_helpindex Friend
	
	DELETE	f
	FROM	dbo.CharacterDeleteTarget t
			, dbo.Friend f
	WHERE	t.CID = f.FriendCID	
	OR		t.CID = f.CID
	
COMMIT TRAN ------------


----------------------------------------------------------------------------------------------
-- Step 4. ������ �ɸ��͵�� ���õ� �ɸ��� ���� �α� ����
----------------------------------------------------------------------------------------------
BEGIN TRAN ------------

	INSERT INTO GunzDB.dbo.CharacterMakingLog(AID, CharName, Type, Date)
		SELECT	t.AID, t.Name, '����', GETDATE()
		FROM	dbo.CharacterDeleteTarget t(NOLOCK)	
		
COMMIT TRAN ------------