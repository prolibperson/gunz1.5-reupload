-- Account Delete�� ��û�ϴ� �̷��� ����� ���̺��Դϴ�.

CREATE TABLE dbo.AccountDeleteFailLog
(
	AID			INT			NOT NULL,
	TryDate		DATETIME	NOT NULL,
	ErrorCode	TINYINT		NOT NULL
	
	CONSTRAINT AccountDeleteFailLog_PK PRIMARY KEY CLUSTERED (AID DESC)
)