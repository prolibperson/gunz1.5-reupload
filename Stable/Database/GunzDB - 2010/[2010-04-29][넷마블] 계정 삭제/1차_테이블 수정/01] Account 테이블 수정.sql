/* ===============================================================================
  Account ���̺� �߰��� �ʿ��� �� ���� 'DeleteFlag' �ʵ带 �߰��ϴ� ������
  
  -- 1. �ʵ� �߰�
  -- 2. ����, ��� �ʵ带 0���� ������Ʈ
  -- 3. �̹� ������ �̷��� �ִ� ������ ���ؼ��� �ٽ� 1�� ������Ʈ �Ѵ�.
  -- 4. �α׿� ������ ������ ������ ������ ã�Ƽ� 1�� ������Ʈ �Ѵ�.
=============================================================================== */
BEGIN TRAN ----------
	ALTER TABLE Account ADD DeleteFlag TINYINT

	UPDATE Account SET DeleteFlag = 0

	UPDATE	a
	SET		a.DeleteFlag = 1
	FROM	Account a, AccountDeleteLog al
	WHERE	a.AID = al.AID
COMMIT TRAN ---------


-- �Ʒ��� ���������� ������ ������ ��������
-----------------------------------------------------------------------------------
/*
SELECT	* 
FROM	Account a
WHERE	a.UserID LIKE '%-%-%-%'
AND		NOT EXISTS ( SELECT * FROM AccountDeleteLog al where al.AID = a.AID )
*/
-----------------------------------------------------------------------------------
/*
UPDATE Account SET DeleteFlag = 1 WHERE AID = 2360246
UPDATE Account SET DeleteFlag = 1 WHERE AID = 5349799
UPDATE Account SET DeleteFlag = 1 WHERE AID = 5653342
UPDATE Account SET DeleteFlag = 1 WHERE AID = 5930447
UPDATE Account SET DeleteFlag = 1 WHERE AID = 5930514
*/