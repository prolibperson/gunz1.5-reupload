-- Account Delete �̷��� ����� ���̺��Դϴ�.

CREATE TABLE dbo.AccountDeleteLog
(
	AID					INT			NOT NULL,
	UserID				VARCHAR(20) NOT NULL,
	UserCN				VARCHAR(20) NOT NULL,
	DeleteID			VARCHAR(20) NOT NULL,
	DeleteDate			DATETIME	NOT NULL
	
	CONSTRAINT AccountDeleteLog_PK PRIMARY KEY CLUSTERED (AID DESC)
)

CREATE NONCLUSTERED INDEX AccountDeleteLog_UserID_IX ON dbo.AccountDeleteLog(UserID)
CREATE NONCLUSTERED INDEX AccountDeleteLog_DeleteID_IX ON dbo.AccountDeleteLog(DeleteID)


-- Account Delete�� ��û�ϴ� �̷��� ����� ���̺��Դϴ�.
CREATE TABLE dbo.AccountDeleteFailLog
(
	AID			INT			NOT NULL,
	TryDate		DATETIME	NOT NULL,
	ErrorCode	TINYINT		NOT NULL
	
	CONSTRAINT AccountDeleteFailLog_PK PRIMARY KEY CLUSTERED (AID DESC)
)