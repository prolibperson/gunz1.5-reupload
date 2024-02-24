-----------------------------------------------------
-- ���� ������ ���
-----------------------------------------------------
USE GunzDB
GO

DECLARE @CheckTime DATETIME;
SELECT @CheckTime = '2010-08-01';

SELECT	COUNT(a.AID) AS 'Count'
FROM	Account a(NOLOCK)
WHERE	a.RegDate < @CheckTime


-----------------------------------------------------
-- ���� ���ϱ��� �Ѵ���������
USE GunzDB
EXEC sp_spaceused Account



-----------------------------------------------------
-- �� ����ũ ������
USE LogDB
GO

SELECT	COUNT(DISTINCT(AID)) AS 'Count'
FROM	ConnLog_201007 c(NOLOCK)	-- ConnLog�� �ش��ϴ� ���� ���̺� �̸�



-----------------------------------------------------
-- �Ϻ� ����ũ ������
USE LogDB
GO

SELECT	r.Day, COUNT(r.AID) AS 'Count'
FROM	(	SELECT AID, DATEPART(dd, TIME) AS 'Day'
			FROM dbo.ConnLog_201007(NOLOCK) 	
			GROUP BY AID, DATEPART(dd, TIME) ) r
GROUP BY r.Day
ORDER BY r.Day



-- �Ϻ� ����ũ �ű԰�����
USE GunzDB
GO

DECLARE @Start	DATETIME;
DECLARE @End	DATETIME;

SELECT @Start = '2010-07-01';
SELECT @End = '2010-08-01';

SELECT	DATEPART(dd, a.RegDate) AS 'Day', COUNT(a.AID) AS 'Count'
FROM	Account a(NOLOCK)
WHERE	a.RegDate >= @Start AND a.RegDate < @End
GROUP BY DATEPART(dd, a.RegDate)
ORDER BY DATEPART(dd, a.RegDate)