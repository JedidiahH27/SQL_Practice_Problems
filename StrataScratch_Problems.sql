# EASY

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

https://platform.stratascratch.com/coding/10003-lyft-driver-wages?code_type=1

SELECT * 
FROM lyft_drivers
WHERE yearly_salary <= 30000 OR yearly_salary >= 70000;

---------------------------------------------------------------------------------------------------------------------------

https://platform.stratascratch.com/coding/10061-popularity-of-hack?code_type=1

SELECT e.location, 
       AVG(fhs.popularity) AS avg_popularity 
FROM facebook_employees AS e
INNER JOIN facebook_hack_survey AS fhs ON e.id = fhs.employee_id
GROUP BY e.location;

---------------------------------------------------------------------------------------------------------------------------

https://platform.stratascratch.com/coding/10087-find-all-posts-which-were-reacted-to-with-a-heart?code_type=1

SELECT DISTINCT post_id, 
       poster, 
       post_text,
       post_keywords,
       post_date
FROM (SELECT fp.post_id, 
        fp.poster, 
        fp.post_text,
        fp.post_keywords,
        fp.post_date,
        fr.reaction
      FROM facebook_posts AS fp
      INNER JOIN facebook_reactions AS fr ON fr.post_id = fp.post_id) AS sub
WHERE reaction = 'heart'

---------------------------------------------------------------------------------------------------------------------------

https://platform.stratascratch.com/coding/10128-count-the-number-of-movies-that-abigail-breslin-nominated-for-oscar?code_type=1

SELECT COUNT(*) AS n_movies_by_abi
FROM oscar_nominees
WHERE nominee = 'Abigail Breslin';

---------------------------------------------------------------------------------------------------------------------------

https://platform.stratascratch.com/coding/10166-reviews-of-hotel-arena?code_type=1

SELECT hotel_name,
       reviewer_score,
       COUNT(*)
FROM hotel_reviews
WHERE hotel_name = 'Hotel Arena'
GROUP BY reviewer_score, hotel_name;

---------------------------------------------------------------------------------------------------------------------------

https://platform.stratascratch.com/coding/10176-bikes-last-used?code_type=1

SELECT bike_number, 
       MAX(end_time) AS last_used
FROM dc_bikeshare_q1_2012
GROUP BY bike_number
ORDER BY MAX(end_time) DESC;

---------------------------------------------------------------------------------------------------------------------------

https://platform.stratascratch.com/coding/10299-finding-updated-records?code_type=1

SELECT id, 
       first_name, 
       last_name,
       department_id,
       MAX(salary)
FROM ms_employee_salary
GROUP BY 1, 2, 3, 4
ORDER BY id;

---------------------------------------------------------------------------------------------------------------------------

https://platform.stratascratch.com/coding/10308-salaries-differences?code_type=1

WITH cte AS (SELECT db_dept.department, 
             MAX(salary) AS max_salary 
FROM db_employee
LEFT JOIN db_dept ON db_employee.department_id = db_dept.id
GROUP BY db_dept.department
HAVING db_dept.department = 'marketing' OR
       db_dept.department = 'engineering')
       
SELECT ABS(
(SELECT max_salary 
 FROM cte
 WHERE department = 'engineering') - 
(SELECT max_salary 
 FROM cte
 WHERE department = 'marketing')
) AS salary_difference;

---------------------------------------------------------------------------------------------------------------------------

