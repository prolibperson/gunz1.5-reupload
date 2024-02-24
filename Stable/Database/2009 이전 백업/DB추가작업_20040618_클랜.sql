-- Ŭ�� ���̺�
CREATE TABLE "Clan"
(
	"CLID"			int identity not null,
	"Name"			varchar(24) null,
	"Exp"			int not null DEFAULT 0,
	"Level"			tinyint not null DEFAULT 1,
	"Point"			int not null DEFAULT 1000,
	"MasterCID"		int null,
	"Wins"			int not null DEFAULT 0,
	"Loses"			int not null DEFAULT 0,
	"MarkWebImg"	varchar(48) null,
	"Introduction"	text null,
	"RegDate"		datetime not null,
	"DeleteFlag"	tinyint DEFAULT 0,		-- 1-������, 2-����������
	"DeleteName"	varchar(24) null

)
go

ALTER TABLE "Clan"
	ADD CONSTRAINT "Clan_PK" primary key ("CLID")
go

ALTER TABLE "Clan"
	ADD CONSTRAINT "Clan_Character_FK1" foreign key ("MasterCID")
	REFERENCES "Character" ("CID") ON UPDATE NO ACTION ON DELETE NO ACTION
Go

CREATE INDEX "IX_Clan_DeleteFlag" ON "Clan" ("DeleteFlag")
Go

CREATE INDEX "IX_Clan_Name" ON "Clan" ("Name")
Go


-- Ŭ�� ��� ���̺�
CREATE TABLE "ClanMember"
(
	"CMID"		int identity not null,
	"CLID"		int null,
	"CID"		int null UNIQUE,
	"Grade"		tinyint not null,
	"RegDate"	datetime not null
)
go


ALTER TABLE "ClanMember"
	ADD CONSTRAINT "ClanMember_PK" primary key ("CMID")
go



ALTER TABLE "ClanMember"
	ADD CONSTRAINT "ClanMember_Clan_FK1" foreign key ("CLID")
	REFERENCES "Clan" ("CLID") ON UPDATE NO ACTION ON DELETE NO ACTION
Go

ALTER TABLE "ClanMember"
	ADD CONSTRAINT "ClanMember_Clan_FK2" foreign key ("CID")
	REFERENCES "Character" ("CID") ON UPDATE NO ACTION ON DELETE NO ACTION
Go


CREATE INDEX "IX_ClanMember_CLID" ON "ClanMember" ("CLID")
Go

CREATE INDEX "IX_ClanMember_CID" ON "ClanMember" ("CID")
Go





-- sp---------------------------------------------------------------------------------------------

-- Ŭ�� �����ϱ�
CREATE PROC [spCreateClan]
	@ClanName		varchar(24),
	@MasterCID		int,
	@Member1CID		int,
	@Member2CID		int,
	@Member3CID		int,
	@Member4CID		int
AS
	DECLARE @NewCLID	int

	-- Ŭ���̸��� �ߺ����� �˻��ؾ��Ѵ�.
	SELECT @NewCLID=CLID FROM Clan WHERE Name=@ClanName

	IF @NewCLID IS NOT NULL
	BEGIN
		SELECT 0 AS Ret, 0 AS NewCLID
		RETURN
	END


	DECLARE @CNT		int

	-- Ŭ������ ��� ���� �������� �˻��ؾ��Ѵ�.
	SELECT @CNT = COUNT(*) FROM ClanMember cm, Character c WHERE ((cm.CID=@MasterCID) OR (cm.CID=@Member1CID) OR (cm.CID=@Member2CID) OR (cm.CID=@Member3CID) OR
(cm.CID=@Member4CID) ) AND cm.CID=c.CID AND c.DeleteFlag=0

	IF @CNT != 0
	BEGIN
		SELECT 0 AS Ret, 0 AS NewCLID
		RETURN
	END


	-- Ŭ�� ����
	INSERT INTO Clan (Name, MasterCID, RegDate) VALUES (@ClanName, @MasterCID, GETDATE())

	SELECT @NewCLID = @@IDENTITY
	IF (@NewCLID IS not NULL)
	BEGIN
		-- Ŭ���� ����
		INSERT INTO ClanMember (CLID, CID, Grade, RegDate) VALUES (@NewCLID, @MasterCID, 1, GETDATE())
		INSERT INTO ClanMember (CLID, CID, Grade, RegDate) VALUES (@NewCLID, @Member1CID, 9, GETDATE())
		INSERT INTO ClanMember (CLID, CID, Grade, RegDate) VALUES (@NewCLID, @Member2CID, 9, GETDATE())
		INSERT INTO ClanMember (CLID, CID, Grade, RegDate) VALUES (@NewCLID, @Member3CID, 9, GETDATE())
		INSERT INTO ClanMember (CLID, CID, Grade, RegDate) VALUES (@NewCLID, @Member4CID, 9, GETDATE())
	END

	-- ������ �ٿ�Ƽ ����
	--UPDATE Character SET BP=BP-1000 WHERE CID=@MasterCID


	SELECT 1 AS Ret, @NewCLID AS NewCLID
Go



-- Ŭ���� �����ϴ��� Ȯ���ϱ�
CREATE PROC [spConfirmExistClan]
	@ClanName		varchar(24)
AS
	SELECT COUNT(*) FROM Clan WHERE Name=@ClanName

Go

-- Ŭ�� �����ϱ�
CREATE PROC [spDeleteClan]
	@CLID		int,
	@ClanName	varchar(24)

AS
	-- Ŭ���� ��� ����
	DELETE FROM ClanMember WHERE CLID=@CLID

	-- Ŭ�� ����
	UPDATE Clan SET Name=NULL, DeleteFlag=1, DeleteName=@ClanName WHERE CLID=@CLID

Go

-- Ŭ�� ��� �����ϱ�
CREATE PROC [spReserveCloseClan]
	@CLID		int,
	@ClanName	varchar(24),
	@MasterCID	int
AS
	UPDATE Clan SET DeleteFlag=2 WHERE CLID=@CLID AND Name=@ClanName AND MasterCID=@MasterCID

Go



-- ��� �߰�
CREATE PROC [spAddClanMember]
	@CLID		int,
	@CID		int,
	@Grade		tinyint
AS
	-- Ŭ���� �����ϴ��� üũ
	DECLARE @varClanCount		int

	SELECT @varClanCount=COUNT(*) FROM Clan(nolock) WHERE CLID=@CLID AND ((DeleteFlag IS NULL) OR (DeleteFlag=0))
	IF (@varClanCount = 0)
	BEGIN
		SELECT 0 AS Ret
		return (-1)
	END

	-- Ŭ������ üũ
	DECLARE @MemberCount		int

	SELECT @MemberCount=COUNT(*) FROM ClanMember(nolock) WHERE CLID=@CLID
	IF @MemberCount >= 64	-- �ִ� 64����� ����
	BEGIN
		SELECT 0 AS Ret
		return (-1)
	END

	INSERT INTO ClanMember (CLID, CID, Grade, RegDate) VALUES (@CLID, @CID, @Grade, GETDATE())
	SELECT 1 AS Ret
Go



-- ��� ����
CREATE PROC [spRemoveClanMember]
	@CLID		int,
	@CID		int
AS
	DELETE FROM ClanMember WHERE (CLID=@CLID) AND (CID=@CID) AND (Grade != 1)
Go

-- ��� �̸����� ��� ����
CREATE PROC [spRemoveClanMemberFromCharName]
	@CLID				int,
	@AdminGrade			int,		-- Ż���Ű���� �ϴ� ����� ����
	@MemberCharName		varchar(36)
AS
	DECLARE @CID				int
	DECLARE @MemberGrade		int


	SELECT @CID=c.cid, @MemberGrade=cm.Grade FROM Character c(nolock), ClanMember cm(nolock)
	WHERE cm.clid=@CLID AND c.cid=cm.cid AND c.Name=@MemberCharName AND (DeleteFlag=0)

	IF (@CID IS NULL)
	BEGIN
		SELECT 0 As Ret
		return (-1)
	END

	IF @AdminGrade >= @MemberGrade
	BEGIN
		SELECT 2 As Ret
		return (-1)
	END


	IF @CID IS NOT NULL
	BEGIN
		DELETE FROM ClanMember WHERE (CLID=@CLID) AND (CID=@CID) AND (Grade != 1)
		SELECT 1 As Ret
	END

/* Ret�� ���� : 1 - ����, 0 - �ش�Ŭ������ ����. , 2 - ������ ���� �ʴ�. */
Go


-- ���� ����
CREATE PROC [spUpdateClanGrade]
	@CLID		int,
	@CID		int,
	@NewGrade	tinyint
AS
	UPDATE ClanMember SET Grade=@NewGrade WHERE CLID=@CLID AND CID=@CID
Go

/*
-- ������ ����
CREATE PROC [spAppointNewClanMaster]
	@CLID			int,
	@MasterCID		int
AS
	UPDATE Clan SET MasterCID=@MasterCID WHERE CLID=@CLID
Go
*/

-- Ŭ���̸� �˾ƿ���
CREATE PROC [spGetCharClan]
	@CID			int
AS
	SELECT cl.CLID AS CLID, cl.Name AS ClanName FROM ClanMember cm(nolock), Clan cl(nolock) WHERE cm.cid=@CID AND cm.CLID=cl.CLID
Go

-- Ŭ���̸����� CLID�˾ƿ���
CREATE PROC [spGetCLIDFromClanName]
	@ClanName		varchar(24)
AS
	SELECT CLID FROM Clan WHERE Name=@ClanName
Go



-- Ŭ���� �˾ƿ���
CREATE PROC [spGetClanMember]
	@CLID		int
AS
	SELECT cm.clid AS CLID, cm.Grade AS ClanGrade, c.cid AS CID, c.name AS CharName
	FROM ClanMember cm(nolock), Character c(nolock)
	WHERE CLID=@CLID AND cm.cid=c.cid
Go



-- ĳ���� �̸� ����
CREATE PROC [spChangeCharName]
	@AID		int,
	@CID		int,
	@NewName	varchar(24)
AS

IF (LEN(@NewName) <= 0) OR (LEN(@NewName) > 12)
BEGIN
	SELECT 0 AS Ret
END

IF EXISTS (SELECT TOP 1 CID FROM Character where (Name=@NewName) AND (DeleteFlag=0))
BEGIN
	SELECT 0 AS Ret
	return (-1)
END

UPDATE Character SET Name=@NewName WHERE AID=@AID AND CID=@CID

SELECT 1 AS Ret

Go


-- ĳ���� �̸� �ߺ� �˻�
CREATE PROC [spIsExistCharName]
	@CharName	varchar(24)
AS

IF EXISTS (SELECT TOP 1 CID FROM Character(nolock) where (Name=@CharName) AND (DeleteFlag=0))
BEGIN
	SELECT 1 AS Ret
END
ELSE
BEGIN
	SELECT 0 AS Ret
END

Go





-- ���������� ���� 7�ÿ� ������Ʈ���ִ� Ŭ�� ���
CREATE PROC [spRegularUpdateDeleteClan]
AS

BEGIN TRAN -------------

DECLARE curDeleteClan INSENSITIVE CURSOR
FOR
	SELECT CLID FROM Clan WHERE DeleteFlag=2
FOR READ ONLY

OPEN curDeleteClan

DECLARE @varCLID int
DECLARE @varClanName	varchar(32)
DECLARE @sql varchar(100)


FETCH FROM curDeleteClan INTO @varCLID

WHILE @@FETCH_STATUS = 0
BEGIN
	-- Ŭ���� ����
	SELECT @sql = 'DELETE FROM ClanMember WHERE CLID=' + CONVERT(varchar(16), @varCLID)
	--SELECT @sql
	EXEC(@sql)

	SELECT @varClanName=Name FROM Clan WHERE CLID=@varCLID

	-- Ŭ�� ����
	SELECT @sql = 'UPDATE Clan SET Name=NULL, MasterCID=NULL, DeleteFlag=1, DeleteName=''' + @varClanName + ''' WHERE CLID=' + CONVERT(varchar(16), @varCLID)
	--SELECT @sql
	EXEC(@sql)

	FETCH FROM curDeleteClan INTO @varCLID
END

CLOSE curDeleteClan
DEALLOCATE curDeleteClan

COMMIT TRAN -----------

Go





--- ������ �͵� -------------------------------------------
/* ĳ���� ���� �������� */
CREATE PROC [spGetCharInfoByCharNum]
	@AID		int
,	@CharNum	smallint
AS

DECLARE @CID		int
DECLARE @CLID		int
DECLARE @ClanName	varchar(24)
DECLARE @ClanGrade	int

SELECT @CID=CID FROM Character WITH (nolock) WHERE AID=@AID and CharNum=@CharNum
SELECT @CLID=cl.CLID, @ClanName=cl.Name, @ClanGrade=cm.Grade FROM ClanMember cm(nolock), Clan cl(nolock) WHERE cm.cid=@CID AND cm.CLID=cl.CLID

SELECT *, @CLID AS CLID, @ClanName AS ClanName, @ClanGrade AS ClanGrade FROM Character WITH (nolock) where cid=@CID


GO


/* ĳ���� ���� */
CREATE PROC [spDeleteChar]
	@AID		int,
	@CharNum	smallint,
	@CharName	varchar(24)
AS
DECLARE @CID		int

SELECT @CID=CID FROM Character WITH (nolock) WHERE AID=@AID and CharNum=@CharNum

IF (@CID IS NULL) OR (EXISTS (SELECT TOP 1 CLID FROM ClanMember WHERE CID=@CID))
BEGIN
	return (-1)
END

UPDATE Character SET CharNum = -1, DeleteFlag = 1, Name='', DeleteName=@CharName
WHERE AID=@AID AND CharNum=@CharNum AND Name=@CharName


GO






/* ������ ĳ���� ����Ʈ �������� - ���ɻ� ������ �ִ�. ���߿� �� ���� ����� ã�ƺ��� */
CREATE PROC [spGetCharList]
	@AID		int
AS
SELECT c.CID AS CID, c.Name AS Name, c.CharNum AS CharNum, c.Level AS Level, c.Sex AS Sex, c.Hair AS Hair, c.Face AS Face,
       c.XP AS XP, c.BP AS BP,
       (SELECT cl.Name FROM Clan cl(nolock), ClanMember cm(nolock) WHERE cm.cid=c.cid AND cm.CLID=cl.CLID) AS ClanName,


  (SELECT ci.ItemID FROM CharacterItem ci WHERE c.head_slot = ci.CIID) head_ItemID,
  (SELECT ci.ItemID FROM CharacterItem ci WHERE c.chest_slot = ci.CIID) chest_ItemID,
  (SELECT ci.ItemID FROM CharacterItem ci WHERE c.hands_slot = ci.CIID) hands_ItemID,
  (SELECT ci.ItemID FROM CharacterItem ci WHERE c.legs_slot = ci.CIID) legs_ItemID,
  (SELECT ci.ItemID FROM CharacterItem ci WHERE c.feet_slot = ci.CIID) feet_ItemID,
  (SELECT ci.ItemID FROM CharacterItem ci WHERE c.fingerl_slot = ci.CIID) fingerl_ItemID,
  (SELECT ci.ItemID FROM CharacterItem ci WHERE c.fingerr_slot = ci.CIID) fingerr_ItemID,
  (SELECT ci.ItemID FROM CharacterItem ci WHERE c.melee_slot = ci.CIID) melee_ItemID,
  (SELECT ci.ItemID FROM CharacterItem ci WHERE c.primary_slot = ci.CIID) primary_ItemID,
  (SELECT ci.ItemID FROM CharacterItem ci WHERE c.secondary_slot = ci.CIID) secondary_ItemID,
  (SELECT ci.ItemID FROM CharacterItem ci WHERE c.custom1_slot = ci.CIID) custom1_ItemID,
  (SELECT ci.ItemID FROM CharacterItem ci WHERE c.custom2_slot = ci.CIID) custom2_ItemID
FROM Character AS c WITH (nolock)
WHERE c.AID=@AID AND c.DeleteFlag = 0

/* SELECT * FROM Character WHERE AID=@AID AND DeleteFlag=0 ORDER BY CharNum */

GO




/* ĳ���� ������ �߰� - ���� */
CREATE PROC [spInsertCharItem]
	@CID		int,
	@ItemID		int
AS
DECLARE @OrderCIID	int
DECLARE @varBP 		int
-- ����
SELECT @varBP = BP FROM Character where CID=@CID
IF @varBP < 0
BEGIN
	UPDATE Character SET BP=0 WHERE CID=@CID
	RETURN (-1)
END



INSERT INTO CharacterItem (CID, ItemID, RegDate) Values (@CID, @ItemID, GETDATE())

SET @OrderCIID = @@IDENTITY
SELECT @OrderCIID as ORDERCIID


GO


----------------------------------------------------------------------------------------------

-- ������ �α� ���̺�
CREATE TABLE "LevelUpLog"
(
	"id"			int identity not null,
	"CID"			int,
	"Level"			smallint,
	"BP"			int,
	"KillCount"		int,
	"DeathCount"	int,
	"PlayTime"		int,
	"Date"			datetime
)
go

ALTER TABLE "LevelUpLog"
	ADD CONSTRAINT "LevelUpLog_PK" primary key ("id")
go


-- ������ �α� �߰�
CREATE PROC [spInsertLevelUpLog]
	@CID			int,
	@Level			smallint,
	@BP				int,
	@KillCount		int,
	@DeathCount		int,
	@PlayTime		int
AS
	INSERT INTO LevelUpLog(CID, Level, BP, KillCount, DeathCount, PlayTime, Date)
	VALUES (@CID, @Level, @BP, @KillCount, @DeathCount, @PlayTime, GETDATE())
Go








--- ������ �͵� -------------------------------------------
ALTER TABLE PlayerLog DROP COLUMN AID
ALTER TABLE PlayerLog ADD XP int
ALTER TABLE PlayerLog ADD TotalXP int
UPDATE PlayerLog SET XP=0, TotalXP=0

/* �÷��̾� �α� */
CREATE PROC [spInsertPlayerLog]
	@CID          int,
	@PlayTime     int,
	@Kills        int,
	@Deaths       int,
	@XP           int,
	@TotalXP      int
AS
INSERT INTO PlayerLog
	(CID, DisTime, PlayTime, Kills, Deaths, XP, TotalXP)
VALUES
	(@CID, GETDATE(), @PlayTime, @Kills, @Deaths, @XP, @TotalXP)
GO
