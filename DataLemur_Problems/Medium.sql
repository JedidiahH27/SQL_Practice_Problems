------------------------------------------------------------------------------------------------

https://datalemur.com/questions/sql-third-transaction

WITH order_of_transactions AS (
SELECT *, 
       ROW_NUMBER() OVER(PARTITION BY user_id ORDER BY transaction_date) AS order_number
FROM transactions
)

SELECT user_id, 
       spend, 
       transaction_date
FROM order_of_transactions
WHERE order_number = 3;

------------------------------------------------------------------------------------------------

https://datalemur.com/questions/sql-second-highest-salary

SELECT DISTINCT salary AS second_highest_salary
FROM employee
ORDER BY salary DESC
LIMIT 1
OFFSET 1

------------------------------------------------------------------------------------------------
