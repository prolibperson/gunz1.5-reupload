-- IPtoCountry�� Table ���� �����͸� ��� �����Ѵ�.
DELETE IPtoCountry


-- ������ ������ �̿��Ͽ� �����͸� ��� �����Ѵ�.
-- ������ 1. SQL Server�� ��ġ�� �������� �����ؾ� �˴ϴ�.
-- ������ 2. ��θ� �� ���ϸ��� SQL Server�� �־�� �մϴ�.
-- ������ 3. ��θ� �� ���ϸ��� ��Ȯ�ؾ� �մϴ�.
BULK INSERT dbo.IPtoCountry FROM '��θ�\���ϸ�'		-- ex) 'c:\ip-to-country.csv'
WITH (
	DATAFILETYPE = 'char',
	FIELDTERMINATOR = ',',
	ROWTERMINATOR = '\n'
)
