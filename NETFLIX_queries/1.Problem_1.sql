--Count Number of Movies and Tv Shows

SELECT type,
    COUNT(*) as total_shows
FROM netflix
GROUP BY type