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

