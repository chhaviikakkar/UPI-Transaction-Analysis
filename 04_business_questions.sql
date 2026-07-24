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
