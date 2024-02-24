-- ĳ���� �ʱ�ȭ
CREATE   PROC [spWebResetChar]
	@CID		INT
AS
BEGIN
	-- ���� �ʱ�ȭ
	UPDATE Character SET Level=1, XP=0, BP=0, 

	head_slot=NULL, chest_slot=NULL, hands_slot=NULL, legs_slot=NULL, feet_slot=NULL,
	fingerl_slot=NULL, fingerr_slot=NULL, melee_slot=NULL, primary_slot=NULL, secondary_slot=NULL,
	custom1_slot=NULL, custom2_slot=NULL,
	GameCount=0, KillCount=0, DeathCount=0, 
	head_itemid=NULL, chest_itemid=NULL, hands_itemid=NULL, legs_itemid=NULL, feet_itemid=NULL,
	fingerl_itemid=NULL, fingerr_itemid=NULL, melee_itemid=NULL, primary_itemid=NULL, secondary_itemid=NULL,
	custom1_itemid=NULL, custom2_itemid=NULL, QuestItemInfo=NULL

	WHERE CID=@CID

	-- ������ ����(��� �������� ����)
	UPDATE CharacterItem SET CID=NULL WHERE CID=@CID AND ItemID < 500000

END
GO


