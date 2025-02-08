SELECT 
    COUNT(show_id),
    UNNEST(STRING_TO_ARRAY(listed_in, ',')) AS Genre
FROM netflix
GROUP BY 
2
ORDER BY
COUNT(show_id) DESC