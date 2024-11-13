CREATE TABLE #covid
(CONTINENT VARCHAR(50), LOCATION VARCHAR(50), DATES DATETIME, 
POPULATION float, total_cases int, new_cases int, total_deaths int, new_deaths int);  

DROP TABLE #covid;

INSERT INTO #covid 
SELECT CONTINENT, LOCATION, DATE, 
POPULATION, total_cases, new_cases, total_deaths, new_deaths FROM PortfolioProject..CovidDeaths$ WHERE continent IS NOT NULL;

SELECT * FROM #covid;

SELECT CONVERT(DATE,DATES) FROM #covid; 