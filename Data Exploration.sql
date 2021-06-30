SELECT * 
FROM portfolioproject..CovidDeaths
WHERE Continent IS NOT NULL
ORDER BY 3, 4

--SELECT * 
--FROM portfolioproject..CovidVaccinations
--ORDER BY 3, 4

SELECT Location, date, 
total_cases, new_cases,
total_deaths,
population
FROM portfolioproject..CovidDeaths
ORDER BY 1,2

--Looking at Total Cases vs. Total Deaths
--Shows the likelihood of dying if you contract COVID in your country
SELECT Location, date, 
total_cases,
total_deaths, (total_deaths/total_cases)*100 AS DeathPercentage
FROM portfolioproject..CovidDeaths
WHERE Location like '%states%'
ORDER BY 1,2

--Looking at total cases vs. population
--Shows percent of population that contracted COVID
SELECT Location, date, 
total_cases,
population, (total_cases/population)*100 AS PercentPopulationInfected
FROM portfolioproject..CovidDeaths
WHERE Location like '%states%'
ORDER BY 1,2

--Looking at countries with highest infection rate compared to population
SELECT Location, Population,
MAX(total_cases) AS MaxInfection, 
MAX((total_cases/population))*100 AS PercentPopulationInfected
FROM portfolioproject..CovidDeaths
--WHERE Location like '%states%'
GROUP BY Population, Location
ORDER BY PercentPopulationInfected DESC

--Looking at countries with highest death rate compared to population
SELECT Location,
MAX(cast(total_deaths as int)) AS MaxDeath
FROM portfolioproject..CovidDeaths
WHERE Continent IS NOT NULL
GROUP BY Location
ORDER BY MaxDeath DESC

--Looking at things by continent
--Showing continents with highest death count
SELECT Continent,
MAX(cast(total_deaths as int)) AS MaxDeath
FROM portfolioproject..CovidDeaths
WHERE Continent IS NOT NULL 
GROUP BY Continent
ORDER BY MaxDeath DESC

 --Global Numbers

SELECT 
SUM(new_cases) AS total_cases,
SUM(cast(new_deaths as int)) AS total_deaths,
SUM(cast (new_deaths as int))/SUM(new_cases)*100 AS DeathPercentage
FROM portfolioproject..CovidDeaths
WHERE Continent IS NOT NULL
ORDER BY 1,2 

--Looking at total population vs. vaccinations

SELECT dea.continent, dea.location, dea.date,
dea.population, vac.new_vaccinations,
SUM(CONVERT(int, vac.new_vaccinations)) OVER 
(Partition BY  dea.location
ORDER BY dea.location, dea.date) AS rolling_vaccination_count
FROM portfolioproject..CovidDeaths dea
JOIN portfolioproject..CovidVaccinations vac
ON dea.location=vac.location 
AND dea.date=vac.date
WHERE dea.continent IS NOT NULL
ORDER BY 2,3

--Use CTE
WITH PopVsVac (Continent, Location, 
Date, Population, New_Vaccinations, rolling_vaccination_count)
AS (
SELECT dea.continent, dea.location, dea.date,
dea.population, vac.new_vaccinations,
SUM(CONVERT(int, vac.new_vaccinations)) OVER 
(Partition BY  dea.location
ORDER BY dea.location, dea.date) AS rolling_vaccination_count
FROM portfolioproject..CovidDeaths dea
JOIN portfolioproject..CovidVaccinations vac
ON dea.location=vac.location
AND dea.date=vac.date
WHERE dea.continent IS NOT NULL)

SELECT *, (rolling_vaccination_count/population)*100
AS percent_population_vaccinated
FROM PopVsVac

--Temp Table
DROP TABLE IF EXISTS #PercentPopulationVaccinated
CREATE TABLE #PercentPopulationVaccinated
(
Continent nvarchar(255), 
Location nvarchar(255),
Date datetime,
Population numeric,
New_Vaccinations numeric,
rolling_vaccination_count numeric
)
INSERT INTO #PercentPopulationVaccinated
SELECT dea.continent, dea.location, dea.date,
dea.population, vac.new_vaccinations,
SUM(CONVERT(int, vac.new_vaccinations)) OVER 
(Partition BY  dea.location
ORDER BY dea.location, dea.date) AS rolling_vaccination_count
FROM portfolioproject..CovidDeaths dea
JOIN portfolioproject..CovidVaccinations vac
ON dea.location=vac.location
AND dea.date=vac.date

SELECT *, (rolling_vaccination_count/population)*100
AS percent_population_vaccinated
FROM #PercentPopulationVaccinated

--Creating view to store for later visualizations

CREATE VIEW PercentPopulationVaccinated AS
SELECT dea.continent, dea.location, dea.date,
dea.population, vac.new_vaccinations,
SUM(CONVERT(int, vac.new_vaccinations)) OVER 
(Partition BY  dea.location
ORDER BY dea.location, dea.date) AS rolling_vaccination_count
FROM portfolioproject..CovidDeaths dea
JOIN portfolioproject..CovidVaccinations vac
ON dea.location=vac.location
AND dea.date=vac.date
WHERE dea.continent IS NOT NULL

SELECT *
FROM PercentPopulationVaccinated
