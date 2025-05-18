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
GROUP BY tweet_bucket

--------------------------------------------------------------------------------------------------------------------------------

