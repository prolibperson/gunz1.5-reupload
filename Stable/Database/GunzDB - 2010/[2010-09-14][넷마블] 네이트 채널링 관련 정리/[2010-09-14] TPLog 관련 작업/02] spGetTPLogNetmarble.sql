USE GunzDB
GO

CREATE PROCEDURE dbo.spGetTPLogNetmarbleTemp	-- �׽�Ʈ�� ��.. �ӽ� ���ν�����..
--DROP PROCEDURE dbo.spGetTPLogNetmarbleTemp	-- �ӽ� ������ ��..
--ALTER PROCEDURE dbo.spGetTPLogNetmarble		-- �ᱹ�� Alter
	@StartDate DATETIME  
	, @EndDate DATETIME  
AS BEGIN  
	SET NOCOUNT ON;  
   
	SELECT	CONVERT(VARCHAR(8), StartDate, 112) AS Date  
			, Password AS CN  
			, UserID  AS UserID  
			, CharacName AS CharacName  
			, StartDate AS LoginDate  
			, EndDate AS LogoutDate  
			, PlayTime AS PlayTime  
			, IP AS IP
			, CCode AS CCode
	FROM TPLogNetmarble(NOLOCK)  
	WHERE StartDate BETWEEN @StartDate AND @EndDate  
END