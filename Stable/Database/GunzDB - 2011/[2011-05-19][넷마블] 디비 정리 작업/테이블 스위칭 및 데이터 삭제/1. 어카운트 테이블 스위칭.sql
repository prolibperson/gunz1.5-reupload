USE GunzDB
GO

-------------------------------------------------------------------------------------------
/**
    �ܰ� 1. ��ī��Ʈ ���̺� DeleteDate �÷� �߰� �� �����ϱ�
*/
ALTER TABLE dbo.Account ADD DeleteDate DATETIME;
    
UPDATE  A
SET     A.DeleteDate = AL.DeleteDate
FROM    AccountDeleteLog AL(TABLOCK)
        JOIN Account A(TABLOCK)
        ON AL.AID = A.AID
WHERE   A.DelFlag = 1

/**
    �ܰ� 2. ��ī��Ʈ ���̺� �ɷ��ִ� ��� Foreign Key ���̱�
    ����) �Ʒ� �ܿ� �� �ٸ� Ű�� ���� ���� ����(�� �������� ���ݾ� �ٸ�)
*/
EXEC SP_HELP ACCOUNT

ALTER TABLE dbo.AccountItem             DROP Account_���̺�1_FK1
ALTER TABLE dbo.AccountPenaltyGMLog     DROP AccountPenaltyGMLog_Account_FK
ALTER TABLE dbo.AccountPenaltyPeriod    DROP AccountPenaltyPeriod_Account_FK1
ALTER TABLE dbo.BringAccountItemLog     DROP Account_BringAccountItemLog_FK1
ALTER TABLE dbo.Character               DROP FK_Character_Account
ALTER TABLE dbo.ItemPurchaseLogByCash   DROP Account_PurchaseLogByCash_FK1
ALTER TABLE dbo.PremiumAccountHistory   DROP Account_PremiumAccountHis
GO

-------------------------------------------------------------------------------------------

/**
    �ܰ� 3. ��ī��Ʈ ���̺� �� �ε��� ����Ī�ϱ�
*/
EXEC SP_RENAME 'Account', 'AccountOld';
EXEC SP_RENAME 'Account_PK', 'PK_AccountOld';
EXEC SP_RENAME 'FK_Account_PremiumGrade', 'FK_AccountOld_PremiumGrade'
EXEC SP_RENAME 'FK_Account_UserGrade', 'FK_AccountOld_UserGrade'

-------------------------------------------------------------------------------------------


/**
    �ܰ� 4. ���ο� ��ī��Ʈ ���̺� �����
*/


CREATE TABLE [dbo].[Account]
(
	[AID]	                INT	IDENTITY(1, 1)	NOT NULL, 
	[UserID]	            VARCHAR(20)	 	NOT NULL, 
	[UGradeID]	            INT	 	        NOT NULL, 
	[PGradeID]	            INT	 	        NOT NULL, 
	[RegDate]	            DATETIME	 	NOT NULL, 
	[Name]	                VARCHAR(50)	 	NOT NULL, 
	[Email]	                VARCHAR(50)	 	NULL, 
	[RegNum]	            VARCHAR(50)	 	NULL, 
	[Age]	                SMALLINT	 	NULL, 
	[Sex]	                TINYINT	 	    NULL, 
	[ZipCode]	            VARCHAR(50)	 	NULL, 
	[Address]	            VARCHAR(256)	NULL, 
	[Country]	            VARCHAR(50)	 	NULL, 
	[LastCID]	            INT	 	        NULL, 
	[Cert]	                TINYINT	 	    NULL, 
	[LastLogoutTime]	    SMALLDATETIME	NULL, 
	[HackingType]	        TINYINT	 	    NULL, 
	[HackingRegTime]	    SMALLDATETIME 	NULL, 
	[EndHackingBlockTime]	SMALLDATETIME 	NULL, 
	[LastloginTime]	        SMALLDATETIME 	NULL, 
	[ServerID]	            TINYINT	 	    NULL, 
	[DelFlag]	            TINYINT	 	    NULL, 
	[CCode]	                TINYINT	 	    NULL, 
);
GO
-------------------------------------------------------------------------------------------


/**
    �ܰ� 5. ��� CID �÷��� Identity �Ӽ� ���� ������ �о�ֱ�
*/

ALTER DATABASE GunzDB SET RECOVERY SIMPLE;
SET IDENTITY_INSERT dbo.Account ON;

INSERT dbo.Account([AID], [UserID], [UGradeID], [PGradeID], [RegDate], [Name], [Email], [RegNum], 
	        [Age], [Sex], [ZipCode], [Address],	[Country], [LastCID], [Cert], [LastLogoutTime], 
            [HackingType], [HackingRegTime], [EndHackingBlockTime], [LastloginTime], [ServerID], [DelFlag], [CCode])
    SELECT  [AID], [UserID], [UGradeID], [PGradeID], [RegDate], [Name], [Email], [RegNum], 
	        [Age], [Sex], [ZipCode], [Address],	[Country], [LastCID], [Cert], [LastLogoutTime], 
            [HackingType], [HackingRegTime], [EndHackingBlockTime], [LastloginTime], [ServerID], [DelFlag], [CCode]
    FROM    dbo.AccountOld WITH (TABLOCK)
    WHERE   DelFlag = 0
    OR      ( DelFlag = 1 AND DeleteDate > DATEADD(mm, -6, GETDATE()) )

DECLARE @OldIdentity INT;
SET @OldIdentity = IDENT_CURRENT('AccountOld') + 1;
DBCC CHECKIDENT('Account', RESEED, @OldIdentity)

SET IDENTITY_INSERT dbo.Account OFF;
ALTER DATABASE GunzDB SET RECOVERY SIMPLE;


-------------------------------------------------------------------------------------------


/**
    �ܰ� 5. ���̺� ���� Constraint�� �ε��� �����
*/

ALTER TABLE [dbo].[Account] ADD CONSTRAINT PK_Account PRIMARY KEY CLUSTERED (AID) 
GO

ALTER TABLE dbo.Account WITH CHECK ADD CONSTRAINT FK_Account_PremiumGrade
FOREIGN KEY (PGradeID) REFERENCES [dbo].[Account](PGradeID)
GO

ALTER TABLE dbo.Account WITH CHECK ADD CONSTRAINT FK_Account_UserGrade
FOREIGN KEY (UGradeID) REFERENCES [dbo].[Account](UGradeID)
GO

CREATE NONCLUSTERED INDEX IX_Account_DelFlag_DeleteDate ON [dbo].[Account](DelFlag, DeleteDate) 
CREATE NONCLUSTERED INDEX IX_Account_LastLogoutTime ON [dbo].[Account](LastLogoutTime);
CREATE NONCLUSTERED INDEX IX_Account_RegDate ON [dbo].[Account](RegDate);

CREATE UNIQUE NONCLUSTERED INDEX UIX_Account_UserID ON [dbo].[Account](UserID) 

ALTER TABLE [dbo].[Account] ADD CONSTRAINT DF_Account_DelFlag DEFAULT(0) FOR DelFlag
