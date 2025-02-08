SELECT 
    release_year, 
    COUNT(show_id) AS total_content 
FROM netflix
WHERE country = 'India' 
GROUP BY release_year
ORDER BY total_content DESC 
LIMIT 5;
