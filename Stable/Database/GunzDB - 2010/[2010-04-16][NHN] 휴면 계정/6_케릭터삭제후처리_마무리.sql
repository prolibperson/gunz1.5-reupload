USE GunzDB
GO

--------------------------------------------------------------------------------------------------------
-- ����) �������鿡 '20100506'�� ������ �����ϴ� ������ ��¥�� �ٲ��ش�.
--      ��¥�� ���Ͽ� ���� �� �ɸ��͸� �����ϰ� ó���Ѵ�.
--		��) CAST('20100506' AS DATETIME) -> CAST(���糯¥ AS DATETIME)
--------------------------------------------------------------------------------------------------------
BEGIN TRAN ------------

	INSERT INTO dbo.CharacterMakingLog(AID, CharName, Type, Date)
		SELECT	t.AID, t.Name, 'Deleteted', GETDATE()
		FROM	dbo.SleepCharacterNHN t(NOLOCK)
		WHERE	t.RegDt = CAST('20100506' AS DATETIME);
	
COMMIT TRAN ------------
GO