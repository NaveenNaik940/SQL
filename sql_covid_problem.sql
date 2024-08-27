---"""

---@Author: Naveen Madev Naik
---@Date: 2024-08-22
---@Last Modified by: Naveen Madev Naik
---@Last Modified time: 2024-08-22
---@Title: Sql operation on Covid dataset

---"""



use Covid_test;

---Sql operation on Covid-data-global

--------->
--1.To find out the death percentage locally and globally

select country_region, round(deaths*100.00/confirmed,2) as death_percentage from country_wiselatest ;

select country_region, round(deaths*100.00/confirmed,2)/1 as death_percentage from country_wiselatest  where country_region='india';



--2. To find out the infected population percentage locally and globally

select Country_Region,round((totalcases *100.0 /population),4)  as infectedPopulationPercentage from worldometer_data; ---globally

select Country_Region,round((totalcases *100.0 /population),4)  as infectedPopulationPercentage from worldometer_data where Country_Region='india';



--3. To find out the countries with the highest infection rates

select Country_Region,Confirmed as highest_infection from country_wiselatest where Confirmed in (select max(Confirmed) from country_wiselatest );



--4. To find out the countries and continents with the highest death counts

select top 1 Continent,sum(totaldeaths) as totaldeath from worldometer_data group by Continent  order by TotalDeath desc ---Continent

select top 1 Country_region, totaldeaths from worldometer_data order by TotalDeaths desc ---Country

select * from covid_clean



---5. Average number of deaths by day (Continents and Countries)

select Country_Region,sum(deaths)/count(Country_Region) as average_deaths_countries from covid_clean group by Country_Region; ---Country

select who_region,sum(deaths)/count(who_region) average_death_continent from covid_clean group by WHO_Region; ---Continent




---6. Average of cases divided by the number of population of each country (TOP 10) 

select * from worldometer_data

select top 10 Country_Region,(TotalCases * 1.0 / Population) AS Cases_Per_Population FROM worldometer_data order by Cases_Per_Population desc;




---7. Considering the highest value of total cases, which countries have the highest rate of infection in relation to population

select top 1 country_region, totaldeaths,totalcases*1.0/population as infection_rate from worldometer_data order by totaldeaths desc;







-----Using JOINS to combine the covid_deaths and covid_vaccine tables :-----

---1. To find out the population vs the number of people vaccinated

select * from worldometer_data;
select * from covid_vaccine_statewise;

select round(
    (cv.Total_Doses_Administered * 100.0) / wd.MaxPopulation, 
    2
) as percentage
from 
    (select MAX(Population) as MaxPopulation
     from worldometer_data 
     where Continent = 'Asia') wd
join 
    (select Total_Doses_Administered
     from covid_vaccine_statewise 
     where state = 'India' 
     and Updated_On = (
         select max(Updated_On)
         from covid_vaccine_statewise 
         where state = 'India' 
         and Total_Doses_Administered is not null
     )
     and Total_Doses_Administered is not null) cv
on 1=1;





---2. To find out the percentage of different vaccine taken by people in a country

select
    Updated_On as Date,
    State,
    Covaxin_Doses_Administered * 100.0 / Total_Doses_Administered as Covaxin_Percentage,
    CoviShield_Doses_Administered * 100.0 / Total_Doses_Administered as CoviShield_Percentage,
    Sputnik_V_Doses_Administered * 100.0 / Total_Doses_Administered as Sputnik_V_Percentage
from 
   covid_vaccine_statewise
order by date asc;





---3. To find out percentage of people who took both the doses

select
    covid_1.Updated_On as Date,
    covid_1.State,
    coalesce(covid_2.Second_Dose_Administered, 0) * 100.0 / coalesce(covid_1.First_Dose_Administered, 1) as Percentage_Both_Doses
from 
    covid_vaccine_statewise covid_1
join 
    covid_vaccine_statewise covid_2
on 
    covid_1.State = covid_2.State
    and covid_1.Updated_On = covid_2.Updated_On  
order by 
    covid_1.Updated_On asc;











