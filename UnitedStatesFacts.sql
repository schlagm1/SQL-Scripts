--Replace nulls with 0's in StateData and StateTaxes tables

Update StateTaxes
SET weightedTax= ISNULL(weightedTax,0)

Update StateTaxes
SET incomeTax= ISNULL(incomeTax,0)

Update StateTaxes
SET salesTax= ISNULL(salesTax,0)

Update StateTaxes
SET propertyTax= ISNULL(propertyTax,0)

Update StateTaxes
SET CapitalGainsTaxRate= ISNULL(CapitalGainsTaxRate,0)

Update StateData
SET costIndex= ISNULL(costIndex,0)

Update StateData
SET groceryCost= ISNULL(groceryCost,0)

Update StateData
SET housingCost= ISNULL(housingCost,0)

Update StateData
SET utilitiesCost= ISNULL(utilitiesCost,0)

Update StateData
SET transportationCost= ISNULL(transportationCost,0)

Update StateData
SET miscCost= ISNULL(miscCost,0)

Update StateData
SET homicideRate2017= ISNULL(homicideRate2017,0)

Update StateData
SET firearmDeathRate= ISNULL(firearmDeathRate,0)

Update StateData
SET firearmDeaths= ISNULL(firearmDeaths,0)

Update StateData
SET overallEducationRank= ISNULL(overallEducationRank,0)

Update StateData
SET higherEducationRank= ISNULL(higherEducationRank,0)

Update StateData
SET prek12Rank= ISNULL(prek12Rank,0)

Update StateData
SET smokingRate= ISNULL(smokingRate,0)


--Rename columns: 'density' column to 'populationdensity', 'overallRank' to 'overallEducationRank',
--'Income per Capita' to 'IncomePerCapita', 'Percent' to 'PopPercent'

--Use stored procedures to rename columns

EXEC sp_rename 'StateData.density', 'populationDensity', 'COLUMN'

EXEC sp_rename 'StateData.overallRank', 'overallEducationRank', 'COLUMN'

EXEC sp_rename 'StateData.Income per Capita', 'IncomePerCapita', 'COLUMN'

EXEC sp_rename 'StateData.Percent', 'PopPercent', 'COLUMN'

--Create temp table with just data we want
DROP TABLE IF EXISTS #temp_State
CREATE TABLE #temp_State (
	StateID int, State varchar(55),
	MedianAge int, Pop int, PopRank int, costIndex int,
	colRank int,
	overallEducationRank int, eduRank int,
	housingCost int,
	IncomePerCapita int, incomeRank int,
	homicideRate2017 int, crimeRank int,
	weightedTax int, taxRank int,
	housingcostRank int)

--Insert data into temp table with join

INSERT INTO #temp_State
SELECT 
	Da.StateID, Da.State,
	Da.MedianAge, Da.Pop, ROW_NUMBER() OVER (ORDER BY Pop DESC) PopRank,
	Da.costIndex, ROW_NUMBER() OVER (ORDER BY costIndex DESC) colRank, Da.overallEducationRank,
	ROW_NUMBER() OVER (ORDER BY overallEducationRank) eduRank,
	Da.housingCost,
	Da.IncomePerCapita, ROW_NUMBER() OVER (ORDER BY IncomePerCapita) incomeRank,
	Da.homicideRate2017, ROW_NUMBER() OVER (ORDER BY homicideRate2017 DESC) crimeRank,
	Ta.weightedTax, ROW_NUMBER() OVER (ORDER BY weightedTax DESC) taxRank,
	ROW_NUMBER() OVER (ORDER BY housingCost DESC) housingcostRank
FROM StateData Da
JOIN StateTaxes Ta
ON Da.StateID=Ta.StateID


--Let's look at the rankings

SELECT State, colRank, incomeRank, taxRank, housingcostRank, crimeRank
FROM #temp_State

--Weighted ranking based on: cost of living, income, taxes, housing cost, education, crime

ALTER TABLE #temp_State
	ADD weightedScore int

UPDATE #temp_State
	SET weightedScore=(colRank*.2)+(incomeRank*.25)+(taxRank*.25)+ (housingcostRank*.15)+(crimeRank*.15)


SELECT State, weightedScore, ROW_NUMBER() OVER (ORDER BY weightedScore DESC) overallRank
FROM #temp_State
ORDER BY overallRank 



