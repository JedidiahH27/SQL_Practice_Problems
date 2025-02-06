---------------------------------------------------------------------------------------------------------------------------
https://platform.stratascratch.com/coding/9728-inspections-that-resulted-in-violations?code_type=1

SELECT EXTRACT(YEAR FROM inspection_date) AS inspection_year,
       COUNT(*) AS n_violations
FROM sf_restaurant_health_violations
WHERE violation_id IS NOT NULL AND business_name = 'Roxanne Cafe'
GROUP BY EXTRACT(YEAR FROM inspection_date)
ORDER BY inspection_year;

---------------------------------------------------------------------------------------------------------------------------

https://platform.stratascratch.com/coding/9845-find-the-number-of-employees-working-in-the-admin-department?code_type=1

SELECT COUNT(*) AS n_admins 
FROM worker
WHERE EXTRACT(MONTH FROM joining_date) >= 4 AND 
      department = 'Admin';

---------------------------------------------------------------------------------------------------------------------------

https://platform.stratascratch.com/coding/9847-find-the-number-of-workers-by-department?code_type=1
       
SELECT department, 
       COUNT(*) AS n_workers
FROM worker
WHERE (EXTRACT(YEAR FROM joining_date) = 2014 AND
      EXTRACT(MONTH FROM joining_date) >= 4) OR 
      EXTRACT(YEAR FROM joining_date) >= 2015
GROUP BY department
ORDER BY n_workers DESC

---------------------------------------------------------------------------------------------------------------------------

https://platform.stratascratch.com/coding/9871-highly-reviewed-hotels?code_type=1
       
SELECT hotel_name, 
       total_number_of_reviews 
FROM hotel_reviews
GROUP BY hotel_name, 
         total_number_of_reviews
ORDER BY total_number_of_reviews DESC;

---------------------------------------------------------------------------------------------------------------------------

https://platform.stratascratch.com/coding/9891-customer-details?code_type=1

SELECT c.first_name, 
       c.last_name,
       c.city,
       o.order_details
FROM customers AS c
LEFT JOIN orders AS o ON c.id = o.cust_id
ORDER BY c.first_name, o.order_details;

---------------------------------------------------------------------------------------------------------------------------

https://platform.stratascratch.com/coding/9913-order-details?code_type=1

SELECT c.first_name,
       o.order_date,
       o.order_details,
       o.total_order_cost 
FROM customers AS c
INNER JOIN orders AS o ON c.id = o.cust_id
WHERE c.first_name = 'Jill' OR 
      c.first_name = 'Eva'
ORDER BY c.id;

---------------------------------------------------------------------------------------------------------------------------

https://platform.stratascratch.com/coding/9917-average-salaries?code_type=1

WITH average_salaries AS (
    SELECT department, 
           AVG(salary) AS avg_salary
    FROM employee
    GROUP BY department
)

SELECT e.department, 
       e.first_name, 
       e.salary, 
       a.avg_salary  
FROM employee AS e
INNER JOIN average_salaries AS a ON e.department = a.department
ORDER BY department;

---------------------------------------------------------------------------------------------------------------------------

https://platform.stratascratch.com/coding/9924-find-libraries-who-havent-provided-the-email-address-in-2016-but-their-notice-preference-definition-is-set-to-email?code_type=1

SELECT DISTINCT home_library_code 
FROM library_usage
WHERE circulation_active_year = 2016 AND
      notice_preference_definition = 'email' AND
      provided_email_address = 'FALSE';

---------------------------------------------------------------------------------------------------------------------------

https://platform.stratascratch.com/coding/9972-find-the-base-pay-for-police-captains?code_type=1

SELECT employeename, 
       basepay 
FROM sf_public_salaries
WHERE jobtitle = 'CAPTAIN III (POLICE DEPARTMENT)';

---------------------------------------------------------------------------------------------------------------------------

https://platform.stratascratch.com/coding/9992-find-artists-that-have-been-on-spotify-the-most-number-of-times?code_type=1

SELECT artist, 
       COUNT(*) AS n_occurences
FROM spotify_worldwide_daily_song_ranking
GROUP BY artist
ORDER BY n_occurences DESC;

---------------------------------------------------------------------------------------------------------------------------
