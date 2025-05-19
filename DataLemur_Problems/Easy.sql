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
