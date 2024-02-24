USE GunzDB
GO

ALTER PROCEDURE dbo.spFetchSurvivalRanking
AS
BEGIN
	SET NOCOUNT ON;
	
	BEGIN TRAN;
	
	------------------------------------------------------------------------------------------------------
	-- ���� SurvivalCharacterInfo ���̺��� tmpRP�� RP�� ������Ʈ�Ѵ�
	-- ��ŷ�� ����� ����� RP�� ��� �����Ѵ�.
	UPDATE	dbo.SurvivalCharacterInfo
	SET		tmpRP = RP;
	
	IF (0 <> @@ERROR)
	BEGIN
		ROLLBACK TRAN;
		RETURN;
	END
	
	-- �ӽ÷� ���̺��� �����(���� ��ŷ ���̺��� �� ���̺��̴�)
	CREATE TABLE dbo.tmpRanking(SID INT NOT NULL, RP INT NOT NULL, Ranking INT);	
	
	------------------------------------------------------------------------------------------------------
	
	DECLARE @nRank		INT
	DECLARE @nPreSID	INT
	DECLARE @nSID		INT
	DECLARE @nRP		INT
	DECLARE @nCount		INT
	
	-- Cursor�� �����Ѵ�. 
	-- Cursor�� SurvivalCharacterInfo ���̺��� SID, tmpRP ������ �����Ͽ�,
	-- SID, RP, �ߺ��� RP���� ���� �����.
	DECLARE Curs CURSOR FAST_FORWARD FOR 
	SELECT t.SID, t.RP, t.Cnt 
	FROM	
	(
		SELECT	SID, tmpRP AS RP, COUNT(tmpRP) AS Cnt	
		FROM	dbo.SurvivalCharacterInfo WITH (NOLOCK)
		WHERE	RP_LatestTime < CONVERT(CHAR, DATEADD(dd, 0, GETDATE()), 112)
		AND		DeleteFlag != 1
		GROUP BY SID, tmpRP
	) AS t
	ORDER BY t.SID ASC, t.RP DESC;
	
	-- Ŀ���� ����.. Fetch ����
	OPEN Curs
	FETCH NEXT FROM Curs INTO @nSID, @nRP, @nCount;

	SET @nRank = 1
	SET @nPreSID = @nSID	
				
	WHILE( @@FETCH_STATUS = 0 )
	BEGIN
		-- �ӽ� ���̺� ��� ����ִ´�.
		INSERT INTO tmpRanking(SID, RP, Ranking) VALUES (@nSID, @nRP, @nRank);
		IF (0 = @@ROWCOUNT OR 0 <> @@ERROR)
		BEGIN
			ROLLBACK TRAN;
			CLOSE Curs;
			DEALLOCATE Curs;
			RETURN;
		END
		
		SET @nRank = @nRank + @nCount 		
		FETCH NEXT FROM Curs INTO @nSID, @nRP, @nCount
		
		-- SID ���� �ٲ��(������ ���), ��ŷ�� �ٽ� 1���� ����Ѵ�.
		-- �ó��������� ��ŷ�� ����ؾ� �ȴ�.
		IF( @nPreSID < @nSID )
		BEGIN
			SET @nRank = 1
			SET @nPreSID = @nSID			
		END
	END
	
	CLOSE Curs
	DEALLOCATE Curs
	
	------------------------------------------------------------------------------------------------------
	
	-- Primary Key�� ������ �ð��� �̿��Ͽ�, �����.
	-- �Ʒ��� ���� ����� ������ ���̺��� Switch�� ��, Key�� ��ġ�� �ȵǱ� �����̴�.
	DECLARE @Date NVARCHAR(15);
	DECLARE @PKSQL NVARCHAR(512);
	DECLARE @IXSQL NVARCHAR(512);
	
	SET @Date = CAST(DATEDIFF(ss, '2009-06-09T00:00:00', GETDATE()) AS NVARCHAR(15));
	SET @PKSQL = N'ALTER TABLE tmpRanking ADD CONSTRAINT PK_SurvivalRanking_SID_RP_' + @Date + N' PRIMARY KEY (SID ASC, RP DESC);'	
	EXEC sp_executesql @PKSQL;
		
	-- ������ Index�� �̸��� �ٲ۴�. ������ tmpRP�� ���� RankRP�� �Ǳ� �����̴�.
	EXEC sp_rename 'SurvivalCharacterInfo.IX_SurvivalCharacterInfo_RankRP', 'IX_SurvivalCharacterInfo_tmpRP', 'INDEX';	
	
	-- ������ Index �̸��� �ٲ� ��, �ٽ� Index�� �����.
	CREATE NONCLUSTERED INDEX IX_SurvivalCharacterInfo_RankRP ON SurvivalCharacterInfo(tmpRP);
	
	-- Column�� Rename�Ѵ�.
	EXEC sp_rename 'SurvivalCharacterInfo.RankRP', 'tmpRP2', 'COLUMN';
	EXEC sp_rename 'SurvivalCharacterInfo.tmpRP', 'RankRP', 'COLUMN';
	EXEC sp_rename 'SurvivalCharacterInfo.tmpRP2', 'tmpRP', 'COLUMN';
	
	-- ������ Index�� �����Ѵ�.
	DROP INDEX dbo.SurvivalCharacterInfo.IX_SurvivalCharacterInfo_tmpRP;
		
	-- ������ Ranking ���̺��� �����ϰ� �ӽ� ���̺��� �̸��� �ٲ۴�.
	DROP TABLE dbo.SurvivalRanking;
	EXEC sp_rename 'tmpRanking', 'SurvivalRanking';
	
	
	------------------------------------------------------------------------------------------------------		
	TRUNCATE TABLE dbo.SurvivalCharacterInfoWeb;	
	INSERT INTO dbo.SurvivalCharacterInfoWeb(SID, CID)
		SELECT	SID, CID 
		FROM	dbo.SurvivalCharacterInfo WITH (NOLOCK)
		WHERE	RP_LatestTime < CONVERT(CHAR, DATEADD(dd, 0, GETDATE()), 112)
		AND		DeleteFlag != 1
		ORDER BY SID ASC, RankRP DESC
	------------------------------------------------------------------------------------------------------			
	
	COMMIT TRAN;
END
GO
