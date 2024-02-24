/* ===============================================================================
  �ǰ� �����Ǿ����� Ȯ���ϴ� ������
  
  -- �ϳ��ϳ� �����ϸ鼭 Ȯ���غ����� �սô�.
=============================================================================== */

--USE GunzDB
USE TGunzDB


--------------------------------------------------------------------------
-- Step 1 - ����(Ż��ȸ��) ���� ��� �����ϱ�
--------------------------------------------------------------------------
SELECT 	l.AID, l.UserID, l.Password
FROM 	TempDB_2.dbo.gunz_withdraw_filter gw(NOLOCK)
		, Login l(NOLOCK)
WHERE 	gw.cn = l.Password
AND		NOT EXISTS ( SELECT * FROM AccountDeleteTargetNotExist WHERE AID = l.AID )



--------------------------------------------------------------------------
-- Step 2 - ������(Ż�� ȸ��) ���� ��� �����ϱ�
--------------------------------------------------------------------------
SELECT 	l.AID, l.UserID, l.Password
FROM 	TempDB_2.dbo.gunz_baduser_withdraw_filter gw(NOLOCK)
		, Login l(NOLOCK)
WHERE 	gw.cn = l.Password
AND		NOT EXISTS ( SELECT * FROM AccountDeleteTargetNotExist WHERE AID = l.AID )



--------------------------------------------------------------------------
-- Step 3 - ������(���� ȸ��) ���� ��� �����ϱ�(������ ����� ���� �̻��� ID���� ����)
--------------------------------------------------------------------------
SELECT 	a.AID, t.UserID, a.UserID, t.cn
FROM 	Temp_baduser_nothing t
		, Account a(NOLOCK)
WHERE 	a.AID = t.AID
AND 	a.LastLogoutTime IS NULL
AND		a.UserID = t.UserID
AND		NOT EXISTS ( SELECT * FROM AccountDeleteTargetNotExist WHERE AID = a.AID )



--------------------------------------------------------------------------
-- Step 4 - ������(ȸ��) ���� ��� �����ϱ�
--------------------------------------------------------------------------
SELECT 	a.AID, t.UserID, a.UserID, t.cn
FROM 	Temp_baduser_active t
		, Account a(NOLOCK)
WHERE 	a.AID = t.AID
AND		a.UserID = t.UserID
AND		a.LastLogoutTime IS NULL
AND		NOT EXISTS ( SELECT * FROM AccountDeleteTargetNotExist WHERE AID = a.AID )

SELECT 	t.AID, t.UserID, t.cn
FROM 	Temp_baduser_active t(NOLOCK)
		, Account a(NOLOCK)
WHERE 	a.AID = t.AID
AND		a.UserID = t.UserID
AND		a.LastLogoutTime IS NOT NULL
AND		t.LastLogoutTime < t.RegDate
AND		NOT EXISTS ( SELECT * FROM AccountDeleteTargetNotExist WHERE AID = a.AID )

SELECT 	* 
FROM 	Temp_baduser_active gf(NOLOCK)
		, Login l(NOLOCK)		
WHERE 	gf.UserID = l.UserID
AND		gf.netmarble_cn != l.Password
AND 	gf.LastLogoutTime IS NOT NULL 
AND		gf.LastLogoutTime > gf.Regdate
AND		NOT EXISTS ( SELECT * FROM AccountDeleteTargetNotExist WHERE AID = l.AID )


--------------------------------------------------------------------------
-- Step 5 - ���� ����� �ƴϾ��� ���� ��� ó���ϱ�
-- �ƿ� Delete �ؾߵɲ� ������...
--------------------------------------------------------------------------
SELECT	*
FROM	AccountDeleteTargetNotExist t
		, Login l
WHERE	t.AID = l.AID

SELECT	*
FROM	AccountDeleteTargetNotExist t
		, Account a
WHERE	t.AID = a.AID

SELECT	*
FROM	AccountDeleteTargetNotExist t
		, Account a
WHERE	t.TableName = 'Login'
AND		t.AID = a.AID


--------------------------------------------------------------------------
-- Step 6 - UserCN�� Unique���� �˻��ϰ� �ε��� ������ֱ�
--------------------------------------------------------------------------
BEGIN TRAN --------
	SELECT	r.Count, l.*
	FROM	(	SELECT	l.Password, COUNT(l.Password) AS Count
				FROM	Login l(NOLOCK)
				WHERE	Password != ''
				GROUP BY l.Password HAVING COUNT(l.Password) > 1 ) r
			, Login l
	WHERE	r.Password = l.Password 

	UPDATE Login SET Password = '' WHERE Password IS NULL
	CREATE NONCLUSTERED INDEX Login_UserCN_IX ON Login(Password)


	-- Account ����!
	DECLARE @DeleteID VARCHAR(20);
	SET	@DeleteID = CAST( CAST(NEWID() AS VARCHAR(40)) AS VARCHAR(20));
	
	UPDATE	Login
	SET		UserID = @DeleteID, Password = ''
	WHERE	AID = 4848496	
		
	UPDATE	Account
	SET		UserID = @DeleteID, DeleteFlag = 1
	WHERE	AID = 4848496

COMMIT TRAN --------



--------------------------------------------------------------------------
-- Step 7 - �ݸ��� ������ ������ ����
--------------------------------------------------------------------------
SELECT 	t.AID, t.UserID, t.cn, a.LastLogoutTime
INTO	Baduser_Nothing_For_Netmarble
FROM 	Temp_baduser_nothing t(NOLOCK)
		, Account a(NOLOCK)
WHERE 	a.AID = t.AID
AND 	a.LastLogoutTime IS NOT NULL
ORDER BY t.AID
	

--------------------------------------------------------------------------
-- Step 6 - ���� ���̺� �����ϱ�
--------------------------------------------------------------------------
DROP TABLE Temp_baduser_active
DROP TABLE Temp_baduser_nothing



