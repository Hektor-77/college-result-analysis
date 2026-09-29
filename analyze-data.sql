-- Dataset contains department, degree/program, result status,
-- SGPA, CGPA, and failing-subject codes, so your strongest 
-- dashboard will combine performance, outcomes, student distribution, 
-- and problem subjects.

-- 1 ) KPI's ⭐

-- Total students

SELECT COUNT(*) AS total_students
FROM college_results;

-- Average CGPA

SELECT ROUND(AVG(cgpa), 2) AS avg_cgpa
FROM college_results
WHERE cgpa IS NOT NULL;

-- Average CGPA

SELECT ROUND(AVG(sgpa), 2) AS avg_sgpa
FROM college_results
WHERE sgpa IS NOT NULL;

-- Promoted Students  (2514)

SELECT COUNT(*) AS promoted_students
FROM college_results
WHERE result_status = 'Promoted';

-- Dropped Students  (26)

SELECT COUNT(*) AS dropped_students
FROM college_results
WHERE result_status = 'Dropped';

-- Promotion Rate (98.98)

SELECT ROUND(
    100.0 * COUNT(*) FILTER (WHERE result_status = 'Promoted')
    / COUNT(*), 2
) AS promotion_rate
FROM college_results;

-- 2) Department Performance Ranking⭐

select
	department,
	count(*) as students,
	round(avg(cgpa), 2) as avg_cgpa,
	round(avg(sgpa), 2) as avg_sgpa

from college_results
group by department
order by avg_cgpa desc

-- 3) Departments Needing Attention⭐

SELECT
    department,
    COUNT(*) AS students,
    ROUND(AVG(cgpa), 2) AS avg_cgpa,
    ROUND(
        100.0 * COUNT(*) FILTER (WHERE result_status = 'Dropped')
        / COUNT(*), 2
    ) AS dropped_rate
FROM college_results
GROUP BY department
ORDER BY avg_cgpa ASC;


-- 4) Compare SGPA vs CGPA ⭐

SELECT
    department,
    ROUND(AVG(sgpa), 2) AS avg_sgpa,
    ROUND(AVG(cgpa), 2) AS avg_cgpa,
    ROUND(AVG(sgpa - cgpa), 2) AS avg_difference
FROM college_results
WHERE sgpa IS NOT NULL
  AND cgpa IS NOT NULL
GROUP BY department
ORDER BY avg_difference DESC;

-- This can uncover departments where:
-- SGPA > CGPA
-- Students may be improving recently.
-- SGPA < CGPA
-- Recent performance may be weaker than their historical performance.
-- That's a much more interesting analytical story than simply ranking departments.


-- 5) Promotion vs Drop rate ⭐

SELECT
    department,
    ROUND(
        100.0 * COUNT(*) FILTER (WHERE result_status = 'Promoted')
        / COUNT(*), 2
    ) AS promoted_rate,

    ROUND(
        100.0 * COUNT(*) FILTER (WHERE result_status = 'Dropped')
        / COUNT(*), 2
    ) AS dropped_rate

FROM college_results
GROUP BY department
ORDER BY dropped_rate DESC;

-- 6) Top-performing students 🏆

SELECT
    name,
    department,
    degree,
    cgpa,
    sgpa
FROM college_results
WHERE cgpa IS NOT NULL
ORDER BY cgpa DESC
LIMIT 10;

