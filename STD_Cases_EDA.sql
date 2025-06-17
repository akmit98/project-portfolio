-- Exploratory Data Analysis

-- How have STD rates changed over time (1996-2008) in the U.S.? 
-- This query calculates the total number of cases and average rate per 100K each year

SELECT 
    Year, 
    SUM(`STD Cases`) AS Total_Cases, 
    AVG(`Rate per 100K`) AS `Avg Rate per 100K`
FROM std1.std_cases
GROUP BY Year
ORDER BY Year;


-- Are certain STDs increasing or decreasing over time? 
-- This query shows the trend for each disease over time

SELECT 
    Year, 
    Disease,
    SUM(`STD Cases`) AS Total_Cases, 
    AVG(`Rate per 100K`) AS `Avg Rate per 100K`
FROM std1.std_cases
GROUP BY Year, Disease
ORDER BY Disease, Year;


-- What is the overall trend of STD infections per state over time? 
-- This query tracks STD infections for each state from 1996-2008

SELECT 
    Year, 
    State,
    SUM(`STD Cases`) AS Total_Cases, 
    AVG(`Rate per 100K`) AS `Avg Rate per 100K`
FROM std1.std_cases
GROUP BY Year, State
ORDER BY State, Year;

-- Do men or women have higher STD rates? 
-- This query compares average STD rates between genders across all years and states:

SELECT 
    Gender, 
    SUM(`STD Cases`) AS Total_Cases, 
    SUM(Population) AS Total_Population,
    (SUM(`STD Cases`) * 100000.0 / SUM(Population)) AS `Rate per 100K`
FROM std1.std_cases
WHERE Gender IS NOT NULL
GROUP BY Gender;

-- Which age group is most affected by STDs? 
-- This query summarizes STD rates by age group:

SELECT 
    `Age Code`, 
    AVG(Age) AS Avg_Age, 
    SUM(`STD Cases`) AS Total_Cases, 
    SUM(Population) AS Total_Population,
    (SUM(`STD Cases`) * 100000.0 / SUM(Population)) AS `Rate per 100K`
FROM std1.std_cases
WHERE Age IS NOT NULL
GROUP BY `Age Code`
ORDER BY `Rate per 100K` DESC;

-- Is there a difference in STD rates across gender within specific age groups? 
-- This query breaks down rates by both gender and age group:

SELECT 
    `Age Code`, 
    Gender, 
    SUM(`STD Cases`) AS Total_Cases, 
    SUM(Population) AS Total_Population,
    (SUM(`STD Cases`) * 100000.0 / SUM(Population)) AS `Rate per 100K`
FROM std1.std_cases
WHERE Gender IS NOT NULL AND `Age Code` IS NOT NULL
GROUP BY `Age Code`, Gender
ORDER BY `Age Code`, Gender;


-- How does the population size of a state impact its STD rate per 100,000? 
-- This question is about correlation — whether more populous states have higher or lower STD rates.

SELECT 
    State,
    SUM(`STD Cases`) AS Total_Cases,
    SUM(Population) AS Total_Population,
    (SUM(`STD Cases`) * 100000.0 / SUM(Population)) AS Rate_per_100K
FROM std1.std_cases
GROUP BY State
ORDER BY Total_Population DESC;


-- Are certain STDs more prevalent in smaller vs. larger states? 
-- This query groups by both disease and state population size.

SELECT 
    Disease,
    State,
    CASE 
        WHEN SUM(Population) >= 10000000 THEN 'Large'
        WHEN SUM(Population) BETWEEN 3000000 AND 9999999 THEN 'Medium'
        ELSE 'Small'
    END AS State_Size,
    SUM(`STD Cases`) AS Total_Cases,
    (SUM(`STD Cases`) * 100000.0 / SUM(Population)) AS Rate_per_100K
FROM std1.std_cases
GROUP BY Disease, State
ORDER BY Disease, Rate_per_100K DESC;


SELECT * FROM std1.std_cases;