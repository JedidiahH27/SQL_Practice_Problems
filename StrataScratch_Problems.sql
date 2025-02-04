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
