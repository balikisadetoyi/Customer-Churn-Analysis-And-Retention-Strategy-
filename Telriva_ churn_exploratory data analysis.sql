--Understanding data distribution
SELECT TOP 10 * FROM
Clean_churn_analysis

--Understanding measures in data 
-- Length of stay in months

SELECT
	MAX(Tenure_in_months) AS max_tenure,
	MIN(Tenure_in_months) AS min_tenure,
	AVG(Tenure_in_months) AS avg_tenure,
	STDEV(Tenure_in_months)AS std_tenure
FROM Clean_churn_analysis
--customers have an overall length of stay that spans   between 1 month to 6 years   
--with  an average tenure of 32 months.
--However, the mean and std are far apart indicating data skewness

--calculating median
SELECT 
PERCENTILE_CONT(0.5)
	WITHIN GROUP (
	ORDER BY Tenure_in_months) 
		OVER() AS median_tenure
FROM Clean_churn_analysis
--customers have a median of 29 months.
--mean of 32 and median of 29 indicate few customers have stayed  longer compared to others which is why the mean is high(right skewness) . 
--the median reflects the actual overall average tenure of customers.


--Age distribution
SELECT
	MAX(Age) AS max_age,
	MIN(Age) AS min_age,
	AVG(Age) AS avg_age,
	STDEV(Age) AS std_age
FROM Clean_churn_analysis

--customers are aged between 19 and 80 years with the average age being 46


-- Monthly charges
SELECT
	MAX(Monthly_Charge) AS max_monthlycharge,
	MIN(Monthly_Charge) AS min_monthlycharge,
	AVG(Monthly_Charge) AS avg_monthlycharge,
	STDEV(Monthly_Charge) AS std_monthlycharge
FROM Clean_churn_analysis
--MEDIAN
SELECT
	PERCENTILE_CONT(0.5)
	WITHIN GROUP (ORDER BY Monthly_charge) OVER() AS median_monthlycharge
FROM Clean_churn_analysis
-- Customers pay between $18.25 and $118.75 per month
-- The average charge is $64 however ,the median of $70 is higher than the average 
-- indicating few customers are on extremely low charges causing a  left skew 
-- and are pulling the average downwards
-- Std of  confirms 30 indicates a moderate spread around the average 




--Total charges
SELECT
	MAX(Total_Charges) AS max_Total_Charges,
	MIN(Total_Charges) AS min_Total_Charges,
	AVG(Total_Charges) AS avg_Total_Charges,
	STDEV(Total_Charges) AS std_Total_Charges
FROM Clean_churn_analysis

--median
SELECT
	PERCENTILE_CONT(0.5)
	WITHIN GROUP (ORDER BY Total_charges) OVER() AS median_totalcharges
FROM Clean_churn_analysis
--customers have paid between $ 18  and $8,685 in total charges
-- with an average of $2,280 and a median of $1,395. This revealed 
-- a few customers have paid extremely high charges compared to others(right skewness).
-- standard deviation of $2,266 indicates customer total charges are far apart from the average.

--total revenue
SELECT
	MAX(Total_Revenue) AS max_Revenue,
	MIN(Total_Revenue) AS min_Revenue,
	AVG(Total_Revenue) AS avg_Revenue,
	STDEV(Total_Revenue) AS std_Revenue
FROM Clean_churn_analysis
--median
SELECT
	PERCENTILE_CONT(0.5)
	WITHIN GROUP (ORDER BY Total_revenue) OVER() AS median_TOTALREVENUE
FROM Clean_churn_analysis

--company has   generated between $21 and $ 11,979 per customer
--with an average of $3,034 per customer and median of  $2,109
--This indicates a few customers are more profitable than others and are pulling the
--average upward(right skew).
-- a standard deviation of $2,865 also indicate that the revenue per customer are far apart from the average.
--this is worth investigating as to see which customers are profitable and in what sense.
--This will be investigated  further to determine whether high revenue customers 
--are more or less likely to churn and what they have in common.


--number of referrals 
SELECT
	MAX(Number_of_Referrals) AS max_referral,
	MIN(Number_of_Referrals) AS min_referral,
	AVG(Number_of_Referrals) AS avg_referral,
	STDEV(Number_of_Referrals) AS std_referral
FROM Clean_churn_analysis
--median

SELECT
	PERCENTILE_CONT(0.5)
	WITHIN GROUP (ORDER BY number_of_referrals) OVER() AS median_referrals
FROM Clean_churn_analysis

--customers have referred a max of 11 persons 
--with an average referral of 1 and a median of 0 indicates that more than half the customers
--do not engage in the referral program
-- std of 3 indicates a wide spread amongst the number of referrals.


--extra data charges
SELECT 
	MAX(Total_Extra_Data_Charges) AS max_extracharge ,
	MIN(Total_Extra_Data_Charges) AS min_extracharge,
	AVG(Total_Extra_Data_Charges) AS avg_extracharge,
	STDEV(Total_Extra_Data_Charges) AS std_extracharge      
FROM Clean_churn_analysis

--median
SELECT
	PERCENTILE_CONT(0.5)
	WITHIN GROUP (ORDER BY Total_Extra_Data_Charges) OVER() AS median_extracharges
FROM Clean_churn_analysis

--customers are charged a  maximum of $150 for extra data usage
--with an average of $6 charge and standard deviation of $25,
--it indicates most customers either do not use extra data or pay way less for it and the charges are very far apart for customers
----a median of 0 indicates most customers do not pay the extra charges  

--satisfaction score
SELECT 
	MAX(satisfaction_score) AS max_score ,
	MIN(Satisfaction_Score) AS min_score,
	AVG(Satisfaction_Score) AS avg_score,
	STDEV(Satisfaction_Score) AS std_score      
FROM Clean_churn_analysis

-- Customers rated service between 1 and 5
-- The average satisfaction score is 3 indicating neutral or  moderate satisfaction
-- A standard deviation of 1 indicates ratings are closely clustered around the average 
-- This average rating score suggests that there is  room to improve customer satisfaction


--understanding dimensions in data(Categories)

--churn label

SELECT
	Churn_label,
	COUNT(*) AS total_customers,
	ROUND(COUNT(*)*100.0/SUM(COUNT(*)) OVER(),1) AS percnt
FROM Clean_churn_analysis
GROUP BY Churn_Label
--  The overall churn rate is 26.5%.This indicates that  approximately 1 in 4 customers 
-- have left the business. This requires immediate attention   
--and  a need to implement rentention strategies .
-- 73.5% of customers have been retained.

--payment methods 
SELECT
	Payment_method,
	COUNT(*) AS total,
	ROUND(COUNT(*)*100.0/SUM(COUNT(*)) OVER(),1) AS percnt
FROM Clean_churn_analysis
GROUP BY Payment_Method

--  Bank withdrawals at 55.5% suggests most customers 
-- are comfortable with automated digital payments and also  indicates  a relatively 
-- tech oriented  customer base.
-- Mailed check at 5.5% is the least preferred method and may be associated 
-- with older customers less comfortable with digital services.


--Contract
SELECT
	Contract,
	COUNT(*) AS total,
	ROUND(COUNT(*)*100.0/SUM(COUNT(*)) OVER(),1) AS percnt
FROM Clean_churn_analysis
GROUP BY Contract
--51.3% of customers opted in for monthly contract 
--which may indicate many don't want to commit long term 
--22% of customers are on yearly contract and 26.7% on 2 year contracts 
--This relates to churn risk because a customer 
--who doesnt have long term contracts is likely to churn




--internet type
SELECT
	Internet_Type,
	COUNT(*) AS total,
	ROUND(COUNT(*)*100.0/SUM(COUNT(*)) OVER(),1) AS percnt
FROM Clean_churn_analysis
GROUP BY Internet_Type
--Fiber optic is the major type of internet preferred by customers with 43.1% of customers on it.
--DSL has 23.5% of customers and cable has 11.8%
--however, 21.7% of customers did not opt in for internet service
--this is what worth investigating  as almost 1 in 4 customers 
--do not use the company's internet service and may be at higher churn risk




--offers
SELECT
	Offer,
	COUNT(*) AS total,
	ROUND(COUNT(*)*100.0/SUM(COUNT(*)) OVER(),1) AS percnt
FROM Clean_churn_analysis
GROUP BY Offer

--55% of customers are not on any promotional offer.This maybe a churn risk and indicates the company 
--is not engaging customers in this aspect.
--while 45% are on offers ranging from A to E. 



--city
SELECT
	City,
	COUNT(*) AS total,
	ROUND(COUNT(*)*100.0/SUM(COUNT(*)) OVER(),1) AS percnt
FROM Clean_churn_analysis
GROUP BY City
ORDER BY COUNT(*) DESC

-- Company operates across 1,000+ cities in California
-- Los Angeles is the largest customer base at 4.2% 
-- followed by San Diego at 4%
-- Customer distribution is highly fragmented across hundreds of cities


--gender
SELECT
	Gender,
	COUNT(*) AS total,
	ROUND(COUNT(*)*100.0/SUM(COUNT(*)) OVER(),1) AS percnt
FROM Clean_churn_analysis
GROUP BY Gender
---the company has 50.5% male customers and 49.5% female customers
--nearly equal split means it is not a churn risk factor

--Age bands 
--under 30 (age) 

SELECT
	Under_30,
	COUNT(*) AS total,
	ROUND(COUNT(*)*100.0/SUM(COUNT(*)) OVER(),1) AS percnt
FROM Clean_churn_analysis
GROUP BY Under_30

--senior citizen  (age 65+)
SELECT
	Senior_Citizen,
	COUNT(*) AS total,
	ROUND(COUNT(*)*100.0/SUM(COUNT(*)) OVER(),1) AS percnt
FROM Clean_churn_analysis
GROUP BY Senior_Citizen;

--19.9% of customers are young adults under the age of 30 while 16.2% are senior citizens over 65 years old
-- the concentrtion of customers are between the ages of 30 and 65 with 63.9%
--This means that majority of the company's customer base are within this range 

--checking relationships


--Gender vs churn rate
With gender_churnrate AS (SELECT
	Gender,
	COUNT(Customer_ID) AS total_churned 
FROM Clean_churn_analysis
WHERE Churn_Label='Yes'
GROUP BY Gender),

overall_churned_customers AS (
SELECT
	Gender,
	COUNT(Customer_ID) AS total_customers
FROM Clean_churn_analysis
GROUP BY Gender)

SELECT G.Gender,
G.total_churned * 100.0/O.total_customers AS gender_churnrate

FROM gender_churnrate AS G
JOIN overall_churned_customers AS O
ON G.Gender=O.Gender;

--both male hand female genders have an almost similar churn rate of
--26.1% and 26.9% respectively
--This indicates risk is not gender dependent 


--senior citizen vs churn rate

WITH Seniorcitizen_churn AS(
SELECT 
	Senior_Citizen,
	COUNT(*) AS total_seniors
FROM Clean_churn_analysis
WHERE Churn_Label='Yes' 
GROUP BY Senior_Citizen),
overall_churned_customers AS (
SELECT
	Senior_Citizen,
	COUNT(Customer_ID) AS total_customers
FROM Clean_churn_analysis
GROUP BY Senior_Citizen)

SELECT S.senior_citizen,
S.total_seniors* 100.0/O.total_customers AS seniorcitizen_churnrate
FROM Seniorcitizen_churn AS S
JOIN overall_churned_customers AS O
ON S.Senior_Citizen=O.Senior_Citizen;
-- 41.7% of senior citizens (65+) have churned compared to the overall churn rate of 26.5%
-- This is 15% above the company average indicating senior citizens 
-- are significantly more likely to churn than other age groups
-- and  require targeted retention strategies for this demographic


--under 30
WITH under30_churn AS(
SELECT 
	Under_30,
	COUNT(*) AS total_under30
FROM Clean_churn_analysis
WHERE Churn_Label='Yes' 
GROUP BY Under_30),

overall_churned_customers AS (
SELECT
	Under_30,
	COUNT(Customer_ID) AS total_customers
FROM Clean_churn_analysis
GROUP BY Under_30)

SELECT S.under_30,
S.total_under30 * 100.0/O.total_customers AS under30_churnrate
FROM under30_churn AS S
JOIN overall_churned_customers AS O
ON S.Under_30=O.Under_30;
-- 21.6% of customers under 30 have churned which is below the overall churn rate of 26.5%
-- This suggests younger customers are slightly more loyal than the average customer



--City vs churnrate
WITH City_churnrate AS (
SELECT
	City,
	COUNT(Customer_ID) AS total_city
FROM Clean_churn_analysis
WHERE Churn_Label='Yes'
GROUP BY City
HAVING COUNT(Customer_ID) > 30),

overall_churned_customers AS (
SELECT
City,
	COUNT(Customer_ID) AS total_customers
FROM Clean_churn_analysis
GROUP BY City)

SELECT 
	C.City,
	total_city * 100.0/total_customers AS city_churnrate
FROM City_churnrate AS C
JOIN overall_churned_customers AS O
ON C.City=O.City
ORDER BY city_churnrate DESC;

--The cities with customers greater than 30 were considered for this analysis as some cities
--with very snall customers would not show the actual picture of what is happening
-- San Diego has the highest churn rate of 64.9%, which is more than double  the overall churn rate for customers
--San Franscisco has a churn rate of 29.8% and Los Angeles 26.6%. 
--This indicates churn rate is concenrated in certain cities.


--Tenure vs churn rate
WITH tenure_churnrate AS (
SELECT 
	CASE 
	WHEN Tenure_in_months BETWEEN 0 AND 12 THEN 'New customers'
	WHEN Tenure_in_Months BETWEEN 13 AND 24 THEN'Early stage'
	WHEN Tenure_in_Months BETWEEN 25 AND 48 THEN'Mid tenure'
	ELSE 'Long term'
	END AS Tenure_bands ,
	COUNT(Customer_ID) AS total
FROM Clean_churn_analysis
WHERE Churn_Label='Yes'
GROUP BY 
	CASE 
WHEN Tenure_in_months BETWEEN 0 AND 12 THEN 'New customers'
WHEN Tenure_in_Months BETWEEN 13 AND 24 THEN'Early stage'
WHEN Tenure_in_Months BETWEEN 25 AND 48 THEN'Mid tenure'
ELSE 'Long term'
END ),

overall_churned_customers AS (
SELECT
CASE 
	WHEN Tenure_in_months BETWEEN 0 AND 12 THEN 'New customers'
	WHEN Tenure_in_Months BETWEEN 13 AND 24 THEN'Early stage'
	WHEN Tenure_in_Months BETWEEN 25 AND 48 THEN'Mid tenure'
	ELSE 'Long term'
	END AS Tenure_bands ,
	COUNT(Customer_ID) AS total_customers
FROM Clean_churn_analysis
GROUP BY CASE 
	WHEN Tenure_in_months BETWEEN 0 AND 12 THEN 'New customers'
	WHEN Tenure_in_Months BETWEEN 13 AND 24 THEN'Early stage'
	WHEN Tenure_in_Months BETWEEN 25 AND 48 THEN'Mid tenure'
	ELSE 'Long term'
	END)

	SELECT 
		T.Tenure_bands,
		total * 100.0/total_customers AS tenure_churnrate
	FROM tenure_churnrate  AS T
	JOIN overall_churned_customers AS O
	ON T.Tenure_bands=O.Tenure_bands;

--47.4 % of customers who are new to the company have churned followed by
--28.7% of customers in the early stages , 20.3% in the mid stage 
-- and  9.5% of long term customers have churned as well
--this could be attributed to the quality of service received and unpleasant experience 
--Churn rate decreases significantly as customer tenure increases 
--new customers are at highest risk while long term customers show strong loyalty. 


--offers vs churn rate 
WITH Offers_cte AS (
SELECT Offer,
COUNT(Customer_ID) AS total_customersoffer
FROM Clean_churn_analysis
WHERE Churn_Label ='Yes'
GROUP BY Offer)
,
overall_churned_customers AS (
SELECT
Offer,
	COUNT(Customer_ID) AS total_customers
FROM Clean_churn_analysis
GROUP BY Offer)

SELECT O.Offer,
O.total_customersoffer * 100.0/C.total_customers AS Offer_churnrate
FROM  Offers_cte AS O
JOIN overall_churned_customers AS C
ON O.Offer=C.Offer
ORDER BY Offer_churnrate DESC;
--52.9% OF customers on offer E Have churned 
--with 26.7% on offer D,22.8% on offer C,12.3% ON B and 6.7% on A 
-- despite having promotional offers, customers are still leaving
--Offer A has the lowest churn rate at 6.7% suggesting it provides the most value or 
--attracts more loyal customers
--while Offer E appears ineffective at retaining customers with a churn rate double the company average.
--Also, 27.1% of customers who are not on any offer have also left the company.




--Contract type vs churnrate
WITH Contract_type_CTE AS (
SELECT
	Contract,
	COUNT(Customer_ID) AS total_contracts
FROM Clean_churn_analysis
WHERE Churn_Label='Yes'
GROUP BY Contract
),
overall_churned_customers AS (
SELECT
Contract,
	COUNT(Customer_ID) AS total_customers
FROM Clean_churn_analysis
GROUP BY Contract)

SELECT C.Contract,
C.total_contracts *100.0/O.total_customers AS contracttype_churnrate
FROM Contract_type_CTE AS C
JOIN overall_churned_customers AS O
ON C.Contract=O.Contract;

--45.8% of customers on monthly contracts have churned
--which indicates customers who do not commit long term are more likely to churn as seen in tenure 
-- 10.7% on one year contracts and 2.5% on two year contract have churned as well
--the longer the contract, the less likely the possibility of leaving


--Internet type vs churnrate
WITH Internet_type_CTE AS (

SELECT 
	Internet_Type,
	COUNT(Customer_ID) AS total_internet_type
FROM Clean_churn_analysis
WHERE Churn_Label='Yes'
GROUP BY Internet_Type)
,
overall_churned_customers AS (
SELECT
Internet_Type,
	COUNT(Customer_ID) AS total_customers
FROM Clean_churn_analysis
GROUP BY Internet_Type)

SELECT
	I.Internet_Type,
I.total_internet_type * 100.0/ o.total_customers AS internetype_churnrate
FROM Internet_type_CTE AS I
JOIN overall_churned_customers AS O
ON i.Internet_Type=O.Internet_Type;
--40.7% of customers on fiber optic have churned which is 14% abve the
--overall churn rate 
--with 25.66% on cable and 18.6% on DSL also left the company
--This is worth investigating to determine the quality of internet provided
--on the contrary 7.4% of customers not using the internet service have also churned

--monthly charges vs churn rate 

WITH Monthly_chargesCTE AS (
SELECT
CASE 
	WHEN Monthly_Charge < 30 THEN 'Low'
	WHEN Monthly_Charge < 60 THEN 'Medium'
	WHEN Monthly_Charge < 90 THEN 'High'
	WHEN Monthly_Charge < 120 THEN 'Very High'
ELSE 'Extremely High'
	END AS monthlycharge_bands ,
	COUNT(Customer_ID) AS total_customers_churn 
FROM Clean_churn_analysis
WHERE Churn_Label='Yes'
GROUP BY
	CASE 
	WHEN Monthly_Charge < 30 THEN 'Low'
	WHEN Monthly_Charge < 60 THEN 'Medium'
	WHEN Monthly_Charge < 90 THEN 'High'
	WHEN Monthly_Charge < 120 THEN 'Very High'
ELSE 'Extremely High'
	END)
	,

	overall_churned_customers AS (
SELECT
CASE 
	WHEN Monthly_Charge < 30 THEN 'Low'
	WHEN Monthly_Charge < 60 THEN 'Medium'
	WHEN Monthly_Charge < 90 THEN 'High'
	WHEN Monthly_Charge < 120 THEN 'Very High'
ELSE 'Extremely High'
	END AS monthlycharge_bands,
	COUNT(Customer_ID) AS total_customers
FROM Clean_churn_analysis
GROUP BY 
	CASE 
		WHEN Monthly_Charge < 30 THEN 'Low'
		WHEN Monthly_Charge < 60 THEN 'Medium'
		WHEN Monthly_Charge < 90 THEN 'High'
		WHEN Monthly_Charge < 120 THEN 'Very High'
	ELSE 'Extremely High'
	END)

SELECT 
 M.monthlycharge_bands,
 M.total_customers_churn *100.0/ O.total_customers AS monthlycharge_churnrate
 FROM Monthly_chargesCTE AS M
 JOIN overall_churned_customers AS O
 ON M.monthlycharge_bands=O.monthlycharge_bands
 --Customers who pay high and very high charges have the highest churn rates of 
 --33.7% and 32.8% respectively. This indicates that the higher customers pay for service the more likely
 --are they to leave the business
 --customers paying medium charges have a rate of 33.7% and 9.8% of those on low charges have left the business
 --This indicates the business is losing customers high contributing customers 


 
 --Other services offered vs churn rate

 SELECT 
 --online secuity
	 SUM(CASE WHEN Online_Security =1 AND Churn_Label='YES' THEN 1 ELSE 0 END ) * 100.0/ SUM(CASE WHEN Online_Security =1 THEN 1 ELSE 0 END )AS Online_security_churnrate,
	 --online backup
	 SUM(CASE WHEN Online_Backup =1 AND Churn_Label='YES' THEN 1 ELSE 0 END ) * 100.0/ SUM(CASE WHEN Online_Backup =1 THEN 1 ELSE 0 END )AS Online_backup_churnrate,
	 --device protection
	 SUM(CASE WHEN Device_Protection_Plan =1 AND Churn_Label='YES' THEN 1 ELSE 0 END ) * 100.0/ SUM(CASE WHEN Device_Protection_Plan =1 THEN 1 ELSE 0 END )AS deviceprotection_churnrate,
	 --premiun tech support
	 SUM(CASE WHEN Premium_Tech_Support =1 AND Churn_Label='YES' THEN 1 ELSE 0 END ) * 100.0/ SUM(CASE WHEN Premium_Tech_Support =1 THEN 1 ELSE 0 END )AS premiumtechsupport_churnrate,
	 --streaming tv
	 SUM(CASE WHEN Streaming_TV =1 AND Churn_Label='YES' THEN 1 ELSE 0 END ) * 100.0/ SUM(CASE WHEN Streaming_TV =1 THEN 1 ELSE 0 END )AS Streamtv_churnrate,
	 --streaming movies
	 SUM(CASE WHEN Streaming_Movies =1 AND Churn_Label='YES' THEN 1 ELSE 0 END ) * 100.0/ SUM(CASE WHEN Streaming_Movies =1 THEN 1 ELSE 0 END )AS stream_movies_churnrate,
	 --streaming music
	 SUM(CASE WHEN Streaming_Music =1 AND Churn_Label='YES' THEN 1 ELSE 0 END ) * 100.0/ SUM(CASE WHEN Streaming_Music =1 THEN 1 ELSE 0 END )AS stream_music_churnrate,
	 --unlimited data
	 SUM(CASE WHEN Unlimited_Data =1 AND Churn_Label='YES' THEN 1 ELSE 0 END ) * 100.0/ SUM(CASE WHEN Unlimited_Data =1 THEN 1 ELSE 0 END )AS unlimited_data_churnrate,
	 --multiple lines
	 SUM(CASE WHEN Multiple_Lines =1 AND Churn_Label='YES' THEN 1 ELSE 0 END ) * 100.0/ SUM(CASE WHEN Multiple_Lines =1 THEN 1 ELSE 0 END )AS multiplelines_churnrate,
	 --phone service
	 SUM(CASE WHEN Phone_Service =1 AND Churn_Label='YES' THEN 1 ELSE 0 END ) * 100.0/ SUM(CASE WHEN Phone_Service =1 THEN 1 ELSE 0 END )AS phone_service_churnrate	 
 FROM Clean_churn_analysis
 --Online Security and Premium Tech Support have significantly lower churn rates and  suggest these extra services  increase customer loyalty
--Streaming services, unlimited data and multiple lines all have churn rates above the overall average. These are not driving retention
--The gap between security and support services  at around 15% and streaming services at around 30% is a meaningful pattern

--referralls vs churn rate

SELECT 
SUM(CASE WHEN
	Referred_a_Friend =1 AND Churn_label='Yes' THEN 1 ELSE 0 END) * 100.0/
SUM (CASE WHEN 
	Referred_a_Friend =1 THEN 1 ELSE 0 END) AS referrals_churnrate,
SUM(CASE WHEN
	Referred_a_Friend =0 AND Churn_label='Yes' THEN 1 ELSE 0 END) * 100.0/
SUM (CASE WHEN 
	Referred_a_Friend =0 THEN 1 ELSE 0 END) AS No_referrals_churnrate
FROM Clean_churn_analysis
--19.3% of customers who joined the referral program have churned.
--32.5% of customers who are not on the referral program have also left the business
--13% gap between referred and non referred customers 
-- suggests the referral programme is  an effective retention tool but 
-- only a minority of customers are currently engaged with it  