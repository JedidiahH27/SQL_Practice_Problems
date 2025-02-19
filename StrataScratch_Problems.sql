EASY

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

MEDIUM

---------------------------------------------------------------------------------------------------------------------------

https://platform.stratascratch.com/coding/2005-share-of-active-users?code_type=1

SELECT 1.0*SUM(CASE WHEN status = 'open' THEN 1 ELSE 0 END) /  
       COUNT(*) AS active_users_share
FROM fb_active_users
WHERE country = 'USA';

---------------------------------------------------------------------------------------------------------------------------

https://platform.stratascratch.com/coding/2097-premium-acounts?code_type=1

WITH cte_no_free AS (SELECT * 
                     FROM premium_accounts_by_day
                     WHERE final_price != 0), 

cte_dates AS (SELECT pa_1.account_id, 
                          pa_1.entry_date,
                          pa_1.final_price AS final_price_1,
                          pa_2.final_price AS final_price_2,
                          pa_2.entry_date AS seven_day 
FROM cte_no_free AS pa_1
LEFT JOIN cte_no_free AS pa_2 
ON pa_1.account_id = pa_2.account_id
AND (pa_1.entry_date + INTERVAL '7 days') = pa_2.entry_date)

SELECT entry_date, 
       SUM(CASE WHEN entry_date IS NOT NULL THEN 1 ELSE 0 END) AS premium_paid_accounts,
       SUM(CASE WHEN seven_day IS NOT NULL THEN 1 ELSE 0 END) AS premium_paid_accounts_after_7d
FROM cte_dates
GROUP BY entry_date
ORDER BY entry_date
LIMIT 7;

---------------------------------------------------------------------------------------------------------------------------

https://platform.stratascratch.com/coding/2099-election-results?code_type=1

WITH cte_vote_count AS (SELECT voter, 
                               COUNT(*) AS vote_number
                        FROM voting_results
                        GROUP BY voter),

cte_total_info AS (SELECT vr.candidate, 
                          vr.voter, 
                          cte.vote_number
                   FROM voting_results AS vr
                   INNER JOIN cte_vote_count AS cte ON cte.voter = vr.voter)

SELECT candidate
FROM cte_total_info
WHERE candidate IS NOT NULL
GROUP BY candidate
ORDER BY ROUND(SUM(1.0 / vote_number), 3) DESC
LIMIT 1;

---------------------------------------------------------------------------------------------------------------------------

https://platform.stratascratch.com/coding/2102-flags-per-video?code_type=1

SELECT uf.video_id, 
       COUNT(DISTINCT name) AS num_unique_users
FROM (SELECT CONCAT(user_firstname, ' ', user_lastname) AS name, video_id 
      FROM user_flags 
      WHERE flag_id IS NOT NULL) AS uf
GROUP BY uf.video_id

---------------------------------------------------------------------------------------------------------------------------

https://platform.stratascratch.com/coding/2104-user-with-most-approved-flags?code_type=1

WITH name_and_reviewed_outcome AS (SELECT CONCAT(uf.user_firstname, ' ', uf.user_lastname) AS name,
                                          fr.reviewed_outcome,
                                          uf.video_id
                                   FROM user_flags AS uf
                                   INNER JOIN flag_review AS fr ON fr.flag_id = uf.flag_id AND fr.reviewed_outcome = 'APPROVED'),

name_and_counts AS (SELECT name AS username, 
                           COUNT(DISTINCT video_id)
                    FROM name_and_reviewed_outcome
                    GROUP BY name)

SELECT username
FROM name_and_counts
WHERE count = (SELECT MAX(count) FROM name_and_counts);

---------------------------------------------------------------------------------------------------------------------------

https://platform.stratascratch.com/coding/9610-find-students-with-a-median-writing-score?code_type=1

WITH cte AS (SELECT student_id,
                    sat_writing,
                    ROW_NUMBER() OVER(ORDER BY sat_writing)
             FROM sat_scores
             ORDER BY sat_writing),

cte_1 AS (SELECT *, 1.0*(SELECT MAX(row_number) FROM cte) / 2 - row_number AS difference 
          FROM cte),


cte_2 AS (SELECT student_id, 
                 sat_writing 
          FROM cte_1 
          WHERE difference = -0.5)

SELECT cte.student_id
FROM cte
INNER JOIN cte_2 ON cte_2.sat_writing = cte.sat_writing
ORDER BY student_id

---------------------------------------------------------------------------------------------------------------------------

https://platform.stratascratch.com/coding/9650-find-the-top-10-ranked-songs-in-2010?code_type=1

SELECT year_rank, 
       group_name, 
       song_name 
FROM billboard_top_100_year_end
WHERE year = 2010 and year_rank <= 10
GROUP BY 1, 2, 3
ORDER BY year_rank;

---------------------------------------------------------------------------------------------------------------------------

https://platform.stratascratch.com/coding/9726-classify-business-type?code_type=1

SELECT DISTINCT business_name, 
       CASE WHEN business_name ILIKE '%restaurant%' THEN 'restaurant'
            WHEN business_name ILIKE '%cafe%' OR business_name ILIKE '%café%' OR business_name ILIKE '%coffee%' THEN 'cafe' 
            WHEN business_name ILIKE '%school%' THEN 'school'
            ELSE 'other'
            END AS business_type
FROM sf_restaurant_health_violations;

---------------------------------------------------------------------------------------------------------------------------

https://platform.stratascratch.com/coding/10077-income-by-title-and-gender?code_type=1

WITH cte AS (SELECT SUM(bonus) AS total_bonus,
                    worker_ref_id
            FROM sf_bonus
            GROUP BY worker_ref_id)

SELECT sfe.employee_title, 
       sfe.sex, 
       AVG(sfe.salary + cte.total_bonus) AS avg_compensation
FROM sf_employee AS sfe
RIGHT JOIN cte ON sfe.id = cte.worker_ref_id
GROUP BY 1, 2

---------------------------------------------------------------------------------------------------------------------------

https://platform.stratascratch.com/coding/9781-find-the-rate-of-processed-tickets-for-each-type?code_type=1

SELECT type, 
       ROUND(1.0*SUM(CASE WHEN processed = 'TRUE' THEN 1 ELSE 0 END) / COUNT(*), 2) AS processed_rate
FROM facebook_complaints
GROUP BY type;

---------------------------------------------------------------------------------------------------------------------------

https://platform.stratascratch.com/coding/9782-customer-revenue-in-march?code_type=1

SELECT cust_id,
       SUM(total_order_cost) AS total_revenue
FROM orders
WHERE EXTRACT(YEAR FROM order_date) = 2019 AND EXTRACT(MONTH FROM order_date) = 3
GROUP BY cust_id
ORDER BY 2 DESC;

---------------------------------------------------------------------------------------------------------------------------

https://platform.stratascratch.com/coding/9817-find-the-number-of-times-each-word-appears-in-drafts?code_type=1

SELECT LOWER(words) AS word, 
       COUNT(*) AS occurrences
FROM (SELECT REGEXP_SPLIT_TO_TABLE(REGEXP_REPLACE(contents, '[^\w\s]', '', 'g'), '\s+') AS words 
      FROM google_file_store) AS the_words
GROUP BY LOWER(words)
ORDER BY occurences DESC;

---------------------------------------------------------------------------------------------------------------------------

https://platform.stratascratch.com/coding/9881-make-a-report-showing-the-number-of-survivors-and-non-survivors-by-passenger-class?code_type=1

WITH cte_first_class AS (SELECT survived, 
                                COUNT(*) AS first_class
                                FROM titanic
                                WHERE pclass = 1
                                GROUP BY survived, pclass
                                ORDER BY survived),
                                
cte_second_class AS (SELECT survived, 
                            COUNT(*) AS second_class
                            FROM titanic
                            WHERE pclass = 2
                            GROUP BY survived, pclass
                            ORDER BY survived),
                            
cte_third_class AS (SELECT survived, 
                           COUNT(*) AS third_class
                           FROM titanic
                           WHERE pclass = 3
                           GROUP BY survived, pclass
                           ORDER BY survived)
                           
SELECT uno.survived, 
       uno.first_class, 
       dos.second_class, 
       tres.third_class
FROM cte_first_class AS uno
INNER JOIN cte_second_class AS dos ON uno.survived = dos.survived
INNER JOIN cte_third_class AS tres ON uno.survived = tres.survived

---------------------------------------------------------------------------------------------------------------------------

https://platform.stratascratch.com/coding/9892-second-highest-salary?code_type=1

SELECT salary FROM (SELECT salary 
                    FROM employee
                    ORDER BY salary DESC
                    LIMIT 2) AS top_two
ORDER BY salary ASC
LIMIT 1;

---------------------------------------------------------------------------------------------------------------------------
