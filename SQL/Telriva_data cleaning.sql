--checking data loaded properly
SELECT COUNT(*) AS total_rows FROM churn_analysis

--create clean table for analysis
SELECT *
INTO Clean_churn_analysis
FROM churn_analysis

--Checking table similarity
SELECT COUNT(*) AS total_rows
FROM Clean_churn_analysis


--Data exploration

--checking that table contains valid fields to answer business questions
SELECT TOP 10 *
FROM Clean_churn_analysis

--checking data types
SELECT COLUMN_NAME, DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'Clean_churn_analysis'

--adjusting  quarter column data type because it was set as 'money' data type
ALTER TABLE Clean_churn_analysis
ALTER COLUMN Quarter NVARCHAR(10)

--recheck
SELECT COLUMN_NAME, DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'Clean_churn_analysis'


--checking for nulls in data

SELECT 
--demographics
	COUNT(*)- COUNT(Customer_id) AS customer_null,
	COUNT(*)- COUNT(Gender) AS gender_null,
	COUNT(*)- COUNT(Age) AS age_null,
	COUNT(*)- COUNT(Under_30) AS under30_null,
	COUNT(*)- COUNT(Senior_Citizen) AS seniorm_null,
	COUNT(*)- COUNT(Married) AS married_null,
	COUNT(*)- COUNT(Dependents) AS dependents_null,
	COUNT(*)- COUNT(Number_of_Dependents) AS dependentnumber_null,

	--Location
	COUNT(*)- COUNT(Country) AS country_null,
	COUNT(*)- COUNT(State) AS state_null,
	COUNT(*)- COUNT(City) AS city_null,
	COUNT(*)- COUNT(Zip_Code) AS zipcode_null,
	COUNT(*)- COUNT(Latitude) AS latitude_null,
	COUNT(*)- COUNT(Longitude) AS longitude_null,
	COUNT(*)- COUNT(Population) AS population_null,

	--year section
	COUNT(*)- COUNT(Quarter) AS quarter_null,

	--loyalty
	COUNT(*)- COUNT(Referred_a_Friend) AS referral1_null,
	COUNT(*)- COUNT(Number_of_Referrals) AS refrerralnum_null,
	COUNT(*)- COUNT(Tenure_in_Months) AS tenure_null,
	COUNT(*)- COUNT(Offer) AS offer_null,

	--account information
	COUNT(*)- COUNT(Phone_Service) AS phoneservice_null,
	COUNT(*)- COUNT(Avg_Monthly_Long_Distance_Charges) AS charges_null,
	COUNT(*)- COUNT(Multiple_Lines) AS multiplelines_null,
	COUNT(*)- COUNT(Internet_Service) AS service_null,
	COUNT(*)- COUNT(Internet_Type) AS type_null,
	COUNT(*)- COUNT(Avg_Monthly_GB_Download) AS download_null,
	COUNT(*)- COUNT(Online_Security) AS security_null,
	COUNT(*)- COUNT(Online_Backup) AS backup_null,
	COUNT(*)- COUNT(Device_Protection_Plan) AS plan_null,
	COUNT(*)- COUNT(Premium_Tech_Support) AS support_null,

	--streaming
	COUNT(*)- COUNT(Streaming_TV) AS Streamingtv_null,
	COUNT(*)- COUNT(Streaming_Music) AS StreamingMusic_null,
	COUNT(*)- COUNT(Streaming_Movies) AS StreamingMovies_null,
	COUNT(*)- COUNT(Unlimited_Data) AS unlimitedData_null,
	COUNT(*)- COUNT(Contract) AS Contract_null,
	COUNT(*)- COUNT(Paperless_Billing) AS PaperlessBilling_null,
	COUNT(*)- COUNT(Payment_Method) AS PaymentMethod_null,
	COUNT(*)- COUNT(Monthly_Charge) AS MonthlyCharge_null,
	COUNT(*)- COUNT(Total_Charges) AS TotalCharges_null,
	COUNT(*)- COUNT(Total_Refunds) AS TotalRefunds_null,
	COUNT(*)- COUNT(Total_Extra_Data_Charges) AS EDataCharges_null,
	COUNT(*)- COUNT(Total_Long_Distance_Charges) AS LongDistanceCharges_null,
	COUNT(*)- COUNT(Total_Revenue) AS Totalrevenue_null,

	--churn 
	COUNT(*)- COUNT(Satisfaction_Score) satisfaction_score_null,
	COUNT(*)- COUNT(Customer_Status) AS CS_null,
	COUNT(*)- COUNT(Churn_Label) AS CL_null,
	COUNT(*)- COUNT(Churn_Score) AS CS_null,
	COUNT(*)- COUNT(CLTV) AS CLTV_null,
	COUNT(*)- COUNT(Churn_Category) AS Category_null,
	COUNT(*)- COUNT(Churn_Reason) AS churnreason_null
FROM Clean_churn_analysis

--churn category and chun reason columns  have nulls present

SELECT 
	Churn_label,
	churn_category,
	churn_reason
FROM Clean_churn_analysis
WHERE Churn_Label='No'
--The customers who stayed have these columns as null
--so it is safe to change null to 'not applicable' as it does not apply to them

--fixing  nulls
UPDATE Clean_churn_analysis
SET Churn_Category='Not applicable'
WHERE Churn_Category IS NULL

UPDATE Clean_churn_analysis
SET Churn_Reason ='Not applicable'
WHERE Churn_Reason IS NULL

-- Checking nulls updated 
SELECT TOP 20 
Churn_category,
Churn_reason
FROM Clean_churn_analysis



--checking for duplicates
SELECT 
	Customer_ID, 
	COUNT(*) AS total_records
FROM Clean_churn_analysis
GROUP BY Customer_ID
HAVING COUNT(*) > 1
--no duplicate customer record  found  as customer ids are distinct 

--checking  primary key constraint
SELECT *
FROM INFORMATION_SCHEMA.CHECK_CONSTRAINTS

--No constraint set

--setting constraint as the granularity of the data is one row per unique customer

--setting it to not null
ALTER TABLE Clean_churn_analysis
ALTER COLUMN Customer_ID NVARCHAR(50) NOT NULL

--setting as primary key
ALTER TABLE Clean_churn_analysis
ADD CONSTRAINT PK_CleanChurn_CustomerID PRIMARY KEY (Customer_ID)

--checking for constraint
SELECT *
FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS

