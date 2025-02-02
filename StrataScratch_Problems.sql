---------------------------------------------------------------------------------------------------------------------------
https://platform.stratascratch.com/coding/9728-inspections-that-resulted-in-violations/submissions?code_type=1

SELECT EXTRACT(YEAR FROM inspection_date) AS inspection_year,
       COUNT(*) AS n_violations
FROM sf_restaurant_health_violations
WHERE violation_id IS NOT NULL AND business_name = 'Roxanne Cafe'
GROUP BY EXTRACT(YEAR FROM inspection_date)
ORDER BY 1;

---------------------------------------------------------------------------------------------------------------------------

https://platform.stratascratch.com/coding/9845-find-the-number-of-employees-working-in-the-admin-department?code_type=1

SELECT COUNT(*) AS n_admins 
FROM worker
WHERE EXTRACT(MONTH FROM joining_date) >= 4 AND 
      department = 'Admin';

---------------------------------------------------------------------------------------------------------------------------
