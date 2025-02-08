
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

