-- Answering Business Questions--
/*=========================================================
Q1. What percentage of UPI transactions are successful?
=========================================================*/
SELECT transaction_status,
       number_of_transactions,
       total_transactions,
       CAST (number_of_transactions AS FLOAT) / total_transactions * 100 AS percentage
FROM   (SELECT   transaction_status,
                 COUNT(*) AS number_of_transactions,
                 SUM(COUNT(*)) OVER () AS total_transactions
        FROM     gold.fact_transactions
        GROUP BY transaction_status) AS t;
/*========================================================
Q2. At what hours do users make the most transactions?
=========================================================*/
SELECT
CONCAT(DATEPART(HOUR,transaction_time),':00 - ',DATEPART(HOUR,transaction_time)+1,':00') hour_of_transaction,
COUNT (*) AS number_of_transactions
FROM gold.fact_transactions
GROUP BY DATEPART(HOUR,transaction_time)
ORDER BY number_of_transactions DESC
/*========================================================
Q3. What are the most common transaction failure reasons?
=========================================================*/
SELECT 
failure_reason,
COUNT(*) number_of_transactions
FROM gold.fact_transactions
WHERE failure_reason <> 'N/A'
GROUP BY failure_reason
ORDER BY number_of_transactions DESC
/*========================================================
Q4. Which 3 PSPs process the highest number of successful
transactions?
=========================================================*/
WITH cte_transactions AS(
SELECT 
t.transaction_key,
t.transaction_id,
t.transaction_date,
t.transaction_time,
t.user_key,
t.recipient_key,
t.merchant_key,
t.transaction_category,
t.psp_key,
p.psp_name,
t.transaction_mode,
t.device_type,
t.amount,
t.transaction_status,
t.failure_reason,
t.response_time
FROM gold.fact_transactions t
LEFT JOIN gold.dim_psp p
ON p.psp_key = t.psp_key)

SELECT TOP 3
psp_name,
COUNT(*) AS total_transactions
FROM cte_transactions
WHERE transaction_status!='Failed' AND transaction_status!='Pending'
GROUP BY psp_name
ORDER BY total_transactions DESC
/*========================================================
Q5. Which PSP has the fastest average response time?
=========================================================*/
WITH cte_psp AS(
SELECT 
t.transaction_key,
t.transaction_id,
t.psp_key,
p.psp_name,
t.response_time
FROM gold.fact_transactions t
LEFT JOIN gold.dim_psp p
ON p.psp_key = t.psp_key)

SELECT TOP 1 
psp_name,
AVG(response_time) avg_response
FROM cte_psp
GROUP BY psp_name
ORDER BY avg_response ASC
/*========================================================
Q6. Which age group performs the most transactions?
=========================================================*/ 
SELECT 
age_group,
COUNT(*) total_transactions
FROM(
SELECT 
t.transaction_key,
t.transaction_id,
t.user_key,
u.name,
CASE
WHEN u.age > 18 AND u.age <= 25 THEN 'Young Adults'
WHEN u.age >= 25 AND u.age <= 39 THEN 'Adults'
WHEN u.age >= 40 AND u.age <=59 THEN 'Middle-Aged Adults'
ELSE 'Senior Citizens' END AS age_group,
t.recipient_key,
t.merchant_key,
t.transaction_category
FROM gold.fact_transactions t
LEFT JOIN gold.dim_users u
ON t.user_key = u.user_key)t
GROUP BY age_group
ORDER BY total_transactions DESC
/*========================================================
Q7. Which merchant categories generate the highest revenue?
=========================================================*/ 
SELECT 
merchant_category,
SUM(amount) AS revenue
FROM(
SELECT 
m.merchant_key,
m.merchant_name,
m.merchant_category,
t.transaction_category,
t.amount 
FROM gold.dim_merchants m
LEFT JOIN gold.fact_transactions t
ON m.merchant_key=t.merchant_key)t
GROUP BY merchant_category
ORDER BY revenue DESC
/*========================================================
Q8. Which device type has the highest failure rate?
=========================================================*/
SELECT *,
ROUND(CAST(no_failed_transactions AS FLOAT)/total_failed * 100,2) failure_rate
FROM(
SELECT 
device_type,
COUNT(*) no_failed_transactions,
SUM(COUNT(*)) OVER() total_failed
FROM gold.fact_transactions
WHERE transaction_status = 'Failed'
GROUP BY device_type)t
/*========================================================
Q9. Which PSP is most popular for P2M transactions?
=========================================================*/
SELECT TOP 1
p.psp_name,
COUNT(transaction_key) total
FROM gold.dim_psp p
LEFT JOIN gold.fact_transactions t
ON p.psp_key = t.psp_key
WHERE transaction_category= 'Person To Merchant'
GROUP BY psp_name
ORDER BY total DESC
/*========================================================
Q10. Who are the top 10 users by transaction value?
=========================================================*/
SELECT TOP 10
t.user_key,
u.name,
SUM(t.amount) transaction_value
FROM gold.fact_transactions t
LEFT JOIN gold.dim_users u
ON u.user_key=t.user_key
GROUP BY t.user_key,u.name
ORDER BY transaction_value DESC
/*========================================================
Q11. How has transaction volume changed month-over-month ?
=========================================================*/
SELECT *,
transaction_volume - prev_month_volume AS MoM_analysis
FROM(
SELECT 
YEAR(transaction_date) AS years,
MONTH(transaction_date) AS months,
DATENAME(MONTH,transaction_date) AS month_name,
COUNT(*) AS transaction_volume,
LAG(COUNT(*)) OVER(ORDER BY YEAR(transaction_date), MONTH(transaction_date)) AS prev_month_volume
FROM gold.fact_transactions
GROUP BY YEAR(transaction_date),MONTH(transaction_date),DATENAME(MONTH,transaction_date))t
/*========================================================
Q12. Which cities have the highest merchant transaction value?
=========================================================*/
SELECT
m.city,
SUM(t.amount) AS transaction_value
FROM gold.fact_transactions t
INNER JOIN gold.dim_merchants m
ON m.merchant_key=t.merchant_key
GROUP BY m.city
ORDER BY transaction_value DESC
