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

https://platform.stratascratch.com/coding/9894-employee-and-manager-salaries?code_type=1

SELECT e.first_name, 
       e.salary 
FROM employee AS e
INNER JOIN employee AS ee ON ee.id = e.manager_id
WHERE e.salary > ee.salary;

---------------------------------------------------------------------------------------------------------------------------

https://platform.stratascratch.com/coding/9897-highest-salary-in-department?code_type=1

WITH cte_max_salary AS (SELECT department, 
                               MAX(salary) AS max_salary
                        FROM employee
                        GROUP BY 1)

SELECT cte.department, 
       e.first_name, 
       cte.max_salary
FROM employee AS e
INNER JOIN cte_max_salary AS cte ON cte.max_salary = e.salary;

---------------------------------------------------------------------------------------------------------------------------

https://platform.stratascratch.com/coding/9905-highest-target-under-manager?code_type=1

SELECT first_name,
       target
FROM salesforce_employees
WHERE manager_id = 13 AND 
       target  = (SELECT MAX(target) FROM salesforce_employees WHERE manager_id = 13);

---------------------------------------------------------------------------------------------------------------------------

https://platform.stratascratch.com/coding/9909-highest-number-of-orders?code_type=1

SELECT cust_id, 
       COUNT(*) AS total_orders
FROM orders
GROUP BY cust_id
ORDER BY total_orders DESC
LIMIT 1;

---------------------------------------------------------------------------------------------------------------------------

https://platform.stratascratch.com/coding/9915-highest-cost-orders?code_type=1

WITH cte AS (SELECT c.first_name, 
                    o.order_date, 
                    o.total_order_cost 
FROM customers AS c
INNER JOIN orders AS o ON o.cust_id = c.id AND 
                          o.order_date BETWEEN '2019-02-01' AND '2019-05-01')

SELECT first_name, 
       SUM(total_order_cost), 
       order_date
FROM cte
GROUP BY first_name, order_date
ORDER BY 2 DESC
LIMIT 1;

---------------------------------------------------------------------------------------------------------------------------

https://platform.stratascratch.com/coding/9942-largest-olympics?code_type=1

SELECT games, 
       COUNT(DISTINCT id) 
FROM olympics_athletes_events
GROUP BY games
ORDER BY 2 DESC
LIMIT 1;

---------------------------------------------------------------------------------------------------------------------------

https://platform.stratascratch.com/coding/9991-top-ranked-songs?code_type=1

SELECT trackname, 
       COUNT(*) AS time_top1
FROM spotify_worldwide_daily_song_ranking
WHERE position = 1
GROUP BY trackname
ORDER BY 2 DESC;

---------------------------------------------------------------------------------------------------------------------------

https://platform.stratascratch.com/coding/10026-find-all-wineries-which-produce-wines-by-possessing-aromas-of-plum-cherry-rose-or-hazelnut?code_type=1

SELECT DISTINCT winery
FROM winemag_p1
WHERE lower(description) ~ '\y(plum|cherry|rose|hazelnut)\y'

---------------------------------------------------------------------------------------------------------------------------

https://platform.stratascratch.com/coding/10048-top-businesses-with-most-reviews?code_type=1

SELECT name, 
       review_count 
FROM yelp_business
ORDER BY review_count DESC
LIMIT 5;

---------------------------------------------------------------------------------------------------------------------------

https://platform.stratascratch.com/coding/10049-reviews-of-categories?code_type=1

SELECT category, SUM(review_count) AS total_reviews
FROM (
    SELECT unnest(string_to_array(categories, ';')) AS category,
           review_count
    FROM yelp_business
) AS category_split
GROUP BY category
ORDER BY total_reviews DESC

---------------------------------------------------------------------------------------------------------------------------

https://platform.stratascratch.com/coding/10060-top-cool-votes?code_type=1

WITH cte AS (SELECT business_name, 
                    review_text, 
                    SUM(cool) AS cool_sum
             FROM yelp_reviews
             GROUP BY business_name, review_text)

SELECT business_name, review_text 
FROM cte
WHERE cool_sum = (SELECT MAX(cool_sum) 
                  FROM cte);

---------------------------------------------------------------------------------------------------------------------------

https://platform.stratascratch.com/coding/10064-highest-energy-consumption?code_type=1

WITH cte AS (SELECT * FROM fb_eu_energy
             UNION
             SELECT * FROM fb_asia_energy
             UNION 
             SELECT * FROM fb_na_energy),

cte_1 AS (SELECT date, 
                 SUM(consumption) AS total_energy_consumption
          FROM cte
          GROUP BY date
          ORDER BY total_energy_consumption DESC)

SELECT date, 
       total_energy_consumption
FROM cte_1
WHERE total_energy_consumption = (SELECT MAX(total_energy_consumption) FROM cte_1);

---------------------------------------------------------------------------------------------------------------------------

https://platform.stratascratch.com/coding/10078-find-matching-hosts-and-guests-in-a-way-that-they-are-both-of-the-same-gender-and-nationality?code_type=1

WITH cte AS (SELECT h.host_id, 
                    g.guest_id
             FROM airbnb_hosts AS h
             FULL OUTER JOIN airbnb_guests AS g ON h.nationality = g.nationality AND h.gender = g.gender)

SELECT DISTINCT host_id, guest_id
FROM cte

---------------------------------------------------------------------------------------------------------------------------

https://platform.stratascratch.com/coding/10090-find-the-percentage-of-shipable-orders?code_type=1

WITH cte AS (SELECT o.cust_id, 
                    c.address 
             FROM orders AS o
             LEFT JOIN customers AS c ON c.id = o.cust_id)
             
SELECT ROUND(
             1.0 * COUNT(*) / (SELECT COUNT(*) FROM cte), 
            2) * 100 AS shippable_percentage
FROM cte
WHERE address IS NOT NULL;

---------------------------------------------------------------------------------------------------------------------------

https://platform.stratascratch.com/coding/10134-spam-posts?code_type=1

WITH cte AS (SELECT fp.post_id, fp.post_keywords, fp.post_date  
             FROM facebook_posts AS fp
             INNER JOIN facebook_post_views AS fpv ON fp.post_id = fpv.post_id)

SELECT post_date, 
       ROUND(100.0*SUM(CASE WHEN post_keywords LIKE '%spam%' THEN 1 ELSE 0 END) / COUNT(post_id)) AS spam_share
FROM cte
GROUP BY post_date;

---------------------------------------------------------------------------------------------------------------------------

https://platform.stratascratch.com/coding/10141-apple-product-counts?code_type=1

WITH cte AS (SELECT DISTINCT pe.user_id, pe.device, pe.event_type, pu.language
             FROM playbook_events AS pe
             INNER JOIN playbook_users AS pu ON pe.user_id = pu.user_id)
             
SELECT language, 
       SUM(CASE WHEN (device = 'macbook pro' OR device = 'iphone 5s' OR device = 'ipad air') AND event_type = 'engagement' THEN 1 ELSE 0 END) AS n_apple_users, 
       COUNT(DISTINCT user_id) AS n_total_users 
FROM cte
GROUP BY language
ORDER BY n_total_users DESC;

---------------------------------------------------------------------------------------------------------------------------

https://platform.stratascratch.com/coding/10142-no-order-customers?code_type=1

WITH cte AS (SELECT c.first_name
             FROM customers AS c
             LEFT JOIN orders AS o ON o.cust_id = c.id
             AND o.order_date NOT BETWEEN '2019-02-01' AND '2019-03-01'),

cte_2 AS (SELECT c.first_name
             FROM customers AS c
             INNER JOIN orders AS o ON o.cust_id = c.id
             AND o.order_date BETWEEN '2019-02-01' AND '2019-03-01')
             
SELECT DISTINCT cte.first_name
FROM cte
LEFT JOIN cte_2 ON cte.first_name = cte_2.first_name
WHERE cte_2.first_name IS NULL;

---------------------------------------------------------------------------------------------------------------------------

https://platform.stratascratch.com/coding/10156-number-of-units-per-nationality?code_type=1

SELECT ah.nationality, 
       COUNT(DISTINCT au.unit_id) AS apartment_count
FROM airbnb_hosts AS ah
INNER JOIN airbnb_units AS au ON ah.host_id = au.host_id
           AND ah.age < 30 AND au.unit_type = 'Apartment'
GROUP BY ah.nationality;

---------------------------------------------------------------------------------------------------------------------------

https://platform.stratascratch.com/coding/10159-ranking-most-active-guests?code_type=1

WITH cte AS (SELECT id_guest, 
                    SUM(n_messages) AS sum_n_messages
             FROM airbnb_contacts
             GROUP BY id_guest
             ORDER BY sum_n_messages DESC)

SELECT DENSE_RANK() OVER(ORDER BY sum_n_messages DESC) AS ranking, 
       id_guest,
       sum_n_messages
FROM cte
ORDER BY ranking ASC;

---------------------------------------------------------------------------------------------------------------------------

https://platform.stratascratch.com/coding/10182-number-of-streets-per-zip-code?code_type=1

SELECT business_postal_code, 
       COUNT(DISTINCT CASE WHEN LEFT(business_address, 1) ~ '^[0-9]' THEN LOWER(SPLIT_PART(business_address, ' ', 2))
                           ELSE LOWER(SPLIT_PART(business_address, ' ', 1)) END) AS n_streets 
FROM sf_restaurant_health_violations
WHERE business_postal_code IS NOT NULL
GROUP BY business_postal_code
ORDER BY n_streets DESC, business_postal_code ASC;

---------------------------------------------------------------------------------------------------------------------------

https://platform.stratascratch.com/coding/10285-acceptance-rate-by-date?code_type=1

WITH cte AS (SELECT f1.user_id_receiver, f1.user_id_sender, f1.date, f2.action
             FROM fb_friend_requests AS f1
             INNER JOIN fb_friend_requests AS f2 ON f1.action = 'sent' AND f2.action = 'accepted' AND f1.user_id_sender = f2.user_id_sender AND f2.user_id_receiver = f1.user_id_receiver),
             
     cte_2 AS (SELECT date, COUNT(*) AS total_requests_sent
              FROM fb_friend_requests
              WHERE action = 'sent'
              GROUP BY date),
              
     cte_3 AS (SELECT date, COUNT(*) AS total_requests_accepted
              FROM cte
              GROUP BY date)
              
SELECT cte_2.date, 1.0*cte_3.total_requests_accepted / cte_2.total_requests_sent AS percentage_acceptance
FROM cte_2
INNER JOIN cte_3 ON cte_2.date = cte_3.date

---------------------------------------------------------------------------------------------------------------------------

https://platform.stratascratch.com/coding/10288-clicked-vs-non-clicked-search-results?code_type=1

WITH cte AS (SELECT COUNT(*) AS total_count FROM fb_search_events),

     cte_2 AS (SELECT COUNT(*) AS top_3_clicked
               FROM fb_search_events
               WHERE search_results_position <= 3 AND clicked = 1),
               
     cte_3 AS (SELECT COUNT(*) AS top_3_notclicked
               FROM fb_search_events
               WHERE search_results_position <= 3 AND clicked = 0)
               
SELECT 100.0*(SELECT top_3_clicked FROM cte_2) / (SELECT total_count FROM cte) AS top_3_clicked,
       100.0*(SELECT top_3_notclicked FROM cte_3) / (SELECT total_count FROM cte) AS top_3_notclicked;

---------------------------------------------------------------------------------------------------------------------------

https://platform.stratascratch.com/coding/10296-facebook-accounts?code_type=1

SELECT 1.0*SUM(CASE WHEN status = 'closed' THEN 1 ELSE 0 END) / COUNT(*) AS closed_ratio
FROM fb_account_status 
WHERE status_date = '2020-01-10';

---------------------------------------------------------------------------------------------------------------------------

https://platform.stratascratch.com/coding/10304-risky-projects?code_type=1

WITH cte AS (SELECT lp.title, lp.budget, 1.0*DATEDIFF(lp.end_date, lp.start_date) / 365 AS ratio_year_spent, le.salary 
             FROM linkedin_projects AS lp
             INNER JOIN linkedin_emp_projects AS lep 
                ON lp.id = lep.project_id
             INNER JOIN linkedin_employees AS le
                ON lep.emp_id = le.id)
                
SELECT title, budget, ROUND(SUM(ratio_year_spent*salary) + 0.5, 0) AS prorated_employee_expense
FROM cte
GROUP BY title, budget
HAVING ROUND(SUM(ratio_year_spent*salary) + 0.5, 0) > budget
ORDER BY title

---------------------------------------------------------------------------------------------------------------------------

https://platform.stratascratch.com/coding/10318-new-products?code_type=1

SELECT company_name, 
       SUM(CASE WHEN year = 2020 THEN 1 ELSE 0 END) - SUM(CASE WHEN year = 2019 THEN 1 ELSE 0 END) AS net_difference 
FROM car_launches 
GROUP BY company_name
ORDER BY company_name;

---------------------------------------------------------------------------------------------------------------------------

https://platform.stratascratch.com/coding/10322-finding-user-purchases?code_type=1

WITH cte AS (SELECT user_id, 
                    created_at AS purchase, 
                    LAG(created_at, 1) OVER(PARTITION BY user_id ORDER BY created_at) AS previous_purchase
             FROM amazon_transactions)

SELECT DISTINCT user_id
FROM cte
WHERE purchase - previous_purchase <= 7;

---------------------------------------------------------------------------------------------------------------------------

https://platform.stratascratch.com/coding/10351-activity-rank?code_type=1

WITH cte AS (SELECT from_user, COUNT(*) AS total_emails
             FROM google_gmail_emails
             GROUP BY from_user)

SELECT *, ROW_NUMBER() OVER(ORDER BY total_emails DESC, from_user) 
FROM cte

---------------------------------------------------------------------------------------------------------------------------

https://platform.stratascratch.com/coding/10352-users-by-avg-session-time?code_type=1

WITH cte AS (SELECT user_id, DATE(timestamp), timestamp, action
             FROM facebook_web_log
             WHERE action = 'page_load' OR action = 'page_exit'),

cte_2 AS (SELECT user_id, date, MAX(timestamp) AS login 
          FROM cte
          WHERE action = 'page_load'
          GROUP BY user_id, date),
          
cte_3 AS (SELECT user_id, date, MIN(timestamp) AS logout 
          FROM cte
          WHERE action = 'page_exit'
          GROUP BY user_id, date)
          
SELECT cte_2.user_id, AVG(cte_3.logout - cte_2.login) AS avg_session_duration
FROM cte_2
INNER JOIN cte_3
    ON cte_2.user_id = cte_3.user_id AND cte_2.date = cte_3.date
    AND cte_2.login < cte_3.logout
GROUP BY cte_2.user_id;

---------------------------------------------------------------------------------------------------------------------------

HARD

---------------------------------------------------------------------------------------------------------------------------

https://platform.stratascratch.com/coding/514-marketing-campaign-success-advanced?code_type=1

WITH cte AS (SELECT user_id, MIN(created_at)
             FROM marketing_campaign
             GROUP BY user_id),
             
    cte_2 AS (SELECT user_id, product_id
              FROM marketing_campaign
              WHERE (user_id, created_at) IN (SELECT * FROM cte))
               
SELECT COUNT(DISTINCT user_id) AS user_count
FROM marketing_campaign
WHERE (user_id, created_at) NOT IN (SELECT * FROM cte)
       AND (user_id, product_id) NOT IN (SELECT * FROM cte_2);

---------------------------------------------------------------------------------------------------------------------------

https://platform.stratascratch.com/coding/2029-the-most-popular-client_id-among-users-using-video-and-voice-calls?code_type=1

WITH cte AS (SELECT user_id, 1.0*SUM(CASE WHEN event_type IN ('video call received', 'video call sent', 'voice call received', 'voice call sent') THEN 1 ELSE 0 END) / 
                             COUNT(*) AS list_percentage  
             FROM fact_events
             GROUP BY user_id),

cte_2 AS (SELECT user_id 
          FROM cte
          WHERE list_percentage >= 0.5),

cte_3 AS (SELECT user_id, client_id
          FROM fact_events
          WHERE user_id IN (SELECT * FROM cte_2)),

cte_4 AS (SELECT client_id, COUNT(*)
          FROM cte_3
          GROUP BY client_id)

SELECT client_id
FROM cte_4
ORDER BY count DESC
LIMIT 1

---------------------------------------------------------------------------------------------------------------------------

https://platform.stratascratch.com/coding/2053-retention-rate?code_type=1

WITH december_2020_and_january_2021_activity AS (SELECT * 
                                                 FROM sf_events 
WHERE (EXTRACT(YEAR FROM record_date) = 2020 AND 
       EXTRACT(MONTH FROM record_date) = 12) OR
      (EXTRACT(YEAR FROM record_date) = 2021 AND
       EXTRACT(MONTH FROM record_date) = 1)),
       
with_future_activity AS (SELECT dj.record_date AS dj_record_date, 
                                dj.account_id, 
                                dj.user_id, 
                                sf.record_date AS future_activity
FROM december_2020_and_january_2021_activity as dj
LEFT JOIN sf_events AS sf 
    ON DATE_TRUNC('month', sf.record_date) >= (DATE_TRUNC('month', dj.record_date) + INTERVAL '1 month')
    AND sf.account_id = dj.account_id 
    AND sf.user_id = dj.user_id),
    
count_retained_users AS (SELECT TO_CHAR(dj_record_date, 'YYYY-MM'), account_id, COUNT(DISTINCT user_id) AS retained_users
FROM with_future_activity
WHERE future_activity IS NOT NULL
GROUP BY TO_CHAR(dj_record_date, 'YYYY-MM'), account_id),

count_total_users AS (SELECT TO_CHAR(record_date, 'YYYY-MM'), account_id, COUNT(DISTINCT user_id) AS total_users
FROM sf_events
GROUP BY TO_CHAR(record_date, 'YYYY-MM'), account_id),


prepped_to_calc_retention AS (SELECT cru.to_char, cru.account_id, 1.0*cru.retained_users / ctu.total_users AS retention
FROM count_retained_users AS cru
INNER JOIN count_total_users AS ctu
    ON cru.to_char = ctu.to_char
    AND cru.account_id = ctu.account_id),
    
penultimate_cte AS (SELECT ptcr.to_char, ptcr.account_id, ptcr.retention, ptcr_1.retention AS jan_retention
FROM prepped_to_calc_retention AS ptcr
LEFT JOIN prepped_to_calc_retention AS ptcr_1 
    ON ptcr.to_char != ptcr_1.to_char
    AND ptcr.account_id = ptcr_1.account_id)
    
SELECT DISTINCT account_id, 
CASE WHEN jan_retention IS NULL THEN 0 ELSE 1.0*jan_retention / retention END AS retention
FROM penultimate_cte
ORDER BY account_id

---------------------------------------------------------------------------------------------------------------------------

https://platform.stratascratch.com/coding/2089-cookbook-recipes?code_type=1

WITH cte AS (SELECT *, CASE WHEN (page_number % 2 = 0) THEN page_number
          ELSE page_number - 1 END AS left_page_number 
FROM cookbook_titles),

cte_1 AS (SELECT left_page_number, title AS right_title
FROM cte
WHERE page_number % 2 = 1),

cte_2 AS (SELECT left_page_number, title AS left_title
FROM cte
WHERE page_number % 2 = 0),

cte_3 AS (SELECT cte_1.left_page_number, cte_2.left_title, cte_1.right_title
FROM cte_1
LEFT JOIN cte_2
    ON cte_1.left_page_number = cte_2.left_page_number),
    
cte_4 AS (SELECT cte_2.left_page_number, cte_2.left_title, cte_1.right_title
FROM cte_2
LEFT JOIN cte_1
    ON cte_1.left_page_number = cte_2.left_page_number),
    
cte_5 AS (SELECT cte_3.left_page_number AS lpn_1, cte_3.left_title AS lt_1, cte_3.right_title AS rt_1, cte_4.left_page_number AS lpn_2, cte_4.left_title AS lt_2, cte_4.right_title AS rt_2 
FROM cte_3
FULL OUTER JOIN cte_4 ON cte_3.left_page_number = cte_4.left_page_number),

cte_6 AS (SELECT CASE WHEN lpn_1 IS NOT NULL THEN lpn_1
       ELSE lpn_2 END AS left_page_number,
       CASE WHEN lt_1 IS NOT NULL THEN lt_1
        ELSE lt_2 END AS left_title,
       rt_1 AS right_title
FROM cte_5
ORDER BY left_page_number),

cte_7 AS (SELECT GENERATE_SERIES(0, MAX(page_number), 2) AS even_number
FROM cookbook_titles)

SELECT cte_7.even_number AS left_page_number, cte_6.left_title, cte_6.right_title
FROM cte_7
LEFT JOIN cte_6 ON cte_7.even_number = cte_6.left_page_number

---------------------------------------------------------------------------------------------------------------------------

https://platform.stratascratch.com/coding/9632-host-popularity-rental-prices?code_type=1

WITH pop_rating_and_price AS (SELECT CASE WHEN number_of_reviews = 0 THEN 'New'
                                          WHEN number_of_reviews BETWEEN 1 AND 5  THEN 'Rising'
                                          WHEN number_of_reviews BETWEEN 6 AND 15 THEN 'Trending Up'
                                          WHEN number_of_reviews BETWEEN 16 AND 40 THEN 'Popular'
                                          ELSE 'Hot' END AS host_popularity,
                                     price    
                              FROM airbnb_host_searches)

SELECT host_popularity, 
       MIN(price) AS min_price, 
       AVG(price) AS avg_price, 
       MAX(price) AS max_price
FROM pop_rating_and_price
GROUP BY host_popularity
ORDER BY min_price;

---------------------------------------------------------------------------------------------------------------------------

https://platform.stratascratch.com/coding/9633-city-with-most-amenities?code_type=1

WITH city_and_count AS (SELECT city, 
                               CARDINALITY(STRING_TO_ARRAY(amenities, ',')) AS amen_count
                        FROM airbnb_search_details)

SELECT city
FROM city_and_count
GROUP BY city
ORDER BY SUM(amen_count) DESC
LIMIT 1

---------------------------------------------------------------------------------------------------------------------------
