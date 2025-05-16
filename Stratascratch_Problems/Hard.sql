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

https://platform.stratascratch.com/coding/9814-counting-instances-in-text?code_type=1

WITH bull_count_cte AS (SELECT 
    filename,
    COUNT(*) FILTER (WHERE lower(word) = 'bull') AS bull_count
FROM (
    SELECT 
        filename,
        unnest(regexp_split_to_array(contents, '\s+')) AS word
    FROM google_file_store
) AS words
GROUP BY filename),

bear_count_cte AS (SELECT 
    filename,
    COUNT(*) FILTER (WHERE lower(word) = 'bear') AS bear_count
FROM (
    SELECT 
        filename,
        unnest(regexp_split_to_array(contents, '\s+')) AS word
    FROM google_file_store
) AS words
GROUP BY filename)

SELECT 'bull' AS word, SUM(bull_count)
FROM bull_count_cte
UNION
SELECT 'bear' AS word, SUM(bear_count)
FROM bear_count_cte
ORDER BY word DESC;

---------------------------------------------------------------------------------------------------------------------------

https://platform.stratascratch.com/coding/10046-top-5-states-with-5-star-businesses?code_type=1

WITH all_states_and_five_stars AS (SELECT state, COUNT(*) AS n_businesses
                                   FROM yelp_business
                                   WHERE stars = 5
                                   GROUP BY state),

top_5_counts AS (SELECT DISTINCT n_businesses 
                 FROM all_states_and_five_stars
                 ORDER BY n_businesses DESC
                 LIMIT 5)

SELECT sf.state, sf.n_businesses 
FROM all_states_and_five_stars AS sf
INNER JOIN top_5_counts as tc
    ON sf.n_businesses = tc.n_businesses
ORDER BY n_businesses DESC, state;

---------------------------------------------------------------------------------------------------------------------------

https://platform.stratascratch.com/coding/10284-popularity-percentage?code_type=1

WITH distinct_user1 AS (SELECT DISTINCT user1
                        FROM facebook_friends),

     distinct_user2 AS (SELECT DISTINCT user2
                        FROM facebook_friends),

     all_users AS (SELECT du_1.user1, du_2.user2
                   FROM distinct_user1 AS du_1
                   FULL JOIN distinct_user2 AS du_2 ON du_1.user1 = du_2.user2),

     total_count AS (SELECT COUNT(*) AS total_users
                     FROM all_users),
                     
     all_friends AS (SELECT user1
                     FROM facebook_friends
                     UNION ALL
                     SELECT user2 
                     FROM facebook_friends)
                     
SELECT user1, 100.0*COUNT(*) / (SELECT total_users FROM total_count) AS popularity_percent
FROM all_friends
GROUP BY user1
ORDER BY user1;

---------------------------------------------------------------------------------------------------------------------------

https://platform.stratascratch.com/coding/10303-top-percentile-fraud?code_type=1

WITH percentile_cte AS (SELECT *, CUME_DIST() OVER (PARTITION BY state ORDER BY fraud_score) AS percentile
                        FROM fraud_score)

SELECT policy_num, state, claim_cost, fraud_score
FROM percentile_cte
WHERE percentile >= 0.95
ORDER BY state, fraud_score DESC

---------------------------------------------------------------------------------------------------------------------------

https://platform.stratascratch.com/coding/10319-monthly-percentage-difference?code_type=1

WITH rev_per_month AS (SELECT TO_CHAR(created_at, 'YYYY-MM') AS year_month,  
                              SUM(value) AS rev
                       FROM sf_transactions
                       GROUP BY TO_CHAR(created_at, 'YYYY-MM')),

prev_rev_per_month AS (SELECT *, LAG(rev, 1) OVER(ORDER BY year_month) AS prev_month_rev
                       FROM rev_per_month)

SELECT year_month, 
       100.0*(rev - prev_month_rev) / prev_month_rev AS revenue_diff_pct
FROM prev_rev_per_month
ORDER BY year_month;

---------------------------------------------------------------------------------------------------------------------------
