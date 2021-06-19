--Create temp table with net migration data
DROP TABLE IF EXISTS #temp_Migration
CREATE TABLE #temp_Migration (REGION int, RegionName varchar(55), 
		DIVISION int, DivisionName varchar(55),
		STATE int, StateName varchar(55),
		NETMIG2010 int, NETMIG2011 int, NETMIG2012 int, NETMIG2013 int,
		NETMIG2014 int, NETMIG2015 int, NETMIG2016 int, NETMIG2017 int,
		NETMIG2018 int, NETMIG2019 int, NETMIG2020 int)

--Insert data into temp table
INSERT INTO #temp_Migration
SELECT REGION, RegionName, DIVISION, DivisionName, STATE, StateName,
		NETMIG2010, NETMIG2011, NETMIG2012, NETMIG2013,
		NETMIG2014, NETMIG2015, NETMIG2016, NETMIG2017,
		NETMIG2018, NETMIG2019, NETMIG2020
		FROM StateMigration

--Let's look at the data by state, filtering out regions, Puerto Rico, D.C.
SELECT STATE, StateName, NETMIG2010, NETMIG2011, NETMIG2012, NETMIG2013,
		NETMIG2014, NETMIG2015, NETMIG2016, NETMIG2017,
		NETMIG2018, NETMIG2019, NETMIG2020
		FROM #temp_Migration
		WHERE STATE NOT IN (0, 72, 11)
		ORDER BY NETMIG2020 DESC