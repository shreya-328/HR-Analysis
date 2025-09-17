select top 10 * from [hr_data].[dbo].[Employee];

--- cleaning and transformation

-- handling missing values
SELECT 
    COUNT(*) AS TotalRows,
    COUNT(Salary) AS SalaryNonNull,
    COUNT(DistanceFromHome_KM) AS DistanceNonNull,
    COUNT(OverTime) AS OverTimeNonNull,
    COUNT(Attrition) AS AttritionNonNull
FROM dbo.Employee; -- No Missing Value 1470 for all


--checking data types for all columns

SELECT COLUMN_NAME, DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'Employee';

--converting attrition and overtime again into int
ALTER TABLE dbo.Employee
ADD AttritionInt BIT NULL,
    OverTimeBit BIT NULL;

GO

UPDATE dbo.Employee
SET AttritionInt = CASE WHEN LOWER(Attrition) IN ('yes', '1') THEN 1 ELSE 0 END,
    OverTimeBit = CASE WHEN LOWER(OverTime) IN ('yes', '1') THEN 1 ELSE 0 END;

GO

-- Optional: Check conversion
SELECT DISTINCT Attrition, AttritionInt, OverTime, OverTimeBit
FROM dbo.Employee;


-- queries for exploratory analysis

-- counting total employees and attrition rate

SELECT 
    COUNT(*) AS TotalEmployees,
    SUM(CAST(AttritionInt AS INT)) AS TotalAttrition,
    CAST(AVG(CAST(AttritionInt AS FLOAT)) * 100 AS DECIMAL(5,2)) AS AttritionRatePercentage
FROM dbo.Employee;
--1470	237	16.12

--attrition rate by dept

SELECT 
    Department,
    COUNT(*) AS Count,
    CAST(AVG(CAST(AttritionInt AS FLOAT)) * 100 AS DECIMAL(5,2)) AS AttritionRatePercentage
FROM dbo.Employee
GROUP BY Department
ORDER BY AttritionRatePercentage DESC;
--- Sales	446	20.63
--- Human Resources	63	19.05
--- Tech0logy	961	13.84


-- avg salary by attr status
SELECT 
    AttritionInt,
    AVG(Salary) AS AvgSalary
FROM dbo.Employee
GROUP BY AttritionInt;

-- 0	118856
-- 1	82261

--correlation of overtime with attrition
SELECT 
    OverTimeBit,
    COUNT(*) AS Count,
    CAST(AVG(CAST(AttritionInt AS FLOAT)) * 100 AS DECIMAL(5,2)) AS AttritionRatePercentage
FROM dbo.Employee
GROUP BY OverTimeBit;

-- 0	1054	10.44
-- 1	416	30.53

--explore attrition by jobrole, agegroup, maritasl sttus, edu field
--looking for patterns or anamolies

SELECT JobRole,
       COUNT(*) AS Count,
       CAST(AVG(CAST(AttritionInt AS FLOAT)) * 100 AS DECIMAL(5,2)) AS AttritionRatePercentage
FROM dbo.Employee
GROUP BY JobRole
ORDER BY AttritionRatePercentage DESC;

--exploring age and years atr company in rel with attri
--creating froup
ALTER TABLE dbo.Employee
ADD AgeGroup VARCHAR(20);
GO
UPDATE dbo.Employee
SET AgeGroup = CASE 
       WHEN Age < 25 THEN 'Under 25'
       WHEN Age BETWEEN 25 AND 34 THEN '25-34'
       WHEN Age BETWEEN 35 AND 44 THEN '35-44'
       ELSE '45+'
END;

--analying attr rate by age group
SELECT AgeGroup,
       COUNT(*) AS Count,
       CAST(AVG(CAST(AttritionInt AS FLOAT)) * 100 AS DECIMAL(5,2)) AS AttritionRatePercentage
FROM dbo.Employee
GROUP BY AgeGroup
ORDER BY AttritionRatePercentage DESC;

-- 25-34	596	19.80
-- Under 25	521	18.43
-- 35-44	263	6.84
-- 45+	90	5.56 
--young people leave often because of career


-- count and attr rates grouped by agegroup and dept
SELECT AgeGroup,
       Department,
       COUNT(*) AS EmployeeCount,
       CAST(AVG(CAST(AttritionInt AS FLOAT)) * 100 AS DECIMAL(5,2)) AS AttritionRatePercentage
FROM dbo.Employee
GROUP BY AgeGroup, Department
ORDER BY AgeGroup, AttritionRatePercentage DESC;

--combining job roles and overtime

SELECT JobRole,
       OverTimeBit,
       COUNT(*) AS EmployeeCount,
       CAST(AVG(CAST(AttritionInt AS FLOAT)) * 100 AS DECIMAL(5,2)) AS AttritionRatePercentage
FROM dbo.Employee
GROUP BY JobRole, OverTimeBit
ORDER BY AttritionRatePercentage DESC;


-- verifying data in each table
SELECT TOP 10 * FROM EducationLevel;
SELECT TOP 10 * FROM [dbo].[PerformanceRating(in)];
SELECT TOP 10 * FROM RatingLevel;
SELECT TOP 10 * FROM SatisfiedLevel;

--attr by education
SELECT 
    ed.EducationLevel,
    COUNT(*) AS EmployeeCount,
    AVG(CAST(e.AttritionInt AS FLOAT)) * 100 AS AttritionRatePercentage
FROM dbo.Employee e
JOIN dbo.EducationLevel ed ON e.Education = ed.EducationLevelID
GROUP BY ed.EducationLevel
ORDER BY AttritionRatePercentage DESC;

SELECT COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'Employee';
SELECT COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'SatisfiedLevel';


-- attr by satisfaction level
SELECT 
    s.SatisfactionLevel,
    COUNT(*) AS EmployeeCount,
    AVG(CAST(e.AttritionInt AS FLOAT)) * 100 AS AttritionRatePercentage
FROM dbo.Employee e
JOIN dbo.SatisfiedLevel s ON e.SatisfactionID = s.SatisfactionID
GROUP BY s.SatisfactionLevel
ORDER BY AttritionRatePercentage DESC;

--attr by edu
SELECT 
    ed.EducationLevel,
    COUNT(*) AS EmployeeCount,
    AVG(CAST(e.AttritionInt AS FLOAT)) * 100 AS AttritionRatePercentage
FROM dbo.Employee e
LEFT JOIN dbo.EducationLevel ed ON e.Education = ed.EducationLevelID
GROUP BY ed.EducationLevel
ORDER BY AttritionRatePercentage DESC;

--attr directly on emp , eg agegroup
SELECT 
    e.AgeGroup,
    COUNT(*) AS EmployeeCount,
    AVG(CAST(e.AttritionInt AS FLOAT)) * 100 AS AttritionRatePercentage
FROM dbo.Employee e
GROUP BY e.AgeGroup
ORDER BY AttritionRatePercentage DESC;





-- SELECT COLUMN_NAME 
-- FROM INFORMATION_SCHEMA.COLUMNS 
-- WHERE TABLE_NAME = 'Employee'
-- AND COLUMN_NAME LIKE '%satisf%'
