SELECT
    type,
    title,
    duration
FROM netflix
WHERE type = 'TV Show' 
AND CAST(SPLIT_PART(duration, ' ', 1) AS NUMERIC) > 5
ORDER BY
    CAST(SPLIT_PART(duration, ' ', 1) AS NUMERIC) DESC