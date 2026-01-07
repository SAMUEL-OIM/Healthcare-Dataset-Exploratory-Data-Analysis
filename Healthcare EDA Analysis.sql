										-- HEALTH_CARE DATASET
## Importation of the data
CREATE table Healthcare(ID TEXT, Name TEXT, Age TEXT ,Gender TEXT, City TEXT,
					 Blood_Type TEXT, Education_level TEXT, Employer TEXT,  Salary TEXT, Health_condition TEXT, 
					 Credit_score TEXT, Date_of_admission TEXT);
                     DESC healthcare;
LOAD DATA INFILE "\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\healthcare_data.csv"
INTO TABLE mine.healthcare
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES;

## Creation of the table without duplicate records
CREATE TABLE clone_healthcare AS
SELECT DISTINCT *
FROM healthcare;
DROP TABLE clone_healthcare;

											-- ID
-- Modification of the ID to "INT" From "TEXT"
ALTER TABLE clone_healthcare
MODIFY ID INT;

SELECT Age, Education_level, Employer, Salary
FROM clone_healthcare;

## List of ID that are duplicates
SELECT ID, COUNT(ID)
FROM clone_healthcare
GROUP BY ID
HAVING COUNT(ID) > 1 ;

											-- NAME
-- Modification of the "Name" column into a PROPER text and formatting the data type to "VARCHAR"
UPDATE clone_healthcare
SET Name = TRIM(CONCAT(UPPER(LEFT(LEFT(name,LOCATE(". ",name)),1)), LOWER(MID(LEFT(name,LOCATE(". ",name)),2))," ",
 		UPPER(LEFT(SUBSTRING_INDEX(name,'. ',-1),1)), LOWER(MID(SUBSTRING_INDEX(name,'. ',-1),2,LOCATE(" ",SUBSTRING_INDEX(name,'. ',-1))-1))," ",
		UPPER(LEFT(SUBSTRING_INDEX(TRIM(SUBSTRING(SUBSTRING_INDEX(name,'. ',-1),LOCATE(" ",SUBSTRING_INDEX(name,'. ',-1))))," ",1),1)), LOWER(MID(SUBSTRING_INDEX(TRIM(SUBSTRING(SUBSTRING_INDEX(name,'. ',-1),LOCATE(" ",SUBSTRING_INDEX(name,'. ',-1))))," ",1),2))," ",
        SUBSTRING(TRIM(SUBSTRING(SUBSTRING_INDEX(name,'. ',-1),LOCATE(" ",SUBSTRING_INDEX(name,'. ',-1)))),LOCATE(" ",TRIM(SUBSTRING(SUBSTRING_INDEX(name,'. ',-1),LOCATE(" ",SUBSTRING_INDEX(name,'. ',-1))))))));
ALTER TABLE clone_healthcare
MODIFY Name VARCHAR(50);

											-- AGE
-- Updating the "Age" Coolumn which comprises "Unknown" to NULL
-- Formatting the data type to "INT", so it can perform aggregate function
UPDATE clone_healthcare
SET Age = NULL
WHERE Age = "Unknown";
ALTER TABLE clone_healthcare
MODIFY Age INT;

										 -- GENDER
-- Cleaning the "Gender" Column
-- Blank = "Unknown", M = "Male", F = "Female"
-- Fromatting the datatype to "VARCHAR" from "TEXT"
UPDATE clone_healthcare
SET Gender = "Unknown"
WHERE Gender =  "";
UPDATE clone_healthcare
SET Gender = "Male"
WHERE Gender = "M";
UPDATE clone_healthcare
SET Gender = "Female"
WHERE Gender = "F";
ALTER TABLE clone_healthcare
MODIFY Gender VARCHAR(35);

							                 -- CITY
-- Updating it to a "PROPER" text and  the cloumn abbrevations 
-- "Balti" TO "Baltimore", "Atl" TO "Atlanta", "Albuque" TO  "Albuquerque"
--  Foramting it to "VARCHAR" from "TEXT" 
UPDATE clone_healthcare
SET City = CONCAT(UPPER(LEFT(SUBSTRING(City,1),1)),
		LOWER(MID(SUBSTRING(City,1),2))
			);
UPDATE clone_healthcare
SET City = "Atlanta"
WHERE City = "Atl";
UPDATE clone_healthcare
SET City = "Baltimore"
WHERE City = "Balti";
UPDATE clone_healthcare
SET City = "Albuquerque"
WHERE City = "Albuque";
ALTER TABLE clone_healthcare
MODIFY City VARCHAR(40);

											  -- BLOOD_TYPE
-- Updating the Blood_Type containing "blanks" to "Unknown"
UPDATE clone_healthcare
SET Blood_Type = "Unknown"
WHERE Blood_Type =  "";

											-- EDUCATION_LEVEL
-- Updating the Education_Level containing "blanks" to NULL
-- Formatting the data type TO "VARCHAR"
UPDATE clone_healthcare
SET Education_Level = "Unknown"
WHERE Education_Level =  NULL;
UPDATE clone_healthcare
SET Education_Level = "Masters"
WHERE Education_Level =  "Master's";
UPDATE clone_healthcare
SET Education_Level = "Bachelor"
WHERE Education_Level =  "Bachelor's";
ALTER TABLE clone_healthcare
MODIFY Education_level VARCHAR(30);

									-- SALARY & SALARY_DESCRIPTION COLUMN
-- I created another column to move the "Salary_Description"
-- Fixing the datatype of the salary_Description to "VARCHAR"
ALTER TABLE clone_healthcare
ADD COLUMN Salary_Description VARCHAR(40) AFTER Salary;
-- Clean the salary by removing "$","(",")" and fixing the minus "-"
UPDATE clone_healthcare
SET Salary = REPLACE(REPLACE(REPLACE(REPLACE(SUBSTRING_INDEX(Salary," ", 1),"(","-"),")",""),"$",""),",","");
-- I replace the "Missing" with "NULL"
UPDATE clone_healthcare
SET Salary = null
WHERE Salary = "Missing";
-- Fixing the datatype of the salary to "INT"
ALTER TABLE clone_healthcare
MODIFY Salary INT;
-- Cleaning the record of the salary_Description by removing "(",")"
UPDATE clone_healthcare
SET Salary_Description = REPLACE(REPLACE(SUBSTRING(Salary,LOCATE(" ", SALARY)),"(",""),")","");

											-- HEALTH_CONDITION
-- Cleaned the column by replacing "blanks" with "Unknown", "Excellent (?!)" with "Excellent"
-- Modified the Health_condition TO "VARCHAR"
UPDATE clone_healthcare
SET Health_condition = "Unkown"
WHERE Health_condition = "";
UPDATE clone_healthcare
SET Health_condition = "Excellent"
WHERE Health_condition = "Excellent (?!)";
ALTER TABLE clone_healthcare
MODIFY Health_condition VARCHAR(40);

											  -- CREDIT_SCORE
-- Modifying "N/A" to "Not Available", "380 (Type)" to "380"
UPDATE clone_healthcare
SET Credit_score = 380
WHERE Credit_score = "380 (Typo)";
UPDATE clone_healthcare
SET Credit_score = "Not Available"
WHERE Credit_score = "N/A";

										  -- DATE_OF_SUBMISSION
-- CASE 1: To change excel serial date to normal date structure e.g "43647" TO "2024-01-01"
-- CASE 2: To retain those in the normal data structure "2023-01-31"
-- CASE 3/ELSE : format "Wednesday, January 31, 2024" TO "2024-01-31"
UPDATE clone_healthcare
SET Date_of_admission = CASE
        WHEN Date_of_admission REGEXP '^[0-9]+$' /*OR '^[0-9]{5}$'*/  THEN DATE_ADD('1900-01-01', INTERVAL (Date_of_admission - 2) DAY)
        WHEN Date_of_admission REGEXP '^[0-9]{4}-[0-9]{2}-[0-9]{2}$' THEN Date_of_admission
        ELSE 
            STR_TO_DATE(Date_of_admission, '%W, %M %d, %Y')
						END;
ALTER TABLE clone_healthcare
MODIFY Date_of_admission DATE;	
                        
SELECT *
FROM clone_healthcare;
DESC clone_healthcare;

				## Identify cities or demographics with higher healthcare needs based on health conditions and admission dates.
SELECT City, Health_condition, Date_of_admission
FROM clone_healthcare
WHERE Health_condition = "Poor" OR Health_condition = "Average";

