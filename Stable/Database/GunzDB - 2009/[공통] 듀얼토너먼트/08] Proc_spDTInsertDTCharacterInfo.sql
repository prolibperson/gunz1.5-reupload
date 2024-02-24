ALTER PROCEDURE dbo.spDTInsertDTCharacterInfo  
	@CID INT  
AS BEGIN  
	SET NOCOUNT ON;
	
	DECLARE @BasicTP INT;		
	DECLARE @TimeStampIndex INT;
	DECLARE @TimeStamp CHAR(8);	
	
	SET @BasicTP = 1000;
	
	SELECT TOP 1 @TimeStampIndex = ts.ID, @TimeStamp = ts.TimeStamp 
	FROM DTTimeStamp ts WITH (NOLOCK) 
	ORDER BY TimeStamp DESC;
	
	----------------------------------------------------------------------------------
	-- ���� ��ŷ�� ���� Grade ���ϱ�	
	--  1��� ���� 4%,  2��� ���� 11%, 3��� ���� 23%, 4��� ���� 40%,  5��� ���� 60% 
	--	6��� ���� 77%,	7��� ���� 89%,	8��� ���� 96%,	9��� ���� 100%, 10��� ���� õ������
	
	DECLARE @Grade INT;	
	DECLARE @PreTP INT;
	DECLARE @PreRank INT;
	DECLARE @TotalUser INT;
	DECLARE @PreTimeStamp CHAR(8);	
	
	SELECT @PreTimeStamp = ts.TimeStamp, @TotalUser = ts.TotalUser 
	FROM DTTimeStamp ts WITH (NOLOCK) 
	WHERE ts.ID = @TimeStampIndex - 1 AND ts.TimeStamp < @TimeStamp;
	
	SELECT @PreRank = ci.Ranking, @PreTP = ci.TP
	FROM DTCharacterInfo ci WITH (NOLOCK) 
	WHERE ci.CID = @CID AND ci.TimeStamp = @PreTimeStamp;

	IF( @PreRank IS NOT NULL AND @TotalUser IS NOT NULL) BEGIN
		IF( @PreTP <= 1000 ) SET @Grade = 10;
		ELSE BEGIN
			SET @Grade = (@PreRank * 100) / @TotalUser;
			IF( @Grade <= 4 )			SET @Grade = 1;
			ELSE IF( @Grade <= 11 )		SET @Grade = 2;
			ELSE IF( @Grade <= 23 )		SET @Grade = 3;
			ELSE IF( @Grade <= 40 )		SET @Grade = 4;
			ELSE IF( @Grade <= 60 )		SET @Grade = 5;
			ELSE IF( @Grade <= 77 )		SET @Grade = 6;
			ELSE IF( @Grade <= 89 )		SET @Grade = 7;
			ELSE IF( @Grade <= 96 )		SET @Grade = 8;
			ELSE IF( @Grade <= 100 )	SET @Grade = 9;			
		END
	END	
	ELSE SET @Grade = 10;
----------------------------------------------------------------------------------

	INSERT INTO DTCharacterInfo   
	VALUES(@TimeStamp, @CID, @BasicTP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, @Grade);	
END