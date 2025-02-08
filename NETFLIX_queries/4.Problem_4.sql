SELECT 
    country,
    COUNT(show_id) AS Most_Content
FROM netflix
WHERE country IS NOT NULL
GROUP BY
country
ORDER BY
Most_Content DESC
LIMIT 5 