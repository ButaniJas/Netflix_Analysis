SELECT type,
rating, COUNT(*) AS count
FROM netflix
WHERE rating IS NOT NULL
GROUP BY type, rating
ORDER BY type, count DESC