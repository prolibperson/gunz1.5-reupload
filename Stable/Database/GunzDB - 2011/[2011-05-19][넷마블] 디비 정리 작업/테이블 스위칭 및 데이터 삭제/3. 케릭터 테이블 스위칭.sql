USE GunzDB
GO

-------------------------------------------------------------------------------------------

/**
    �ܰ� 1. �ɸ��� ���̺� �ɷ��ִ� ��� Foreign Key ���̱�
    ����) �Ʒ� �ܿ� �� �ٸ� Ű�� ���� ���� ����(�� �������� ���ݾ� �ٸ�)
*/
EXEC SP_HELP Character
ALTER TABLE dbo.Character DROP Account_Character_FK1;

ALTER TABLE dbo.CharacterItem       DROP Character_CharacterItem_FK1
ALTER TABLE dbo.CharacterMgrLogByGM DROP FK__CharacterMg__CID__5887175A
ALTER TABLE dbo.Clan                DROP Clan_Character_FK1
ALTER TABLE dbo.ClanMember          DROP ClanMember_Clan_FK2
ALTER TABLE dbo.DTCharacterInfo     DROP Character_DTCharacterInfo_FK1
ALTER TABLE dbo.Friend              DROP Character_Friend_FK1
ALTER TABLE dbo.Friend              DROP Character_Friend_FK2
GO

-------------------------------------------------------------------------------------------

/**
    �ܰ� 2. �ɸ��� ���̺� �� �ε��� ����Ī�ϱ�
*/
EXEC SP_RENAME 'Character',                             'CharacterOld';
EXEC SP_RENAME 'Character_PK',                          'PK_CharacterOld';

-------------------------------------------------------------------------------------------


/**
    �ܰ� 3. ���ο� �ɸ��� ���̺� �����
*/

CREATE TABLE [dbo].[Character]
(
	[CID]	        INT	IDENTITY(1, 1)	NOT NULL, 
	[AID]	        INT	 	            NOT NULL, 
	[Name]	        VARCHAR(24)	 	    NOT NULL, 
	[Level]	        SMALLINT	 	    NOT NULL, 
	[Sex]	        TINYINT	 	        NOT NULL, 
	[CharNum]	    SMALLINT	 	    NOT NULL, 
	[Hair]	        TINYINT	 	        NULL, 
	[Face]	        TINYINT	 	        NULL, 
	[XP]	        INT	 	            NOT NULL, 
	[BP]	        INT	 	            NOT NULL, 
	[HP]	        SMALLINT	 	    NULL, 
	[AP]	        SMALLINT	 	    NULL, 
	[FR]	        INT	 	            NULL, 
	[CR]	        INT	 	            NULL, 
	[ER]	        INT	 	            NULL, 
	[WR]	        INT	 	            NULL, 
	[RegDate]	    DATETIME	 	    NULL, 
	[LastTime]	    DATETIME	 	    NULL, 
	[PlayTime]	    INT	 	            NULL, 
	[GameCount]	    INT	 	            NULL, 
	[KillCount]	    INT	 	            NULL, 
	[DeathCount]	INT	 	            NULL, 
	[DeleteFlag]	TINYINT	 	        NULL, 
	[DeleteName]	VARCHAR(24)	 	    NULL, 
	[QuestItemInfo]	BINARY(292)	        NULL, 
	[DeleteDate]	DATETIME	 	    NULL, 
);
GO
-------------------------------------------------------------------------------------------


/**
    �ܰ� 4. ��� CID �÷��� Identity �Ӽ� ���� ������ �о�ֱ�
*/

ALTER DATABASE GunzDB SET RECOVERY SIMPLE;
SET IDENTITY_INSERT dbo.Character ON;

INSERT dbo.Character([CID], [AID], [Name], [Level], [Sex], [CharNum], [Hair], [Face], [XP], [BP], [HP], [AP],
            [FR], [CR], [ER], [WR], [RegDate], [LastTime], [PlayTime], [GameCount], [KillCount], [DeathCount], 
            [DeleteFlag], [DeleteName], [QuestItemInfo], [DeleteDate])
    SELECT  [CID], [AID], [Name], [Level], [Sex], [CharNum], [Hair], [Face], [XP], [BP], [HP], [AP],
	        [FR], [CR], [ER], [WR], [RegDate], [LastTime], [PlayTime], [GameCount], [KillCount], [DeathCount], 
	        [DeleteFlag], [DeleteName], [QuestItemInfo], [DeleteDate]        
    FROM    dbo.CharacterOld WITH (TABLOCK)
    WHERE   DeleteFlag = 0
    OR      ( DeleteFlag = 1 AND DeleteDate > DATEADD(mm, -6, GETDATE()) )

DECLARE @CharacterOldIdentity INT;
SET @CharacterOldIdentity = IDENT_CURRENT('CharacterOld') + 1;
DBCC CHECKIDENT('Character', RESEED, @CharacterOldIdentity)

SET IDENTITY_INSERT dbo.Character OFF;
ALTER DATABASE GunzDB SET RECOVERY SIMPLE;


-------------------------------------------------------------------------------------------


/**
    �ܰ� 5. ���̺� ���� Constraint�� �ε��� �����
*/

ALTER TABLE [dbo].[Character] ADD CONSTRAINT PK_Character PRIMARY KEY CLUSTERED (CID)
GO

ALTER TABLE dbo.Character WITH CHECK ADD CONSTRAINT FK_Character_Account
FOREIGN KEY (AID) REFERENCES [dbo].[Account](AID)
GO

CREATE NONCLUSTERED INDEX IX_Character_AID_CharNum ON [dbo].[Character](AID, CharNum); 
CREATE NONCLUSTERED INDEX IX_Character_AID_DeleteFlag ON [dbo].[Character](AID, DeleteFlag);
CREATE NONCLUSTERED INDEX IX_Character_DeleteFlag_DeleteDate ON [dbo].[Character](DeleteFlag, DeleteDate);
CREATE NONCLUSTERED INDEX IX_Character_Name ON [dbo].[Character](Name);
