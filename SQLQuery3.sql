select Location, date, total_cases,new_cases,total_deaths,population
from Coviddeaths$
Order by 1,2


-- Looking at Total Cases vs Total Deaths
select Location, date, total_cases,total_deaths, (total_deaths/total_cases*100) as DeathRate_Percentage
from Coviddeaths$
Order by 1,2

--Looking at Total Cases vs Total Deaths in the United States
select Location, date, total_cases,total_deaths, (total_deaths/total_cases*100) as DeathRate_Percentage
from Coviddeaths$
Where location like '%States'
Order by 1,2

--Looking at the Total Cases vs Population (infection rate)
select Location, date,population, total_cases, (total_cases/population*100) as Infection_Rate
from Coviddeaths$
where location like '%States'
Order by 1,2


-- Looking at which countries have the highest infection rate
select Location,population, Max(total_cases) as highestinfectedcount, Max(total_cases/population*100) as Infection_Rate
from Coviddeaths$
--where location like '%States'
Group by Location, Population
Order by 4 Desc;

select location,population, Max(total_cases/population*100) as Infection_Rate
from Coviddeaths$
Group by location, population
order by 3 Desc;

-- Showing the Countries with the highest death rate
select location,population ,Max(total_deaths/total_cases*100) as Death_Rate
from coviddeaths$
group by location,population
order by 3 Desc;

-- Showing the Countries with the highest death count
select location,population ,Max(cast(total_deaths as INT)) as Highest_Death_Count
from coviddeaths$
where continent is not null
group by location,population
order by 3 Desc;

--Now lets breaks things down by continent
-- Continent highest death count
select location,Max(cast(total_deaths as INT)) as Highest_Death_Count
from coviddeaths$
where continent is null
group by location
order by 2 Desc;

--Showing the global numbers
select date,Sum(new_cases) as new_cases,Sum(cast(new_deaths as int)) as new_deaths, Sum(cast(new_deaths as int))/ Sum(New_Cases)*100 as death_percentage
from coviddeaths$
where continent is not null
group by date
order by 1,2



--Looking at Total Population Vs Vaccinations 
Select dea.continent, dea.location,dea.date,dea.population,vac.new_vaccinations,Sum(Convert(int,vac.new_vaccinations )) Over ( Partition by dea.location Order by dea.location, dea.date)
from Coviddeaths$ dea
Join covidvaccinations$ vac on dea.location = vac.location and dea.date = vac.date
where dea.continent is not null
order by 2,3

