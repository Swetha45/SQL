
-- Q.1 Find the countries that have three or more a in the name

SELECT name FROM world
WHERE name LIKE '%a%a%a%' ; 

-- Q.2 Find the countries that have "t" as the second character.

SELECT name FROM world
 WHERE name LIKE '_t%'
ORDER BY name

-- Q.3 Find the countries that have "t" as the second character.

    SELECT name FROM world
    WHERE name LIKE '%o__o%'; 

-- Q.4 Find the countries that have exactly four characters.

SELECT name FROM world
 WHERE name LIKE '____' ; 

 -- Q.5 Find the country where the name is the capital city.

 SELECT name
  FROM world
 WHERE name = capital;

 -- Q.6 Find the country where the capital is the country plus "City".

SELECT name
  FROM world
where capital like '% City%';

-- Q.7 Find the capital and the name where the capital includes the name of the country.

SELECT capital,name FROM world WHERE capital LIKE concat('%', name, '%');


-- SELECT from WORLD Tutorial

-- Q.1 Show the name for the countries that have a population of at least 200 million. 200 million is 200000000, there are eight zeros.

SELECT name
  FROM world
 WHERE population >= 200000000;

-- Q.2 Give the name and the per capita GDP for those countries with a population of at least 200 million.

select name, gdp/population
from world
where population  >= 200000000;

-- Q. 3 Show the name and population in millions for the countries of the continent 'South America'.

select name, population/1000000
from world
where continent = 'South America';

-- Q.4 Show the name and population for France, Germany, Italy

select name, population
from world
where name in ('France', 'Germany', 'Italy');

-- Q.5 Show the countries which have a name that includes the word 'United'

select name
from world
where name like '%United%';

-- Q.6 Show the countries that are big by area or big by population. Show name, population and area.

select name, population, area
from world
where population > 250000000 or area > 3000000;

-- Q.7 Exclusive OR (XOR). Show the countries that are big by area (more than 3 million) or big by population (more than 250 million) but not both. Show name, population and area.

-- Australia has a big area but a small population, it should be included.
-- Indonesia has a big population but a small area, it should be included.
-- China has a big population and big area, it should be excluded.
-- United Kingdom has a small population and a small area, it should be excluded.

select name,  population, area
from world
where (population > 250000000 or area > 3000000)
and NOT(population > 250000000 AND area > 3000000);

-- Q.8 Show the name and population in millions and the GDP in billions for the countries of the continent 'South America'. Use the ROUND function to show the values to two decimal places.

--For South America show population in millions and GDP in billions both to 2 decimal places.
--Millions and billions

select name, 
      round((population/1000000),2), 
      round((gdp/1000000000), 2)
from world
where continent = 'South America';

-- Q. 9 Show the name and per-capita GDP for those countries with a GDP of at least one trillion (1000000000000; that is 12 zeros). Round this value to the nearest 1000.
-- Show per-capita GDP for the trillion dollar countries to the nearest $1000.

-- In round function, negative number is used before the decimal place. 
select name, round(gdp/population, -3)
from world
where gdp>= 1000000000000;

-- Q.10 Greece has capital Athens.

-- Each of the strings 'Greece', and 'Athens' has 6 characters.

-- Show the name and capital where the name and the capital have the same number of characters.

-- You can use the LENGTH function to find the number of characters in a string

SELECT name,
      capital 
  FROM world
WHERE LEN(name) = LEN(capital);

-- Q.11 The capital of Sweden is Stockholm. Both words start with the letter 'S'.

--Show the name and the capital where the first letters of each match. Don't include countries where the name and the capital are the same word.
--You can use the function LEFT to isolate the first character.
-- You can use <> as the NOT EQUALS operator.

SELECT 
      name,
     capital
  FROM world
where left(name,1)= left(capital, 1) 
and name != capital ;

-- Q.12 --Equatorial Guinea and Dominican Republic have all of the vowels (a e i o u) in the name. They don't count because they have more than one word in the name.

--Find the country that has all the vowels and no spaces in its name.

--You can use the phrase name NOT LIKE '%a%' to exclude characters from your results.
-- The query shown misses countries like Bahamas and Belarus because they contain at least one 'a'

SELECT name
   FROM world
WHERE name LIKE '%a%' 
  and name LIKE '%e%'
  and name LIKE '%i%'
  and name LIKE '%o%'
  and name LIKE '%u%'
  and name NOT LIKE '% %';

------------------------------------ SELECT from Nobel Tutorial ---------------------------------------------

-- Q.1 Change the query shown so that it displays Nobel prizes for 1950.

SELECT yr, subject, winner
  FROM nobel
 WHERE yr = 1950;

-- Q.2 Show who won the 1962 prize for Literature.

SELECT winner
  FROM nobel
 WHERE yr = 1962
   AND subject = 'Literature';

-- Q.3 Show the year and subject that won 'Albert Einstein' his prize.

SELECT yr, subject
  FROM nobel
where winner = 'Albert Einstein' ; 

-- Q.4 Give the name of the 'Peace' winners since the year 2000, including 2000.

SELECT winner
  FROM nobel
where yr >= 2000 and subject = 'Peace'; 

-- Q.5 Show all details (yr, subject, winner) of the Literature prize winners for 1980 to 1989 inclusive.

select yr, subject, winner
from nobel
where yr between 1980 and 1989 
and subject = 'Literature' ;

-- Q.6 Show all details of the presidential winners:

-- Theodore Roosevelt
-- Woodrow Wilson
-- Jimmy Carter
-- Barack Obama

SELECT * FROM nobel
where winner IN ('Theodore Roosevelt',
                  'Woodrow Wilson',
                  'Jimmy Carter',
                  'Barack Obama'
                );

-- Q.7 Show the winners with first name John

SELECT winner 
FROM nobel
where winner like 'John%';

-- Q.8 Show the year, subject, and name of Physics winners for 1980 together with the Chemistry winners for 1984.

select yr, subject, winner
from nobel
where subject = 'Physics' and yr= 1980
or subject = 'Chemistry' and yr= 1984;

-- Q.9 Show the year, subject, and name of winners for 1980 excluding Chemistry and Medicine

select yr, subject, winner
from nobel
where subject not in ('Chemistry', 'Medicine')
and yr = 1980;

-- Q.10 Show year, subject, and name of people who won a 'Medicine' prize in an early year (before 1910, not including 1910) together with winners of a 'Literature' prize in a later year (after 2004, including 2004)

select yr, subject, winner
from nobel
where (subject = 'Medicine' and yr < 1910)
or (subject = 'Literature' and yr >= 2004) ;

-- Q.11 Find all details of the prize won by PETER GRÜNBERG

select *
from nobel
where winner = 'PETER GRÜNBERG';

-- Q.12 Find all details of the prize won by EUGENE O'NEILL

select *
from nobel
where winner = 'EUGENE O''NEILL';

-- Q.13 List the winners, year and subject where the winner starts with Sir. Show the the most recent first, then by name order.

select winner, yr, subject
from nobel
where winner like 'Sir%'
order by yr desc, winner ;

-- Q.14 Show the 1984 winners and subject ordered by subject and winner name; but list Chemistry and Physics last.

SELECT 
  winner, subject
FROM 
  nobel
WHERE 
  yr = 1984
ORDER BY 
  CASE WHEN subject IN ('Physics','Chemistry') THEN 1 ELSE 0 END, 
  subject, 
  winner ; 


------------------------   SELECT within SELECT Tutorial  ----------------------


-- Q.1 List each country name where the population is larger than that of 'Russia'.

SELECT name FROM world
  WHERE population >
     (SELECT population FROM world
      WHERE name='Russia');

-- Q.2 Show the countries in Europe with a per capita GDP greater than 'United Kingdom'.

-- Per Capita GDP

select name
from 
world 
where continent = 'Europe' 
and gdp/population > (select ww.gdp/population
from 
world ww 
where name = 'United Kingdom' )

-- Q.3 List the name and continent of countries in the continents containing either Argentina or Australia. Order by name of the country.

select name, continent
from world
where continent in (select continent from world where name in ('Argentina', 'Australia' ) )
order by name ; 

-- Q.4 Which country has a population that is more than Canada but less than Poland? Show the name and the population.

select name, population
from world
where population >  (select population from world where name = 'Canada' ) and population< (select population from world where name = 'Poland' );

-- Q.5 Show the name and the population of each country in Europe. Show the population as a percentage of the population of Germany.

SELECT name, CONCAT(ROUND(population/(SELECT population FROM world WHERE name = 'Germany')*100), '%') FROM world WHERE continent = 'Europe';

-- Q.6 Which countries have a GDP greater than every country in Europe? [Give the name only.] (Some countries may have NULL gdp values)

select name
from world  
where gdp > All (select gdp from world where continent = 'Europe' and gdp > 0) ;

-- Q.7 Find the largest country (by area) in each continent, show the continent, the name and the area

select continent, name, area
from world w
where area >=ALL( select area from world w1 
                    where w1.continent = w.continent and w1.area >0 )
order by area desc

-- Q.8 List each continent and the name of the country that comes first alphabetically.

select continent, name
from world w
where name <= ALL( select name from world w1 
                    where w1.continent = w.continent 
                )
 order by name desc ;

-- Q.9 Find the continents where all countries have a population <= 25000000. Then find the names of the countries associated with these continents. Show name, continent and population.

select w.name, w.continent , w.population
from  world w 
join ( select continent, max(population) max_pop
            from world 
            group by continent
            having max(population) <= 25000000
           ) as w1
on w1.continent = w.continent ;

--Q.10. Some countries have populations more than three times that of any of their neighbours (in the same continent). Give the countries and continents.

SELECT name, continent 
   FROM world w
  WHERE population > ALL( SELECT 3*population FROM world w1 
                           WHERE w.continent = w1.continent
                             AND w.name <> w1.name);

-------==============================   SUM and COUNT ======================================

--Q.1 Show the total population of the world.

SELECT SUM(population)
FROM world ;

-- Q.2 List all the continents - just once each.

SELECT continent
FROM world
GROUP BY continent;

-- Q.3 Give the total GDP of Africa

SELECT SUM(GDP)
FROM world
WHERE continent = 'Africa';

-- Q.4 How many countries have an area of at least 1000000

select count(name)
from world
where area >= 1000000;

-- Q.5 What is the total population of ('Estonia', 'Latvia', 'Lithuania')

select sum(population)
from world
where name in ('Estonia', 'Latvia', 'Lithuania');

-- Q.6 For each continent show the continent and number of countries.

select continent, count(name) as c_name
from world
group by continent;

-- Q.7 For each continent show the continent and number of countries with populations of at least 10 million.

select continent, count(name) as c_name
from world
where population >= 10000000
group by continent
;

-- Q.8 List the continents that have a total population of at least 100 million.

select continent
from world
group by continent
having sum(population) > 100000000;

-------==============================  The JOIN operation  ======================================

--Q.1 Modify it to show the matchid and player name for all goals scored by Germany. To identify German players, check for: teamid = 'GER'

SELECT matchid, player
FROM goal
WHERE teamid = 'GER';

--Q.2 Show id, stadium, team1, team2 for just game 1012

SELECT id,stadium,team1,team2
  FROM game
WHERE id = 1012;

--Q.3 Modify it to show the player, teamid, stadium and mdate for every German goal.

SELECT player ,teamid , stadium, mdate
  FROM game 
   JOIN goal 
    ON (id=matchid)
WHERE Teamid = 'GER';

--Q.4 Show the team1, team2 and player for every goal scored by a player called Mario player LIKE 'Mario%'

SELECT team1, team2, player
  FROM game 
   JOIN goal 
    ON (id=matchid)
WHERE player LIKE 'Mario%';

--Q.5 Show player, teamid, coach, gtime for all goals scored in the first 10 minutes gtime<=10

SELECT player, teamid, coach , gtime
  FROM goal join
       eteam 
on teamid = id 
 WHERE gtime<=10;

--Q.6 List the dates of the matches and the name of the team in which 'Fernando Santos' was the team1 coach.

SELECT mdate, teamname
from game join
eteam
on team1=eteam.id
where coach = 'Fernando Santos';

-- Q.7 List the player for every goal scored in a game where the stadium was 'National Stadium, Warsaw'

select player
from goal
join game
on matchid = id
where stadium = 'National Stadium, Warsaw';

-- Q.8 Instead show the name of all players who scored a goal against Germany.

select DISTINCT  player 
from goal
join game 
on id = matchid
where (team1 ='GER' or team2 ='GER')
and teamid!='GER';

-- Q.9 Show teamname and the total number of goals scored.

SELECT teamname, count(matchid)
  FROM eteam 
JOIN goal
 ON id=teamid
group by teamname
 ORDER BY teamname;

-- Q.10 Show the stadium and the number of goals scored in each stadium.

select stadium, count(id)
from game
join goal
on id = matchid
group by stadium ;

-- Q.11 For every match involving 'POL', show the matchid, date and the number of goals scored.

select matchid, mdate, count(id)
from game
join goal
on id = matchid
where team1 = 'POL' or team2 = 'POL'
group by matchid, mdate ; 

-- Q.12 For every match where 'GER' scored, show matchid, match date and the number of goals scored by 'GER'

select matchid, mdate, count(id)
from game
join goal
on id = matchid
where teamid  = 'GER'
group by matchid, mdate ; 

-- Q.13 List every match with the goals scored by each team as shown. This will use "CASE WHEN" which has not been explained in any previous exercises.
/* mdate	team1	score1	team2	score2
1 July 2012	ESP	4	ITA	0
/* 10 June 2012	ESP	1	ITA	1
10 June 2012	IRL	1	CRO	3
Notice in the query given every goal is listed. If it was a team1 goal then a 1 appears in score1, otherwise there is a 0. You could SUM this column to get a count of the goals scored by team1. Sort your result by mdate, matchid, team1 and team2.
*/

SELECT 
mdate,
team1,
SUM(
	case
	when teamid=team1 then 1
	ELSE 0
	END
) 
AS score1,
team2,
SUM(
	case
	when teamid=team2 then 1
	ELSE 0
	END
) 
AS score2
FROM game gm LEFT JOIN goal g ON(gm.id=g.matchid)
GROUP BY mdate,team1,team2
ORDER BY mdate,team1,team2;

-----=========================================  More JOIN operations =========================================

-- Q.1 List the films where the yr is 1962 [Show id, title]

SELECT id, title
 FROM movie
 WHERE yr=1962;

-- Q.2 When was Citizen Kane released?

select yr 
from movie
where title = 'Citizen Kane';

-- Q.3 List all of the Star Trek movies, include the id, title and yr (all of these movies include the words Star Trek in the title). Order results by year.

select id, title, yr
from movie
where title like '%Star Trek%'
order by yr;

-- Q.4 What id number does the actor 'Glenn Close' have?

select id
from actor
where name = 'Glenn Close' ;

-- Q.5 What is the id of the film 'Casablanca'

select id 
from movie 
where title = 'Casablanca';

-- Q.6 Obtain the cast list for 'Casablanca'.

/* what is a cast list?
Use movieid=11768, (or whatever value you got from the previous question) */

select actor.name 
from movie
join casting
on movie.id = movieid
join actor
on actorid = actor.id
where title = 'Casablanca';

-- Q.7 Obtain the cast list for the film 'Alien'

select actor.name 
from movie
join casting
on movie.id = movieid
join actor
on actorid = actor.id
where title = 'Alien';

-- Q.8 List the films in which 'Harrison Ford' has appeared

select title
from movie
join casting
on movie.id = movieid
join actor
on actorid = actor.id
where name = 'Harrison Ford';

-- Q.9 List the films where 'Harrison Ford' has appeared - but not in the starring role. [Note: the ord field of casting gives the position of the actor. If ord=1 then this actor is in the starring role]

select title
from movie
join casting
on movie.id = movieid
join actor
on actorid = actor.id
where name = 'Harrison Ford'
and ord != 1;

-- Q.10 List the films together with the leading star for all 1962 films.

select title, name
from movie
join casting
on movie.id = movieid
join actor
on actorid = actor.id
where yr = 1962
and ord = 1;

-- Q.11 Which were the busiest years for 'Rock Hudson', show the year and the number of movies he made each year for any year in which he made more than 2 movies.

select count(title), yr
from movie
join casting
on movie.id = movieid
join actor
on actorid = actor.id
where name = 'Rock Hudson'
group by name, yr
having count(title) >2;

-- Q.12 List the film title and the leading actor for all of the films 'Julie Andrews' played in.

/* Did you get "Little Miss Marker twice"?
Julie Andrews starred in the 1980 remake of Little Miss Marker and not the original(1934).

Title is not a unique field, create a table of IDs in your subquery */

select title, name
from movie
join casting
on movie.id = movieid
join actor
on actorid = actor.id
where ord = 1 AND movieid IN
(SELECT movieid FROM casting, actor
     WHERE actorid=actor.id
     AND name='Julie Andrews')
;

-- Q.13 Obtain a list, in alphabetical order, of actors who've had at least 15 starring roles.

select name
from actor
join casting 
on actorid = id
where ord  = 1
group by name
having count(movieid) >= 15 ;

-- Q.14 List the films released in the year 1978 ordered by the number of actors in the cast, then by title.

select title, count(actorid)
from movie, casting
where casting.movieid =  movie.id
and yr = 1978
group by title 
order by count(actorid) desc, title ;

-- Q.15 List all the people who have worked with 'Art Garfunkel'.

SELECT DISTINCT name
FROM actor JOIN casting ON id=actorid
WHERE movieid IN (SELECT movieid FROM casting JOIN actor ON (actorid=id AND name='Art Garfunkel')) AND name != 'Art Garfunkel'
GROUP BY name ;

----- =============================================  Using Null ======================================

-- Q.1 List the teachers who have NULL for their department.

select name 
from teacher
where dept is null;

-- Q.2 Note the INNER JOIN misses the teachers with no department and the departments with no teacher.

SELECT teacher.name, dept.name
 FROM teacher INNER JOIN dept
           ON (teacher.dept=dept.id);

-- Q.3 Use a different JOIN so that all teachers are listed.

SELECT teacher.name, dept.name
 FROM teacher left JOIN dept
           ON (teacher.dept=dept.id);

-- Q.4 Use a different JOIN so that all departments are listed.

SELECT teacher.name, dept.name
 FROM teacher right JOIN dept
           ON (teacher.dept=dept.id);

-- Q.5 Use COALESCE to print the mobile number. Use the number '07986 444 2266' if there is no number given. Show teacher name and mobile number or '07986 444 2266'

-- The COALESCE() function returns the first non-null value in a list.
SELECT name, 
       COALESCE(mobile, '07986 444 2266')
  FROM teacher;

-- Q.6 Use the COALESCE function and a LEFT JOIN to print the teacher name and department name. Use the string 'None' where there is no department.

SELECT teacher.name, COALESCE(dept.name, 'None')
 FROM teacher 
left JOIN dept
ON (teacher.dept=dept.id);

-- Q.7 Use COUNT to show the number of teachers and the number of mobile phones.

select count(teacher.name) as number_of_teachers,
       count(mobile) as number_of_mobiles
from teacher;

-- Q.8 Use COUNT and GROUP BY dept.name to show each department and the number of staff. Use a RIGHT JOIN to ensure that the Engineering department is listed.

select dept.name, 
       count(teacher.name) as number_of_teachers
from teacher right join dept
on teacher.dept=dept.id
group by dept.name ;

-- Q.9 Use CASE to show the name of each teacher followed by 'Sci' if the teacher is in dept 1 or 2 and 'Art' otherwise.

select name, case when dept in (1, 2) 
         then 'Sci' 
         else 'Art' 
       end as name_t
from teacher;

-- Q.10 Use CASE to show the name of each teacher followed by 'Sci' if the teacher is in dept 1 or 2, show 'Art' if the teacher's dept is 3 and 'None' otherwise

SELECT name, 
      CASE WHEN dept IN (1, 2) 
               THEN 'Sci'
            WHEN dept = 3 
                THEN 'Art' 
            ELSE 'None' 
      END from teacher;

-- =========================================  NSS Tutorial ================================

-- Q.1 Show the the percentage who STRONGLY AGREE

SELECT A_STRONGLY_AGREE
  FROM nss
 WHERE question='Q01'
   AND institution='Edinburgh Napier University'
   AND subject='(8) Computer Science' ; 

-- Q.2 Show the institution and subject where the score is at least 100 for question 15.

SELECT institution, subject
  FROM nss
 WHERE score  > = 100 
   and question='Q15';

-- Q.3 Show the institution and score where the score for '(8) Computer Science' is less than 50 for question 'Q15'

SELECT institution, score
  FROM nss
 WHERE question='Q15'
   AND score < 50 
   AND subject='(8) Computer Science' ;

-- Q.4 Show the subject and total number of students who responded to question 22 for each of the subjects '(8) Computer Science' and '(H) Creative Arts and Design'.

SELECT subject, sum(response)
  FROM nss
 WHERE question ='Q22'
   AND subject in ( '(8) Computer Science' , 
                    '(H) Creative Arts and Design'
                   )
group by subject ;

-- Q.5 Show the subject and total number of students who A_STRONGLY_AGREE to question 22 for each of the subjects '(8) Computer Science' and '(H) Creative Arts and Design'.

SELECT subject, SUM(response * A_STRONGLY_AGREE / 100)
  FROM nss
 WHERE question  = 'Q22' 
   AND subject in ( '(8) Computer Science' , 
                    '(H) Creative Arts and Design'
                   )
group by subject ; 

-- Q.6 Show the percentage of students who A_STRONGLY_AGREE to question 22 for the subject '(8) Computer Science' show the same figure for the subject '(H) Creative Arts and Design'.

-- Use the ROUND function to show the percentage without decimal places.

SELECT subject, ROUND(SUM(response*A_STRONGLY_AGREE)/SUM(response), 2)
FROM nss
WHERE question='Q22'
AND subject IN ('(8) Computer Science', '(H) Creative Arts and Design')
GROUP BY subject; 

-- Q.7 Show the average scores for question 'Q22' for each institution that include 'Manchester' in the name.

SELECT institution , ROUND(SUM(score * response) / SUM(response), 1)
  FROM nss
 WHERE question='Q22' 
   and institution like '%Manchester%'
group by institution ;

-- Q.8 Show the institution, the total sample size and the number of computing students for institutions in Manchester for 'Q01'.

SELECT institution ,  sum (sample) sample_size ,
      sum (CASE WHEN subject = '(8) Computer Science' THEN sample ELSE 0 
      END) as c_student  ​
 ​FROM nss
WHERE question='Q22' 
  ​and institution like '%Manchester%'
group by institution ;

---- ====================================   Window functions  ================================

-- Q.1 Show the lastName, party and votes for the constituency 'S14000024' in 2017.

SELECT lastName, party, votes
  FROM ge
 WHERE constituency = 'S14000024' AND yr = 2017
ORDER BY votes DESC;

-- Q.2 Show the party and RANK for constituency S14000024 in 2017. List the output by party

select party, votes,
RANK () over (ORDER BY votes desc)
 FROM ge
 WHERE constituency = 'S14000024' AND yr = 2017
order by party;

-- Q.3 The 2015 election is a different PARTITION to the 2017 election. We only care about the order of votes for each year.

/* Use PARTITION to show the ranking of each party in S14000021 in each year. 
Include yr, party, votes and ranking (the party with the most votes is 1).
*/

SELECT yr,party, votes,
      RANK() OVER (PARTITION BY yr ORDER BY votes DESC) as votes_rank
  FROM ge
 WHERE constituency = 'S14000021'
ORDER BY party,yr ;

-- Q.4 Edinburgh constituencies are numbered S14000021 to S14000026.

/*  Use PARTITION BY constituency to show the ranking of each party in Edinburgh in 2017. Order your results so the winners are shown first, then ordered by constituency./*  */

select constituency, 
       party,
       votes, 
    RANK() OVER (PARTITION BY constituency order by votes desc) as 
        winners
from ge
where yr = 2017 
and constituency between 'S14000021' and 'S14000026'
order by winners, constituency ;


-- Q.5 Show the parties that won for each Edinburgh constituency in 2017.

select constituency, 
       party
from
  ( select 
       constituency , 
       party,
       votes,
       RANK() OVER (PARTITION BY constituency order by votes desc) 
        as winner 
    from ge 
    where yr = 2017  
     and constituency between 'S14000021' and 'S14000026'
  ) as w1
where w1.winner = 1 ; 

-- Q.6 Show how many seats for each party in Scotland in 2017.

select party , count (winner)
from
  ( select 
       constituency , 
       party,
       votes,
       RANK() OVER (PARTITION BY constituency order by votes desc) 
        as winner 
    from ge 
    where yr = 2017  
   and constituency like 'S%'
  ) as w1
group by party; 

