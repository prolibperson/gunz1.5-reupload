ALTER PROCEDURE dbo.spRemoveAccount_Netmarble
	@AID		INT,
	@Ret		INT OUTPUT
AS BEGIN
	SET NOCOUNT ON;
	
	DECLARE @SelUserID	VARCHAR(20);
	DECLARE @SelUserCN  VARCHAR(20);	
	DECLARE @DeleteID VARCHAR(20);	
	
	-- DELETE Step 1 - �̻��� ID�� �����
	SELECT @DeleteID = CAST( CAST(NEWID() AS VARCHAR(40)) AS VARCHAR(20))
	
	-- DELETE Step 2 - �̻��� ID���� �������� �Ǵ��ϱ�
	IF EXISTS (SELECT * FROM dbo.Login l WITH (NOLOCK) WHERE l.UserID = @DeleteID) 
	BEGIN
		SELECT @Ret = 1;				
		INSERT dbo.AccountDeleteFailLog VALUES(@AID, GETDATE(), 1);
		RETURN 
	END

	BEGIN TRAN
		
	-- DELETE Step 3 - �̻��� ID������ Account, Login�� �ִ� UserID Field�� �ٲ��ֱ�
	UPDATE dbo.Account SET UserID = @DeleteID WHERE AID = @AID;
	IF (0 <> @@ERROR) OR (0 = @@ROWCOUNT) BEGIN
		ROLLBACK TRAN
		SELECT @Ret = 2;
		
		INSERT dbo.AccountDeleteFailLog VALUES(@AID, GETDATE(), 2);
		RETURN 
	END
	
	UPDATE dbo.Login SET UserID = @DeleteID WHERE AID = @AID;
	IF (0 <> @@ERROR) OR (0 = @@ROWCOUNT) BEGIN
		ROLLBACK TRAN
		SELECT @Ret = 3;
		
		INSERT dbo.AccountDeleteFailLog VALUES(@AID, GETDATE(), 3);
		RETURN 
	END
	
	-- DELETE Step 4 - AccountDeleteLog �߰�!	
	SELECT @SelUserID = l.UserID, @SelUserCN = l.Password
	FROM dbo.Login l(NOLOCK) 
	WHERE l.AID = @AID
		
	INSERT INTO dbo.AccountDeleteLog VALUES(@AID, @SelUserID, @SelUserCN, @DeleteID, GETDATE());
	IF (0 <> @@ERROR) OR (0 = @@ROWCOUNT) BEGIN
		ROLLBACK TRAN
		SELECT @Ret = 4;
		
		INSERT dbo.AccountDeleteFailLog VALUES(@AID, GETDATE(), 4);
		RETURN 
	END
	
	COMMIT TRAN
	
	SELECT @Ret = 0;
END