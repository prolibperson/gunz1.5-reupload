USE GunzDB
GO

--------------------------------------------------------------------------------------------------------
-- ù ����(ó������ ������Ѿ� �Ǵ� ����)
BEGIN TRAN ------------

	--------------------------------------------------------------------------------------------------------
	-- ������ �ɸ��͵��� �з��ϰ�, �����ϰ�, �α׿� �����.
	INSERT dbo.SleepCharacterNHN(CID, AID, Name, RegDt)
		SELECT	c.CID, c.AID, c.Name, CONVERT(VARCHAR(8), GETDATE(), 112)
		FROM	dbo.Character c(NOLOCK) 
			  , dbo.SleepAccountNHN asl(NOLOCK) 
		WHERE	c.AID = asl.AID
		AND		c.DeleteFlag = 0
		
	-- �ε��� ����
	CREATE CLUSTERED INDEX IX_SleepCharacterNHN_RegDt ON SleepCharacterNHN(RegDt);
	CREATE INDEX IX_SleepCharacterNHN_AID ON dbo.SleepCharacterNHN(AID);
	ALTER TABLE SleepCharacterNHN ADD CONSTRAINT SleepCharacterNHN_PK PRIMARY KEY NONCLUSTERED (AID, CID);
		
	-- Character ���̺� �Ʒ��� ������Ʈ�� ���õ� �ε����� �ӽ÷� �����.
	-- ����) �ε��� �̸��� �ٸ� ���� �ֽ��ϴ�.
	DROP INDEX dbo.Character.IX_Character_DeleteFlag
	DROP INDEX dbo.Character.IX_Character_AID_DeleteFlag
	DROP INDEX dbo.Character.IX_Character_Name			
		 
	UPDATE	c 
	SET		c.DeleteName = c.Name, c.Name ='', c.CharNum = -1, c.DeleteFlag = 1
	FROM	dbo.Character c 
		  , dbo.SleepCharacterNHN t	 	
	WHERE	c.CID = t.CID
	AND		c.DeleteFlag = 0;
	
	-- �ӽ÷� ������ �ε����� �ٽ� �������ش�.
	-- ����) �Ʒ��� �̸����� �� �������ּ���.
	CREATE INDEX IX_Character_DeleteFlag		ON dbo.Character(DeleteFlag)
	CREATE INDEX IX_Character_AID_DeleteFlag	ON dbo.Character(AID, DeleteFlag)
	CREATE INDEX IX_Character_Name				ON dbo.Character(Name)

	
COMMIT TRAN ------------
GO



--------------------------------------------------------------------------------------------------------
-- ù ���� ����, ���Ŀ� �޸� ���� ó���� �� ������Ѿ� �Ǵ� ����
BEGIN TRAN ------------
/*
	INSERT dbo.SleepCharacterNHN(CID, AID, Name, RegDate)
		SELECT	c.CID, c.AID, c.Name, CONVERT(VARCHAR(8), GETDATE(), 112)
		FROM	dbo.Character c(NOLOCK) 
			  , dbo.SleepAccountNHN asl(NOLOCK) 
		WHERE	c.AID = asl.AID
		AND		c.DeleteFlag = 0
		AND		asl.RegDt = CAST('20100506' AS DATETIME);
		
		
	UPDATE	c 
	SET		c.DeleteName = c.Name, c.Name ='', c.CharNum = -1, c.DeleteFlag = 1
	FROM	dbo.Character c 
		  , dbo.SleepCharacterNHN t	 	
	WHERE	c.CID = t.CID
	AND		c.DeleteFlag = 0;
	AND		t.RegDT = CAST('20100506' AS DATETIME);
*/
COMMIT TRAN ------------
GO