# Netflix Movies and TV Shows Data Analysis using SQL

![](https://github.com/ButaniJas/Netflix_Analysis/blob/main/Visuals/Netflix.jpg)

## Overview
This project involves a comprehensive analysis of Netflix's movies and TV shows data using SQL. The goal is to extract valuable insights and answer various business questions based on the dataset. The following README provides a detailed account of the project's objectives, business problems, solutions, findings, visuals and conclusions.

## Objectives

- Analyze the distribution of content types (movies vs TV shows).
- Identify the most common ratings for movies and TV shows.
- List and analyze content based on release years, countries, and durations.
- Explore and categorize content based on specific criteria and keywords.

## Dataset

The data for this project is sourced from the Kaggle dataset:

- **Dataset Link:** [Movies Dataset](https://www.kaggle.com/datasets/rahulvyasm/netflix-movies-and-tv-shows?resource=download)

## Schema

```sql

CREATE TABLE  netflix
(
    show_id     VARCHAR(6),
    type      VARCHAR(10),	
     title     VARCHAR(110),	
      director  VARCHAR(250),	
      casts   VARCHAR(1000),	
      country  VARCHAR(150),	
    date_added VARCHAR(50),	
     release_year INT   ,	
         rating VARCHAR(10),	
       duration VARCHAR(10),	
       listed_in    VARCHAR(150),	
      description   VARCHAR(1000)	
)
SELECT * FROM netflix

SELECT COUNT(*) AS total
FROM netflix


```

## Business Problems and Solutions

### 1. Count the Number of Movies vs TV Shows

```sql
--Count Number of Movies and Tv Shows

SELECT type,
    COUNT(*) as total_shows
FROM netflix
GROUP BY type
```
#### VIsualization:
![](https://github.com/ButaniJas/Netflix_Analysis/blob/main/Visuals/Movies_vs_TVshows.jpg)


**Objective:** Determine the distribution of content types on Netflix.

### 2. Find the Most Common Rating for Movies and TV Shows

```sql
SELECT type,
rating, COUNT(*) AS count
FROM netflix
WHERE rating IS NOT NULL
GROUP BY type, rating
ORDER BY type, count DESC
```

**Objective:** Identify the most frequently occurring rating for each type of content.

### 3. List All Movies Released in a Specific Year (e.g., 2020)

```sql
SELECT type,
        title,
        release_year
FROM netflix
WHERE release_year = 2012 AND type = 'Movie'

```

**Objective:** Retrieve all movies released in a specific year.

### 4. Find the Top 5 Countries with the Most Content on Netflix

```sql
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
```
#### VIsualization:
![](https://github.com/ButaniJas/Netflix_Analysis/blob/main/Visuals/Top5MostContentCountries.jpg)

**Objective:** Identify the top 5 countries with the highest number of content items.

### 5. Identify the Longest Movie

```sql
SELECT type,
    title,
    duration AS time
FROM netflix

WHERE type = 'Movie' AND duration = (SELECT MAX(duration) FROM netflix)
```

**Objective:** Find the movie with the longest duration.

### 6. Find Content Added in the Last 5 Years

```sql
SELECT 
    type,
    title,
    TO_DATE(date_added, 'Month DD, YYYY') AS date
FROM netflix
WHERE
    TO_DATE(date_added,'Month DD, YYYY') >= CURRENT_DATE - INTERVAL '5 years':: INTERVAL AND type = 'Movie'
```

**Objective:** Retrieve content added to Netflix in the last 5 years.

### 7. Find All Movies/TV Shows by Director 'Rajiv Chilaka'

```sql
SELECT type,
    title,
    director
FROM netflix
WHERE director LIKE '%Masahiko Murata%'
```

**Objective:** List all content directed by 'Rajiv Chilaka'.

### 8. List All TV Shows with More Than 5 Seasons

```sql
SELECT
    type,
    title,
    duration
FROM netflix
WHERE type = 'TV Show' 
AND CAST(SPLIT_PART(duration, ' ', 1) AS NUMERIC) > 5
ORDER BY
    CAST(SPLIT_PART(duration, ' ', 1) AS NUMERIC) DESC
```

**Objective:** Identify TV shows with more than 5 seasons.

### 9. Count the Number of Content Items in Each Genre

```sql
SELECT 
    COUNT(show_id),
    UNNEST(STRING_TO_ARRAY(listed_in, ',')) AS Genre
FROM netflix
GROUP BY 
2
ORDER BY
COUNT(show_id) DESC
```

**Objective:** Count the number of content items in each genre.

### 10.Find each year and the average numbers of content release in India on netflix. Return top 5 year with highest avg content release!

```sql
SELECT 
    release_year, 
    COUNT(show_id) AS total_content 
FROM netflix
WHERE country = 'India' 
GROUP BY release_year
ORDER BY total_content DESC 
LIMIT 5;

```
**Objective:** Calculate and rank years by the average number of content releases by India.

### 11. Find the top 3 most frequently added genres (listed_in) each year.

```sql
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
```
#### VIsualization:
![](https://github.com/ButaniJas/Netflix_Analysis/blob/main/Visuals/TendingContent.jpg)

**Objective:** Identify the top 3 most frequently added genres on Netflix each year to analyze content trends and audience preferences.

###12. Find the months when Netflix added the most content (Movies & TV Shows).

```sql
SELECT
    TO_CHAR(TO_DATE(date_added, 'Month DD, YYYY'), 'Month') AS Month,
    COUNT(*) AS total_releases
FROM netflix
WHERE date_added IS NOT NULL
GROUP BY Month
ORDER BY total_releases DESC
```

#### VIsualization:
![](https://github.com/ButaniJas/Netflix_Analysis/blob/main/Visuals/Busiest_Months_Netfilx.jpg)

**Objective:** Identify the months when Netflix added the most content to reveal peak content release periods.

## Findings and Conclusion

- **Movies vs. TV Shows:** Netflix is packed with movies—way more than TV shows—showing that they’re big on films.  
- **Audience Focus:** Most shows and movies are rated for mature audiences, like TV-MA and PG-13. Clearly, Netflix aims to keep adults entertained!  
- **Where’s the Content From?** The US, India, and the UK are the top content creators for Netflix. These countries are the heavy hitters in Netflix's library.  
- **What’s Popular?** Genres like Drama, Comedy, and Documentaries are everywhere. Recently, there’s been a boom in Stand-Up Comedy and Documentaries—Netflix knows what we like!  
- **Growing Library:** Netflix has been on a content-adding spree over the last five years, constantly giving us new stuff to watch.  
- **India’s Big Role:** Indian movies and shows are popping up more and more on Netflix, showing how much they value their Indian audience.  
- **Binge-Worthy Lengths:** Most movies run around 90 minutes, perfect for a movie night, while TV shows often have just a few seasons—enough to hook us but not overwhelm.  
- **Favorite Directors:** Some directors have tons of titles on Netflix, suggesting they have a good thing going with the platform.  

Overall, this analysis sheds light on what makes Netflix tick—from its favorite genres to its biggest contributors. It’s clear that Netflix knows its audience well and is always looking to grow and diversify its content. Happy streaming! 🍿📺


## By - JAS BUTANI

This project is part of my portfolio, showcasing the SQL skills essential for data analyst roles.
