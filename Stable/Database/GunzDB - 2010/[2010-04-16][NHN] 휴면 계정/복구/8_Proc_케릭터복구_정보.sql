USE GunzDB
GO

/*
    *******************************************************************************
        Notice 
    *******************************************************************************

     1. SleepCharacterNHN ���̺� AID���� Index�� �ɷ��ִٸ� �����ּ���.
       ������ �߸� ������ �� �����ϴ�.
       ( DROP INDEX IX_SleepCharacterNHN_AID )

     2. SleepCharacterNHN ���̺� CID���� Index�� ���ٸ� �������ּ���.
       ( CREATE INDEX IX_SleepCharacterNHN_CID ON dbo.SleepCharacterNHN(CID); )


*/


CREATE PROC dbo.spWebGetSleepCharacter_NHN
	@CID		INT
AS BEGIN
	SET NOCOUNT ON;	
	
	SELECT	t.AID
		  , t.CID
		  , t.Name
		  , -1 AS CharNum
		  , CASE WHEN EXISTS (SELECT Name FROM Character(NOLOCK) WHERE Name = t.Name) 
				 THEN 0 
				 ELSE 1 
			END AS NameUsed
	FROM	SleepCharacterNHN t(NOLOCK)
	WHERE	t.CID = @CID
END



