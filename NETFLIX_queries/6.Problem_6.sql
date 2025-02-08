SELECT 
    type,
    title,
    TO_DATE(date_added, 'Month DD, YYYY') AS date
FROM netflix
WHERE
    TO_DATE(date_added,'Month DD, YYYY') >= CURRENT_DATE - INTERVAL '5 years':: INTERVAL AND type = 'Movie'