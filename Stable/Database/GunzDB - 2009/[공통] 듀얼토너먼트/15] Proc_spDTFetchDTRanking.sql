ALTER PROCEDURE dbo.spDTFetchDTRanking	
AS BEGIN  

	SET NOCOUNT ON;

    ------------------------------------------------------------------------------------------------------------- 

	DECLARE @CurTimeStamp CHAR(8);  
	DECLARE @CurTimeStampIndex INT;
	
	DECLARE @PreTimeStamp CHAR(8);  
	DECLARE @PreTimeStampIndex INT;
			
	SELECT TOP 1 @CurTimeStamp = ts.TimeStamp, @CurTimeStampIndex = ts.ID  
	FROM DTTimeStamp ts WITH (NOLOCK)
	ORDER BY ts.TimeStamp DESC;
	
	SELECT @PreTimeStamp = TimeStamp 
	FROM DTTimeStamp 
	WHERE ID = @CurTimeStampIndex - 1;
	
	DECLARE @Closed TINYINT;
	SELECT @Closed = Closed FROM DTTimeStamp WHERE TimeStamp = @PreTimeStamp;

    ------------------------------------------------------------------------------------------------------------

	--������ TimeStamp�� ��ŷ ��굵 ������!
	IF( @Closed = 0 ) BEGIN	

		UPDATE DTTimeStamp SET Closed = Closed + 1 WHERE TimeStamp = @PreTimeStamp;
		
		-- �ϴ� ��ŷ ��� ���̺��� ��� �����͸� �����...  
		TRUNCATE TABLE DTCharacterRanking;		
		INSERT DTCharacterRanking(CID, TimeStamp, TP, FinalWins, Wins, Loses, PreGrade)  
			SELECT c.CID, c.TimeStamp, c.TP, c.FinalWins, c.Wins, c.Loses, c.PreGrade  
			FROM DTCharacterInfo c WITH (NOLOCK)  
			WHERE c.TimeStamp = @PreTimeStamp    
			ORDER BY c.TP DESC, c.FinalWins DESC, c.SFinalWins DESC, c.QFinalWins DESC, c.Wins DESC
			
		-- �����ʸ�Ʈ �ɸ��� ���� ������Ʈ ���ְ�..
		UPDATE ci  
		SET ci.RankingIncrease = CASE WHEN ci.Ranking = -1 THEN -1 ELSE ci.Ranking - cr.Rank END  
			, ci.Ranking  = cr.Rank
		FROM DTCharacterInfo ci JOIN DTCharacterRanking cr ON ci.CID = cr.CID  
		WHERE ci.CID = cr.CID AND ci.TimeStamp = @PreTimeStamp;  

		-- ��ŷ ��� ���̺� ��ŷ ����ġ�� �ٽ� ������Ʈ ���ش�.  
		UPDATE cr  
		SET cr.RankingIncrease = ci.RankingIncrease  
		FROM DTCharacterRanking cr JOIN DTCharacterInfo ci ON ci.CID = cr.CID  
		WHERE ci.CID = cr.CID AND ci.TimeStamp = @PreTimeStamp; 
		
		-- RankingHistory ���̺� ������ ����!
		DELETE DTCharacterRankingHistory WHERE TimeStamp = @PreTimeStamp;
		
		DECLARE @UserCount INT;
		SELECT @UserCount = COUNT(*) FROM DTCharacterInfo WHERE TimeStamp = @PreTimeStamp;
	
		UPDATE ci
		SET ci.PreGrade = CASE  WHEN (cr.TP <= 1000) THEN 10
					WHEN ((cr.Rank * 100) / @UserCount <= 4 )   THEN 1
					WHEN ((cr.Rank * 100) / @UserCount <= 11 )  THEN 2
					WHEN ((cr.Rank * 100) / @UserCount <= 23 )  THEN 3
					WHEN ((cr.Rank * 100) / @UserCount <= 40 )  THEN 4
					WHEN ((cr.Rank * 100) / @UserCount <= 60 )  THEN 5
					WHEN ((cr.Rank * 100) / @UserCount <= 77 )  THEN 6
					WHEN ((cr.Rank * 100) / @UserCount <= 89 )  THEN 7
					WHEN ((cr.Rank * 100) / @UserCount <= 96 )  THEN 8
					WHEN ((cr.Rank * 100) / @UserCount <= 100 ) THEN 9
					ELSE 10 END
		FROM DTCharacterInfo ci, DTCharacterRanking cr
		WHERE ci.TimeStamp = @CurTimeStamp 
			AND cr.TimeStamp = @PreTimeStamp
			AND ci.CID = cr.CID;
		
		INSERT DTCharacterRankingHistory(TimeStamp, Rank, CID, TP, FinalWins, Wins, Loses, Grade)
			SELECT TOP 100 cr.TimeStamp
						, cr.Rank
						, cr.CID
						, cr.TP
						, cr.FinalWins
						, cr.Wins
						, cr.Loses
						, CASE  WHEN (cr.TP <= 1000) THEN 10	
								WHEN (((cr.Rank * 100) / @UserCount) <= 4 )    THEN 1 
								WHEN (((cr.Rank * 100) / @UserCount) <= 11 )   THEN 2
								WHEN (((cr.Rank * 100) / @UserCount) <= 23 )   THEN 3 
								WHEN (((cr.Rank * 100) / @UserCount) <= 40 )   THEN 4 
								WHEN (((cr.Rank * 100) / @UserCount) <= 60 )   THEN 5 
								WHEN (((cr.Rank * 100) / @UserCount) <= 77 )   THEN 6 
								WHEN (((cr.Rank * 100) / @UserCount) <= 89 )   THEN 7 
								WHEN (((cr.Rank * 100) / @UserCount) <= 96 )   THEN 8 
								WHEN (((cr.Rank * 100) / @UserCount) <= 100 )  THEN 9 								
								ELSE 10 END		
			FROM DTCharacterRanking cr
			WHERE cr.TimeStamp = @PreTimeStamp
			ORDER BY cr.Rank;
	END
	   

------------------------------------------------------------------------------------------------------------
	-- �ϴ� ��ŷ ��� ���̺��� ��� �����͸� �����...  
	TRUNCATE TABLE DTCharacterRanking;
	   
	-- ��ŷ ��� ���̺� ��� ����ְ�..  
	INSERT DTCharacterRanking(CID, TimeStamp, TP, FinalWins, Wins, Loses, PreGrade)  
		SELECT c.CID, c.TimeStamp, c.TP, c.FinalWins, c.Wins, c.Loses, c.PreGrade  
		FROM DTCharacterInfo c WITH (NOLOCK)  
		WHERE c.TimeStamp = @CurTimeStamp    
		ORDER BY c.TP DESC, c.FinalWins DESC, c.SFinalWins DESC, c.QFinalWins DESC  
	    
	-- �����ʸ�Ʈ �ɸ��� ���� ������Ʈ ���ְ�..  
	UPDATE ci  
	SET ci.RankingIncrease = CASE WHEN ci.Ranking = -1 THEN 1000000000 ELSE ci.Ranking - cr.Rank END  
		, ci.Ranking = cr.Rank  
	FROM DTCharacterInfo ci JOIN DTCharacterRanking cr ON ci.CID = cr.CID  
	WHERE ci.CID = cr.CID AND ci.TimeStamp = @CurTimeStamp;  

	-- ��ŷ ��� ���̺� ��ŷ ����ġ�� �ٽ� ������Ʈ ���ش�.  
	UPDATE cr  
	SET cr.RankingIncrease = ci.RankingIncrease  
	FROM DTCharacterRanking cr JOIN DTCharacterInfo ci ON ci.CID = cr.CID  
	WHERE ci.CID = cr.CID AND ci.TimeStamp = @CurTimeStamp;  
------------------------------------------------------------------------------------------------------------
END
