-- Ŭ�� ��ŷ
SELECT chr.Clanname, chr.Point, chr.Wins, chr.Losses, chr.Ranking, c.Name, a.UserID
FROM ClanHonorRanking chr(nolock), Clan cl(nolock), Character c(nolock), Account a(nolock)
where chr.month=10 and chr.CLID=cl.CLID and cl.MasterCID=c.cid and c.AID=a.aid
ORDER by chr.Ranking

-- �ִ��÷��� Ŭ��
SELECT chr.Clanname, chr.Point, chr.Wins, chr.Losses, chr.Ranking, c.Name, a.UserID
FROM ClanHonorRanking chr(nolock), Clan cl(nolock), Character c(nolock), Account a(nolock)
where chr.month=10 and chr.CLID=cl.CLID and cl.MasterCID=c.cid and c.AID=a.aid
ORDER by (chr.Wins + chr.Losses) DESC


-- ��¥�� Ŭ���� ���Ӽ�
---------------------------------------------------------------------------------
SELECT Convert(char(20), RegDate, 111) AS Day, COUNT(*) FROM ClanGameLog 
WHERE RegDate BETWEEN '2004.11.1' AND '2004.12.1'
GROUP BY Convert(char(20), RegDate, 111)
ORDER BY Day


-- ���ٻ� ����
---------------------------------------------------------------------------------

-- �ӽ����̺� �־�д�.
SELECT WinnerCLID AS CLID, WinnerClanname AS ClanName, RegDate 
INTO #temp_ClanGameLog
FROM ClanGameLog(nolock)
WHERE RegDate BETWEEN '2004.10.1' AND '2004.11.1'

INSERT #temp_ClanGameLog
SELECT LoserCLID AS CLID, LoserClanName AS ClanName, RegDate
FROM ClanGameLog(nolock)
WHERE RegDate BETWEEN '2004.10.1' AND '2004.11.1'


-- ����
SELECT atable.CLID, atable.ClanName, COUNT(*) AS DayCount, c.Name, a.Userid

FROM 
(SELECT t.CLID, t.ClanName, CONVERT(char(10), t.RegDate, 120) AS _day, COUNT(*) AS cnt
FROM #temp_ClanGameLog t
GROUP BY CONVERT(char(10), t.RegDate, 120), t.CLID, t.ClanName

) atable, Clan cl(nolock), Character c(nolock), Account a(nolock)

WHERE atable.CLID=cl.CLID and cl.MasterCID=c.cid and c.AID=a.aid

GROUP BY atable.CLID, atable.ClanName, c.Name, a.Userid
ORDER BY DayCount DESC

---------------------------------------------------------------------------------