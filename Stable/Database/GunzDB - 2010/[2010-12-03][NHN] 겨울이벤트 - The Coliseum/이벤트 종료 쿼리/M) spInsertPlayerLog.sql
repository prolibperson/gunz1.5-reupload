
-- ���� ������� spInsertPlayerLog�� �����Ѵ�.
DROP PROC spInsertPlayerLog;

-- �ϴ�, ����� ������ BackUp_spInsertPlayerLog�� �̸��� �ٲ��ش�.
EXEC sp_rename 'BackUp_spInsertPlayerLog', 'spInsertPlayerLog'
GO