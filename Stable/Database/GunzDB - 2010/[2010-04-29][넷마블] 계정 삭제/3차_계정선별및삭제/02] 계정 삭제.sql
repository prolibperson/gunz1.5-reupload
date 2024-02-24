/* ===============================================================================
  ������ ������ �������ִ� ����
  
  -- 1. ������ ���� �߿����� �̻��� �༮�� ã��
  -- 2. ���� ���� �� �α� �����
=============================================================================== */

--USE GunzdB
USE TGunzDB
GO




---------------------------------------------------------------------------------
-- ������ ���� �߿����� �̻��� �༮�� ã��
-- (Login�� Account Table���� �����Ͱ� �� ���� ���� ����)
---------------------------------------------------------------------------------
BEGIN TRAN -------------

	-- �������� Ÿ�� �߿�, Account ���̺� �������� �ʴ� �༮��..	
	SELECT	t.AID, t.UserID, t.UserCN, t.DeleteID, 'Login' AS TableName
	INTO	AccountDeleteTargetNotExist
	FROM	AccountDeleteTarget t(NOLOCK)
	WHERE	NOT EXISTS( SELECT * FROM Account a(NOLOCK) WHERE a.AID = t.AID )

	-- �������� Ÿ�� �߿�, Login ���̺� �������� �ʴ� �༮��..
	INSERT INTO AccountDeleteTargetNotExist(AID, UserID, UserCN, DeleteID, TableName)
		SELECT	t.AID, t.UserID, t.UserCN, t.DeleteID, 'Account' AS TableName
		FROM	AccountDeleteTarget t(NOLOCK)
		WHERE	NOT EXISTS( SELECT * FROM Login l(NOLOCK) WHERE l.AID = t.AID )		
		
		
	-- �������� �ʴ� �༮���� Ÿ�ٿ��� ���ܽ�Ų��.
	DELETE	at
	FROM	AccountDeleteTarget at, AccountDeleteTargetNotExist an
	WHERE	at.AID = an.AID
	
	SELECT * FROM AccountDeleteTargetNotExist

COMMIT TRAN -------------
GO	




---------------------------------------------------------------------------------
-- ���� ���� �� �α� �����
---------------------------------------------------------------------------------
BEGIN TRAN -------------

	-- Account ���õǾ� ��ȭ�� ���� �ε����� �����ּ���!
	EXEC sp_helpindex Account
	-- DROP INDEX dbo.Account.IX_Account_UserID
	-- DROP INDEX dbo.Account.CUK_Account_UserID

	-- Account ����!			
	UPDATE	a
	SET		a.UserID = t.DeleteID, a.DeleteFlag = 1
	FROM	Account a, AccountDeleteTarget t
	WHERE	a.AID = t.AID
			
	
	-- Login ���õǾ� ��ȭ�� ���� �ε����� �����ּ���!
	EXEC sp_helpindex Login
	-- DROP INDEX dbo.Login.CUK_Login_UserID	
	
	-- Login ����!
	UPDATE	l
	SET		l.UserID = t.DeleteID, l.Password = ''
	FROM	Login l, AccountDeleteTarget t
	WHERE	l.AID = t.AID
		
	-- ������ �ε��� �����!
	-- CREATE UNIQUE NONCLUSTERED INDEX UIX_Account_UserID ON Account(UserID)	
	-- CREATE NONCLUSTERED INDEX IX_Account_DeleteFlag ON Account(DeleteFlag)



	-- ���� �α׿� �����!
	DROP INDEX AccountDeleteLog.AccountDeleteLog_UserID_IX
	
	INSERT INTO dbo.AccountDeleteLog(AID, UserID, UserCN, DeleteID, DeleteDate)
		SELECT	AID, UserID, UserCN, DeleteID, GETDATE()
		FROM	AccountDeleteTarget(NOLOCK)
		
	CREATE INDEX AccountDeleteLog_UserID_IX ON AccountDeleteLog(UserID)	
	
COMMIT TRAN ------------
GO
