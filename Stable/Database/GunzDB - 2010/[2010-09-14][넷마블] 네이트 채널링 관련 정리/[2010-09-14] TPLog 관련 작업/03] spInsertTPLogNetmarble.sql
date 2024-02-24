USE GunzDB
GO

CREATE PROCEDURE dbo.spInsertTPLogNetmarbleTemp		-- �׽�Ʈ�� ��.. �ӽ� ���ν�����..
--DROP PROCEDURE spInsertTPLogNetmarbleTemp			-- �ӽ� ������ ��..
--ALTER PROCEDURE dbo.spInsertTPLogNetmarble		-- �ᱹ�� Alter
	@CID		INT  
	, @PlayTime INT  
	, @DisTime	DATETIME  
AS BEGIN  
	SET NOCOUNT ON;  
      
	INSERT INTO TPLogNetmarble  
		SELECT	DATEADD(ss, -@PlayTime, @DisTime) AS StartDate  
				, @DisTime AS EndDate  
				, a.UserID  
				, (SELECT Name FROM Character WITH (NOLOCK) WHERE CID = @CID) AS CharacName  
				, CAST(cl.IPPart1 AS VARCHAR(3)) + '.' + CAST(cl.IPPart2 AS VARCHAR(3)) + '.'   
					+ CAST(cl.IPPart3 AS VARCHAR(3)) + '.' + CAST(cl.IPPart4 AS VARCHAR(3))  
				, @PlayTime AS PlayTime  
				, l.Password
				, a.CCode
		FROM	Login l WITH (NOLOCK)
				, Account a WITH (NOLOCK)  
				, ( SELECT TOP 1 AID, IPPart1, IPPart2, IPPart3, IPPart4  
					FROM LogDB.dbo.ConnLog  
					WHERE AID IN (	SELECT	AID   
									FROM	Character(NOLOCK)  
									WHERE CID = @CID )  
					ORDER BY Time DESC) AS cl  
		WHERE	a.AID = cl.AID 
		AND		l.UserID = a.UserID;  
END