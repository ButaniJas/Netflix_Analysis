SELECT type,
        title,
        release_year
FROM netflix
WHERE release_year = 2012 AND type = 'Movie'
