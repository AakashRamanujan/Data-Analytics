select *

from owid_covid_data 

where continent is not null and location like '%World%'
order by 3,4




SELECT 

    location,
    date,
    total_cases,
    total_deaths,
    
    
    CASE 
        WHEN total_cases = 0 THEN NULL
        ELSE (total_deaths::numeric / total_cases::numeric) * 100
    END::integer as death_percentage
FROM 
    owid_covid_data 
    where location like '%India'
  order by location , date 

  
 -- shows what percentage of population got covid
  
  
SELECT 
    location,
    population,
    date,
    total_cases,
    total_deaths,
    
    
    CASE 
        WHEN total_cases = 0 THEN NULL
        ELSE (total_cases::float / population) * 100
    END::float as covid_percentage
FROM 
    owid_covid_data 
    where location like '%India'
  order by location , date 
  
  
  -- highest death in each country

  SELECT 
    location,
    population,
    
   max(total_cases) as highestinfectionrate,
    
    
    CASE 
        when max( total_cases) = 0 THEN NULL
        ELSE max((total_cases::float / population)) * 100
    END::float as covid_percentage
FROM 
    owid_covid_data 
WHERE 
    continent IS NOT NULL
    AND continent != '' -- Exclude empty strings    
    
  group by location,population 
  
  order by covid_percentage desc
  
--ordering based on highest death count 
  
SELECT 
    location,
    MAX(cast(total_deaths as int)) AS totaldeathcount
FROM 
    owid_covid_data 
WHERE 
    continent IS NOT NULL
    AND continent != '' -- Exclude empty strings
GROUP BY  
    location
HAVING 
    MAX(total_deaths) IS NOT null
ORDER BY 
    totaldeathcount DESC; 


   --we  are using having clause because it is used to sort aggregate data (max(total_cases)) instead of where
   
 
SELECT 
    continent,
    MAX(cast(total_deaths as int)) AS totaldeathcount
FROM 
    owid_covid_data 
WHERE 
    continent IS NOT NULL
    AND continent != '' -- Exclude empty strings
GROUP BY  
    continent
HAVING 
    MAX(total_deaths) IS NOT null
ORDER BY 
    totaldeathcount DESC; 

