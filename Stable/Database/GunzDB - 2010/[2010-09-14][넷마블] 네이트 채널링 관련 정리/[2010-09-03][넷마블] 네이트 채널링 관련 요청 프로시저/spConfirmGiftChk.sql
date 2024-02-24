USE GunzDB
GO

CREATE PROCEDURE dbo.SpConfirmGiftChk
-- ALTER PROCEDURE dbo.spConfirmGiftChk
	@CharName		VARCHAR(24)
	, @RetExist		INT			OUTPUT
	, @RetUserID	VARCHAR(20) OUTPUT
AS BEGIN
	SET NOCOUNT ON;
	
	DECLARE @AID INT;
	
	SELECT	@AID = AID
	FROM	Character(NOLOCK)
	WHERE	Name = @CharName
	AND		DeleteFlag = 0
	
	IF( @AID IS NOT NULL ) BEGIN
		SELECT	@RetExist = 1;
		
		SELECT	@RetUserID = UserID
		FROM	Account(NOLOCK)
		WHERE	AID = @AID
	END
	ELSE BEGIN
		SELECT	@RetExist = 0;
		SELECT	@RetUserID = NULL;
	END		
END

/*
  ���� ����  
  		
  -- ����		
		DECLARE @RetExist INT;
		DECLARE @RetUserID VARCHAR(20);
		EXEC spConfirmGiftChk '����_ȫ����', @RetExist OUTPUT, @RetUserID OUTPUT
		SELECT @RetExist, @RetUserID
		
  -- ������
		DECLARE @RetExist INT;
		DECLARE @RetUserID VARCHAR(20);
		EXEC spConfirmGiftChk '�ڳ�_ȫ����', @RetExist OUTPUT, @RetUserID OUTPUT
		SELECT @RetExist, @RetUserID
		
  -- ������
		DECLARE @RetExist INT;
		DECLARE @RetUserID VARCHAR(20);
		EXEC spConfirmGiftChk '', @RetExist OUTPUT, @RetUserID OUTPUT
		SELECT @RetExist, @RetUserID
*/