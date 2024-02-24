USE GunzDB
GO

-- �ϴ�, ������ spInsertPlayerLog�� ����Ѵ�.
EXEC sp_rename 'spInsertPlayerLog', 'BackUp_spInsertPlayerLog'
GO

-- ������ spInsertPlayerLog�� �����.
CREATE PROC [dbo].[spInsertPlayerLog]
-- ALTER PROC [dbo].[spInsertPlayerLog]
	@CID			INT
	, @PlayTime		INT
	, @Kills		INT
	, @Deaths		INT
	, @XP			INT
	, @TotalXP		INT
AS BEGIN

	SET NOCOUNT ON;  
  
	DECLARE @DisTime DATETIME;  
	SET @DisTime = GETDATE();  
	  
	INSERT INTO PlayerLog(CID, DisTime, PlayTime, Kills, Deaths, XP, TotalXP)  
	VALUES(@CID, @DisTime, @PlayTime, @Kills, @Deaths, @XP, @TotalXP)
	
	-- �Ʒ��� ��¥�� ������ �Ʒ��� ���� �κ��� ����������!
	IF( @DisTime BETWEEN '2010-12-01 00:00:00.0' AND '2011-01-06 00:00:00.0' ) 
	BEGIN
	
		EXEC spEventColiseum_UpdatePlayData @CID, @PlayTime, @Kills, @Deaths;
		
	END
END
