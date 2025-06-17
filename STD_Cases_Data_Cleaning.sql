# Data Cleaning


SELECT * FROM std1.std_cases;

# This query is checking for duplites

SELECT Disease, `Disease Code`, State, Year, Gender, Age, `Age Code`, COUNT(*)
FROM std1.std_cases
GROUP BY Disease, `Disease Code`, State, Year, Gender, Age, `Age Code`
HAVING COUNT(*) > 1;

# This query is checking for missing or NULL values

SELECT * FROM std1.std_cases
WHERE Disease IS NULL OR `Disease Code` IS NULL OR State IS NULL 
   OR Year IS NULL OR Gender IS NULL OR Age IS NULL 
   OR `Age Code` IS NULL OR `STD Cases` IS NULL OR Population IS NULL 
   OR `Rate per 100K` IS NULL;
   
# This query is checking for Data Formats

#Select Gender 
#Where Gender = 'male';

UPDATE std1.std_cases
SET Gender = 'Male' WHERE Gender IN ('M', 'male', 'm');

UPDATE std1.std_cases
SET Gender = 'Female' WHERE Gender IN ('F', 'female', 'f');

UPDATE std1.std_cases
SET State = UPPER(State);

UPDATE std1.std_cases
SET `Rate per 100K` = ROUND(`Rate per 100K`, 2);


# This query is checking for Inconsistent Values

#SELECT * FROM std1.std_cases WHERE Year < 1996 OR Year > 2008;

SELECT * FROM std1.std_cases WHERE Age < 0 OR Age > 120;


# This query is checking for Outliers

Select *
FROM std1.std_cases
ORDER BY `Rate per 100K` DESC
LIMIT 10;