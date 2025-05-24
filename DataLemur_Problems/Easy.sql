--------------------------------------------------------------------------------------------------------------------------------

https://datalemur.com/questions/sql-histogram-tweets

WITH number_of_tweets AS (
  SELECT COUNT(*) AS tweet_bucket 
  FROM tweets
  WHERE EXTRACT(YEAR FROM tweet_date) = 2022
  GROUP BY user_id
  )

SELECT tweet_bucket, 
       COUNT(*) AS users_num
FROM number_of_tweets
GROUP BY tweet_bucket;

--------------------------------------------------------------------------------------------------------------------------------

https://datalemur.com/questions/matching-skills

SELECT candidate_id 
FROM candidates
WHERE skill IN ('Python', 'Tableau', 'PostgreSQL')
GROUP BY candidate_id
HAVING COUNT(DISTINCT skill) = 3;

--------------------------------------------------------------------------------------------------------------------------------

https://datalemur.com/questions/sql-page-with-no-likes

SELECT p.page_id
FROM pages AS p 
LEFT JOIN page_likes AS pl 
  ON p.page_id = pl.page_id
WHERE pl.user_id IS NULL;

--------------------------------------------------------------------------------------------------------------------------------

https://datalemur.com/questions/tesla-unfinished-parts

SELECT part, assembly_step
FROM parts_assembly
WHERE finish_date IS NULL;

--------------------------------------------------------------------------------------------------------------------------------

https://datalemur.com/questions/laptop-mobile-viewership

SELECT 
SUM(CASE WHEN device_type = 'laptop' THEN 1 ELSE 0 END) AS laptop_views,
SUM(CASE WHEN device_type = 'tablet' OR device_type = 'phone' THEN 1 ELSE 0 END) AS mobile_views
FROM viewership

--------------------------------------------------------------------------------------------------------------------------------

https://datalemur.com/questions/sql-average-post-hiatus-1

SELECT user_id, EXTRACT(DOY FROM MAX(post_date)) - EXTRACT(DOY FROM MIN(post_date)) AS days_between
FROM posts
WHERE EXTRACT(YEAR FROM post_date) = 2021
GROUP BY user_id
HAVING EXTRACT(DOY FROM MAX(post_date)) - EXTRACT(DOY FROM MIN(post_date)) > 0

--------------------------------------------------------------------------------------------------------------------------------

https://datalemur.com/questions/teams-power-users

SELECT sender_id, COUNT(*) AS message_count
FROM messages
WHERE TO_CHAR(sent_date, 'YYYY-MM') = '2022-08'
GROUP BY sender_id
ORDER BY message_count DESC
LIMIT 2

--------------------------------------------------------------------------------------------------------------------------------

https://datalemur.com/questions/duplicate-job-listings

SELECT COUNT(*) AS duplicate_companies
FROM (SELECT COUNT(*)
      FROM job_listings
      GROUP BY company_id, title, description
      HAVING COUNT(*) > 1) 
AS duplicates_table

--------------------------------------------------------------------------------------------------------------------------------

https://datalemur.com/questions/completed-trades

WITH count_cities AS 
  (SELECT u.city 
   FROM trades AS t
   INNER JOIN users AS u 
    ON u.user_id = t.user_id
    AND t.status = 'Completed')
  
SELECT city, COUNT(*) AS total_orders
FROM count_cities
GROUP BY city 
ORDER BY total_orders DESC
LIMIT 3

--------------------------------------------------------------------------------------------------------------------------------

https://datalemur.com/questions/sql-avg-review-ratings

SELECT EXTRACT(MONTH FROM submit_date) AS mth, 
       product_id AS product, 
       ROUND(AVG(stars), 2) AS avg_stars
FROM reviews
GROUP BY product_id, EXTRACT(MONTH FROM submit_date)
ORDER BY mth, product

--------------------------------------------------------------------------------------------------------------------------------

https://datalemur.com/questions/sql-well-paid-employees

SELECT e.employee_id, e.name AS employee_name
FROM employee AS e
INNER JOIN employee AS ee 
  ON ee.employee_id = e.manager_id
  AND e.salary > ee.salary

--------------------------------------------------------------------------------------------------------------------------------

https://datalemur.com/questions/click-through-rate

SELECT app_id, 
       ROUND(100.0*SUM(CASE WHEN event_type = 'click' THEN 1 ELSE 0 END) / 
                   SUM(CASE WHEN event_type = 'impression' THEN 1 ELSE 0 END), 2)
       AS ctr
FROM events
WHERE EXTRACT(YEAR FROM timestamp) = 2022
GROUP BY app_id

--------------------------------------------------------------------------------------------------------------------------------

