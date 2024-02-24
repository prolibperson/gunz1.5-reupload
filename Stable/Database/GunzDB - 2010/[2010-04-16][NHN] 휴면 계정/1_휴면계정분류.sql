USE GunzDB
GO

--------------------------------------------------------------------------------------------------------
-- �޸� �������� �з��� ������� ����� ������ ���̺�
CREATE TABLE SleepAccountNHN
(
	AID		INT 		NOT NULL
  , UserID 	VARCHAR(24) NOT NULL
  , RegDt 	DATETIME 	NOT NULL
);
GO

--------------------------------------------------------------------------------------------------------
-- ������ �ɸ��͵��� ����� ������ ���̺�
CREATE TABLE SleepCharacterNHN
(
	AID 	INT 		NOT NULL
  , CID 	INT 		NOT NULL
  , Name 	VARCHAR(24) NOT NULL
  , RegDt 	DATETIME 	NOT NULL
);
GO



--------------------------------------------------------------------------------------------------------
-- ù ����(ó������ ������Ѿ� �Ǵ� ����)
BEGIN TRAN ------------
	
	--------------------------------------------------------------------------------------------------------
	-- Step 3. �޸� �������� �з�
	DECLARE @NowDate DATETIME;
	SET @NowDate = GETDATE();	
	
	INSERT INTO SleepAccountNHN(AID, UserID, RegDt)
		SELECT AID, UserID, CONVERT(VARCHAR(8), GETDATE(), 112)
		FROM   Account WITH (NOLOCK)
		WHERE  DATEDIFF(day, LastLogoutTime, @Nowdate) > 180
		AND	   (HackingType != 10 OR HackingType IS NULL)
		
	CREATE CLUSTERED INDEX IX_SleepAccountNHN_RegDt ON SleepAccountNHN(RegDt);
	CREATE INDEX IX_SleepAccountNHN_UserID ON SleepAccountNHN(UserID);
	ALTER TABLE SleepAccountNHN ADD CONSTRAINT SleepAccountNHN_PK PRIMARY KEY NONCLUSTERED (AID);

	
	UPDATE Account
	SET    HackingType = 10
	WHERE  DATEDIFF(day, LastLogoutTime, @Nowdate) > 180
	AND	   (HackingType != 10 OR HackingType IS NULL)
	


COMMIT TRAN ------------
GO



--------------------------------------------------------------------------------------------------------
-- ù ���� ����, ���Ŀ� �޸� ���� ó���� �� ������Ѿ� �Ǵ� ����
BEGIN TRAN ------------
	/*	
	DECLARE @NowDate DATETIME;
	SET @NowDate = GETDATE();	
	
	INSERT INTO SleepAccountNHN(AID, UserID, RegDt)
		SELECT AID, UserID, CONVERT(VARCHAR(8), GETDATE(), 112)
		FROM   Account WITH (NOLOCK)
		WHERE  DATEDIFF(day, LastLogoutTime, @NowDate) > 180
		AND	   (HackingType != 10 OR HackingType IS NULL)
		
	UPDATE Account
	SET	   HackingType = 10
	WHERE  AID IN (SELECT AID 
				   FROM NHN_SLEEP_ACCOUNT 
				   WHERE RegDt = CAST('20100506' AS DATETIME));
	*/
COMMIT TRAN ------------
GO