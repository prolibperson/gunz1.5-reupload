-- 1. DuelTournament ��带 �÷����� ĳ������ �̸�(Ư�� �Ⱓ)
DECLARE @TimeStamp CHAR(8);
SET @TimeStamp = 'Ư���Ⱓ�Է�';

SELECT ci.TimeStamp, c.Name, ci.Wins, ci.Loses
FROM DTCharacterInfo ci(NOLOCK) JOIN Character c(NOLOCK) ON ci.CID = c.CID
WHERE ci.TimeStamp = @TimeStamp AND (ci.Wins > 0 OR ci.Loses > 0)



-- 2. DuelTournament ���� ����� Ƚ��(Ư�� �Ⱓ)
DECLARE @TimeStamp	CHAR(8);
DECLARE @Cnt		INT;

SET @TimeStamp  = 'Ư���Ⱓ�Է�';
SET @Cnt		= 'Ư��Ƚ���Է�';

SELECT ci.TimeStamp, c.Name, ci.FinalWins
FROM DTCharacterInfo ci(NOLOCK) JOIN Character c(NOLOCK) ON ci.CID = c.CID
WHERE ci.TimeStamp = @TimeStamp AND ci.FinalWins >= @Cnt
