USE HGunzDB

-- BULK INDEX�� �����Ͱ� ���Ե� ���̺�
CREATE TABLE dbo.[NetmarbleAccountInfo_20100217](
	UserID		NVARCHAR(50) 	NOT NULL,
	AID			NVARCHAR(50) 	NULL,
	UserCN		NVARCHAR(50) 	NULL,
	IsUser		CHAR(1)			NULL,
	IsBreakUser	CHAR(1)			NULL,
	ValidUserCN	NVARCHAR(50)	NULL,
	RegDate		DATETIME		NULL	
	
	CONSTRAINT NetmarbleAccountInfo_20100224_PK PRIMARY KEY CLUSTERED (UserID ASC)
) ON [PRIMARY]

DECLARE @SQL NVARCHAR(4000)
SET @SQL = 'BULK INSERT dbo.NetmarbleAccountInfo_20100217 FROM ''D:\GunzResult_100224.TXT'' '
SET @SQL = @SQL + 'WITH(FIELDTERMINATOR = ''' + CHAR(28) + ''', ROWTERMINATOR = ''\n'', '
SET @SQL = @SQL +' rows_per_batch=10000, MAXERRORS = 1000, KEEPNULLS, tablock )'
SELECT @SQL

EXEC (@SQL) 

============================================================================================

-- INSERT NetmarbleAccountInfo_20100224 VALUES('@1onia',  '2705147', 'NM0030921525', NULL, NULL, NULL, NULL)

-- SELECT COUNT(*) FROM NetmarbleAccountInfo_20100224 na																							--		5967790��

-- SELECT COUNT(*) FROM NetmarbleAccountInfo_20100224 na WHERE na.IsUser = 'Y' AND na.IsBreakUser IS NULL											--		4515549��
	-- SELECT COUNT(*) FROM NetmarbleAccountInfo_20100224 na WHERE na.IsUser = 'Y' AND na.IsBreakUser IS NULL AND na.ValidUserCN IS NULL			--  4515549��
	-- SELECT COUNT(*) FROM NetmarbleAccountInfo_20100224 na WHERE na.IsUser = 'Y' AND na.IsBreakUser IS NULL AND na.ValidUserCN IS NOT NULL		--		  0��
	
-- SELECT COUNT(*) FROM NetmarbleAccountInfo_20100224 na WHERE na.IsBreakUser = 'Y' AND na.IsUser IS NULL											--		1214985�� 
	-- SELECT COUNT(*) FROM NetmarbleAccountInfo_20100224 na WHERE na.IsBreakUser = 'Y' AND na.IsUser IS NULL AND na.ValidUserCN IS NULL			--	 928194��
	-- SELECT COUNT(*) FROM NetmarbleAccountInfo_20100224 na WHERE na.IsBreakUser = 'Y' AND na.IsUser IS NULL AND na.ValidUserCN IS NOT NULL		--	 286791��

-- SELECT COUNT(*) FROM NetmarbleAccountInfo_20100224 na WHERE na.IsUser IS NULL AND na.IsBreakUser IS NULL											--		 237106��  
	-- SELECT COUNT(*) FROM NetmarbleAccountInfo_20100224 na WHERE na.IsUser IS NULL AND na.IsBreakUser IS NULL AND na.ValidUserCN IS NULL			--	 153325��
	-- SELECT COUNT(*) FROM NetmarbleAccountInfo_20100224 na WHERE na.IsUser IS NULL AND na.IsBreakUser IS NULL AND na.ValidUserCN IS NOT NULL		--	  83781��

-- SELECT COUNT(*) FROM NetmarbleAccountInfo_20100224 na WHERE na.IsUser IS NOT NULL AND na.IsBreakUser IS NOT NULL										--		150��	
	-- SELECT COUNT(*) FROM NetmarbleAccountInfo_20100224 na WHERE na.IsUser IS NOT NULL AND na.IsBreakUser IS NOT NULL	AND na.ValidUserCN IS NULL		--	150��	
	-- SELECT COUNT(*) FROM NetmarbleAccountInfo_20100224 na WHERE na.IsUser IS NOT NULL AND na.IsBreakUser IS NOT NULL	AND na.ValidUserCN IS NOT NULL	--	  0��
	
============================================================================================

-- ���� �Ǿߵ� ID�� �ӽ÷� �����ϴ� ���̺�
CREATE TABLE NetmarbleTmpForRemove
(
	UserID				VARCHAR(20),
	DEL_ID				VARCHAR(20),
	AID					INT,
	LoginUpdated		TINYINT,
	AccountUpdated		TINYINT

	CONSTRAINT NetmarbleTmpForRemove_PK PRIMARY KEY CLUSTERED (UserID)
)

-- ���� �Ǿߵ� ID�� �ӽ÷� �����ϴ� ���̺�
CREATE TABLE NetmarbleTmpForUpdate
(
	UserID				VARCHAR(20),
	AID					INT,
	UserCN				VARCHAR(20),
	ValidUserCN			VARCHAR(20),
	LoginUpdated		TINYINT,
	AccountUpdated		TINYINT
	
	CONSTRAINT NetmarbleTmpForUpdate_PK PRIMARY KEY CLUSTERED (UserID)
)

SELECT TOP 100 * FROM NetmarbleAccountInfo_20100224 
============================================================================================
INSERT NetmarbleTmpForRemove	
	SELECT l.UserID, CAST( CAST(NEWID() AS VARCHAR(40)) AS VARCHAR(20)), l.AID, 0, 0
	FROM
	(
		--SELECT a.AID
		SELECT na.*
		FROM Netma_Account a JOIN NetmarbleAccountInfo_20100224 na ON na.AID = a.AID AND na.UserID = a.UserID
		WHERE na.IsBreakUser IS NULL AND na.IsUser IS NULL AND na.ValidUserCN IS NULL AND na.RegDate IS NULL 
		-- 153277 �� ����� ���� �̻��ϴ�. �α��� �ð��� ����, �α� �ƿ� �ð��� ����.
		
		SELECT na.*
		FROM Netma_Account a JOIN NetmarbleAccountInfo_20100224 na ON na.AID = a.AID AND na.UserID = a.UserID
		WHERE na.IsBreakUser IS NULL AND na.IsUser IS NULL AND na.ValidUserCN IS NULL AND na.RegDate IS NULL
			AND a.LastLoginTime IS NULL -- 153277
			
		SELECT na.*
		FROM Netma_Account a JOIN NetmarbleAccountInfo_20100224 na ON na.AID = a.AID AND na.UserID = a.UserID
		WHERE na.IsBreakUser IS NULL AND na.IsUser IS NULL AND na.ValidUserCN IS NULL AND na.RegDate IS NULL
			AND a.LastLoginTime IS NULL AND a.LastLogoutTime IS NULL -- 144937
			
	) r, Netma_Login l
	WHERE r.AID = l.AID
	-- ��� : 928176��(������� ���� �Ǽ����� �ٸ� �� �ֽ��ϴ�) => AID�� UserID�� ��

-- �ϴ� Ż�� ��Ȯ�� ȸ���� ����־����� - Type 1
INSERT NetmarbleTmpForRemove	
	SELECT l.UserID, CAST( CAST(NEWID() AS VARCHAR(40)) AS VARCHAR(20)), l.AID, 0, 0
	FROM
	(
		SELECT a.AID
		FROM Netma_Account a JOIN NetmarbleAccountInfo_20100224 na ON na.AID = a.AID AND na.UserID = a.UserID
		WHERE na.IsBreakUser = 'Y' AND na.RegDate IS NULL 
	) r, Netma_Login l
	WHERE r.AID = l.AID
	-- ��� : 928176��(������� ���� �Ǽ����� �ٸ� �� �ֽ��ϴ�) => AID�� UserID�� ��

	
-- �ϴ� Ż�� ��Ȯ�� ȸ���� ����־����� - Type 2
INSERT NetmarbleTmpForRemove
	SELECT l.UserID, CAST( CAST(NEWID() AS VARCHAR(40)) AS VARCHAR(20)), l.AID, 0, 0
	FROM
	(
		SELECT a.AID
		FROM Netma_Account a JOIN NetmarbleAccountInfo_20100224 na ON na.AID = a.AID AND na.UserID = a.UserID
		WHERE na.RegDate IS NOT NULL AND na.RegDate > a.LastLogoutTime
	) r, Netma_Login l
	WHERE r.AID = l.AID	
	-- ��� : 69796��(������� ���� �Ǽ����� �ٸ� �� �ֽ��ϴ�) => AID�� UserID�� ��

============================================================================================	

-- ���� ����ߵ� ȸ������ ����־�����
INSERT NetmarbleTmpForUpdate
	SELECT l.UserID, l.AID, r.UserCN, r.ValidUserCN, 0, 0
	FROM
	(
		SELECT a.AID, na.UserCN, na.ValidUserCN
		FROM Netma_Account a JOIN NetmarbleAccountInfo_20100224 na ON na.AID = a.AID AND na.UserID = a.UserID
		WHERE na.RegDate IS NOT NULL AND na.RegDate < a.LastLogoutTime -- AND l.LastLogoutTime < '2010-01-25 10:00:00.0'
	) r, Netma_Login l
	WHERE r.AID = l.AID	
	-- ��� : 58872��, 18��(������� ���� �Ǽ����� �ٸ� �� �ֽ��ϴ�)
	

============================================================================================
	
CREATE NONCLUSTERED INDEX NetmarbleTmpForRemove_AID_IX	ON NetmarbleTmpForRemove(AID);
CREATE NONCLUSTERED INDEX NetmarbleTmpForUpdate_AID_IX	ON NetmarbleTmpForUpdate(AID);