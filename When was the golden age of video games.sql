--When was the golden age of video games? 


-- Select all information for the top ten best-selling games
-- Order the results from best-selling game down to tenth best-selling
select * 

FROM game_sales
ORDER BY games_sold DESC
LIMIT 10



-- Join games_sales and reviews
-- Select a count of the number of games where both critic_score and user_score are null

SELECT COUNT(g.game)
FROM game_sales g
LEFT JOIN reviews r
ON g.game = r.game
WHERE critic_score IS NULL AND user_score IS NULL


-- Select release year and average critic score for each year, rounded and aliased
-- Join the game_sales and reviews tables
-- Group by release year
-- Order the data from highest to lowest avg_critic_score and limit to 10 results

SELECT g.year, ROUND(avg(r.critic_score), 2) as avg_critic_score
FROM game_sales g
JOIN reviews r
ON g.game = r.game
GROUP BY g.year
ORDER BY avg_critic_score DESC
limit 10



-- Paste your query from the previous task; update it to add a count of games released in each year called num_games
-- Update the query so that it only returns years that have more than four reviewed games
SELECT g.year,  count(g.game) as num_games, ROUND(avg(r.critic_score), 2) as avg_critic_score
FROM game_sales g
JOIN reviews r
ON g.game = r.game
GROUP BY g.year
Having count(g.game) > 4
ORDER BY avg_critic_score DESC
limit 10

-- Select the year and avg_critic_score for those years that dropped off the list of critic favorites 
-- Order the results from highest to lowest avg_critic_score
SELECT year, avg_critic_score
FROM top_critic_years
EXCEPT 
SELECT year, avg_critic_score 
FROM top_critic_years_more_than_four_games
ORDER BY avg_critic_score DESC

-- Select year, an average of user_score, and a count of games released in a given year, aliased and rounded
-- Include only years with more than four reviewed games; group data by year
-- Order data by avg_user_score, and limit to ten results
SELECT g.year, count(g.game) as num_games, round(avg(r.user_score), 2) as avg_user_score
FROM reviews as r
JOIN game_sales as g
ON r.game = g.game
GROUP BY g.year
HAVING count(g.year) >4
ORDER BY avg_user_score DESC 
limit 10


-- Select the year results that appear on both tables
SELECT year
FROM top_critic_years_more_than_four_games
INTERSECT  
SELECT year 
FROM top_user_years_more_than_four_games

LIMIT 3


-- Select year and sum of games_sold, aliased as total_games_sold; order results by total_games_sold descending
-- Filter game_sales based on whether each year is in the list returned in the previous task
SELECT year, sum(games_sold) as total_games_sold
FROM game_sales
WHERE year in (SELECT year
FROM top_critic_years_more_than_four_games
INTERSECT  
SELECT year 
FROM top_user_years_more_than_four_games)
GROUP BY year
ORDER BY total_games_sold DESC











































