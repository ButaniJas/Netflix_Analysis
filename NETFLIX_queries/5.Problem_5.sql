SELECT type,
    title,
    duration AS time
FROM netflix

WHERE type = 'Movie' AND duration = (SELECT MAX(duration) FROM netflix)