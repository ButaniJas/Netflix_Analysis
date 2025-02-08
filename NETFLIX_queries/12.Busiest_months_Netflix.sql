SELECT
    TO_CHAR(TO_DATE(date_added, 'Month DD, YYYY'), 'Month') AS Month,
    COUNT(*) AS total_releases
FROM netflix
WHERE date_added IS NOT NULL
GROUP BY Month
ORDER BY total_releases DESC