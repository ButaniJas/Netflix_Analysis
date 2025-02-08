WITH Genre_rank AS(
    SELECT 
    EXTRACT(YEAR FROM TO_DATE(date_added, 'Month DD, YYYY')) AS year,
    UNNEST(STRING_TO_ARRAY(listed_in, ',')) AS Genre,
    COUNT(*) AS Genre_count,
    RANK() 
        OVER (
            PARTITION BY EXTRACT(YEAR FROM TO_DATE(date_added, 'Month DD, YYYY'))
            ORDER BY COUNT(*) DESC
            )
    FROM netflix
    WHERE date_added IS NOT NULL
    GROUP BY
    year, Genre
)
SELECT * 
FROM Genre_rank
WHERE rank<=3
ORDER BY
    year DESC, rank