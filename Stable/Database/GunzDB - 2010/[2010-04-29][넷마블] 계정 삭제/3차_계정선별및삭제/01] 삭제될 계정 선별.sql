/* ===============================================================================
  �ݸ����� �������� �����͸� ���� ������ ������ ����� �����ϴ� ������
  
  -- 1. �ݸ����� �������� �����͸� ����
  -- 2. ������ ������ ����� �����ϴ� ���̺� ����
  -- 3. ������ ���� ���� - Ż�� Ȯ���� ȸ���� �����ϱ�
  -- 4. ���� �Ǿ�� �� ���� �������ֱ�(������ �ƴ� UserCN ����)
  -- 5. ���� ����� �ߺ� ���� �� DeleteID ����
=============================================================================== */

--USE GunzDB
USE TGunzDB


--------------------------------------------------------------------------
-- �ݸ����� �������� �����͸� ����
--------------------------------------------------------------------------
BEGIN TRAN ---------
	--------------------------------------------------------------------------
	-- �ߺ��� ���� �����ϴ� �κ�
	-- �ݸ��� Ż�� DB�� �ߺ��� �ڷᰡ �ִ� �� �����ϴ�.
	--------------------------------------------------------------------------
	SELECT DISTINCT * INTO TempDB_2.dbo.gunz_withdraw_filter 		 FROM TempDB_2.dbo.gunz_withdraw 
	SELECT DISTINCT * INTO TempDB_2.dbo.gunz_baduser_withdraw_filter FROM TempDB_2.dbo.gunz_baduser_withdraw
	SELECT DISTINCT * INTO TempDB_2.dbo.gunz_baduser_nothing_filter	 FROM TempDB_2.dbo.gunz_baduser_nothing
	SELECT DISTINCT * INTO TempDB_2.dbo.gunz_baduser_active_filter 	 FROM TempDB_2.dbo.gunz_baduser_active
COMMIT TRAN --------
GO



--------------------------------------------------------------------------
-- ������ ������ ����� �����ϴ� ���̺� ����
--------------------------------------------------------------------------
BEGIN TRAN ---------
	--------------------------------------------------------------------------
	-- ������ ���� ����� �����ϰ�, Delete ID�� ���� ���̺�
	-- ��� ���� ��, �ߺ��� ����� �־ 2���� ����!
	--------------------------------------------------------------------------
	CREATE TABLE dbo.AccountDeleteTargetTemp
	(
		AID					INT				NOT NULL,
		UserID				VARCHAR(20) 	NOT NULL,
		UserCN				VARCHAR(20) 	NOT NULL,
		DeleteID			VARCHAR(20)		NULL
	)

	CREATE TABLE dbo.AccountDeleteTarget
	(
		AID					INT				NOT NULL,
		UserID				VARCHAR(20) 	NOT NULL,
		UserCN				VARCHAR(20) 	NOT NULL,
		DeleteID			VARCHAR(20)		NULL
	)	
COMMIT TRAN --------
GO



--------------------------------------------------------------------------
-- ������ ���� ���� - Ż�� Ȯ���� ȸ���� �����ϱ�
--------------------------------------------------------------------------
BEGIN TRAN ---------	
	CREATE NONCLUSTERED INDEX Login_UserCN_IX ON Login(Password)
	
	--------------------------------------------------------------------------
	-- Step 1 - ����(Ż��ȸ��) ���� ��� �����ϱ�
	--------------------------------------------------------------------------
	INSERT INTO dbo.AccountDeleteTargetTemp(AID, UserID, UserCN)
		SELECT 	l.AID, l.UserID, l.Password
		FROM 	TempDB_2.dbo.gunz_withdraw_filter gw(NOLOCK)
				, Login l(NOLOCK)
		WHERE 	gw.cn = l.Password

	--------------------------------------------------------------------------
	-- Step 2 - ������(Ż�� ȸ��) ���� ��� �����ϱ�
	--------------------------------------------------------------------------
	INSERT INTO dbo.AccountDeleteTargetTemp(AID, UserID, UserCN)
		SELECT 	DISTINCT l.AID, l.UserID, l.Password
		FROM 	TempDB_2.dbo.gunz_baduser_withdraw_filter gw(NOLOCK)
				, Login l(NOLOCK)
		WHERE 	gw.cn = l.Password

	DROP INDEX Login.Login_UserCN_IX
COMMIT TRAN --------
GO




--------------------------------------------------------------------------
-- ������ ���� ���� - ���������� ȸ���� �����ϱ�
--------------------------------------------------------------------------
BEGIN TRAN ---------

	------------------------------------------------------------------------------
	-- Step 1 - ������(���� ȸ��) - ���� ��� �����ϱ�(������ ����� ���� �̻��� ID���� ����)
	------------------------------------------------------------------------------
	-- �ϴ� �ӽ� ���̺��� �ϳ� ����
	SELECT 	*
	INTO	Temp_baduser_nothing
	FROM 	TempDB_2.dbo.gunz_baduser_nothing_filter gw(NOLOCK)
			, Login l(NOLOCK)
	WHERE 	gw.id = l.UserID

	-- ������ ���� ���� ����鵵 ���� ���
	-- (������ ����� �ִ� ��쵵 ���� -> ���� �ٽ� ó��)
	INSERT INTO dbo.AccountDeleteTargetTemp(AID, UserID, UserCN)
		SELECT 	t.AID, t.UserID, t.cn
		FROM 	Temp_baduser_nothing t
				, Account a(NOLOCK)
		WHERE 	a.AID = t.AID
		AND 	a.LastLogoutTime IS NULL
		
		
	--------------------------------------------------------------------------
	-- Step 2 - ������(ȸ��) - ���� ��� �����ϱ�
	--------------------------------------------------------------------------
	-- �ϴ� �ӽ� ���̺��� �ϳ� ����
	SELECT 	a.AID, a.UserID, g.cn, g.netmarble_cn, g.RegDate, a.LastLogoutTime
	INTO 	Temp_baduser_active
	FROM	TempDB_2.dbo.gunz_baduser_active_filter g(NOLOCK)
			, Account a(NOLOCK)
	WHERE	a.UserID = g.id


	-- �α����� �� ���� ȸ���� ����!
	INSERT INTO dbo.AccountDeleteTargetTemp(AID, UserID, UserCN)
		SELECT 	t.AID, t.UserID, t.cn
		FROM 	Temp_baduser_active t(NOLOCK)
		WHERE 	t.LastLogoutTime IS NULL


	-- ������ ������ ��� �ð� < �ݸ��� ���̵� ���� ��¥ 
	-- = �簡���� ȸ���� ������ ��� ���� ����
	INSERT INTO dbo.AccountDeleteTargetTemp(AID, UserID, UserCN)
		SELECT 	t.AID, t.UserID, t.cn
		FROM 	Temp_baduser_active t(NOLOCK)
		WHERE 	t.LastLogoutTime IS NOT NULL
		AND		t.LastLogoutTime < t.RegDate

COMMIT TRAN --------
GO




--------------------------------------------------------------------------
-- ���� �Ǿ�� �� ���� �������ֱ�(������ �ƴ� UserCN ����)
--------------------------------------------------------------------------
BEGIN TRAN ---------

	-- ������ ������ ��� �ð� > �ݸ��� ���̵� ���� ��¥ 
	-- (�簡���� ȸ���� ���� ������ ���� ����)
	UPDATE	l
	SET		l.Password = gf.netmarble_cn
	FROM 	Temp_baduser_active gf(NOLOCK)
			, Login l
	WHERE 	gf.UserID = l.UserID
	AND		gf.netmarble_cn != l.Password
	AND 	gf.LastLogoutTime IS NOT NULL 
	AND		gf.LastLogoutTime > gf.Regdate
	
COMMIT TRAN --------
GO




--------------------------------------------------------------------------
-- ���� ����� �ߺ� ���� �� DeleteID ����
--------------------------------------------------------------------------
BEGIN TRAN ---------	

	INSERT dbo.AccountDeleteTarget(AID, UserID, UserCN, DeleteID)
		SELECT DISTINCT AID, UserID, UserCN
		FROM dbo.AccountDeleteTargetTemp(NOLOCK)	

	UPDATE	AccountDeleteTarget
	SET		DeleteID = CAST( CAST(NEWID() AS VARCHAR(40)) AS VARCHAR(20))

	CREATE NONCLUSTERED INDEX AccountDeleteTarget_AID_IX ON AccountDeleteTarget(AID)

	DROP TABLE AccountDeleteTargetTemp
	
	/*
	SELECT	COUNT(*)
	FROM	AccountDeleteTarget t(NOLOCK)
			, AccountDeleteLog l(NOLOCK)
	WHERE	l.DeleteID = t.DeleteID
	*/
COMMIT TRAN --------
GO