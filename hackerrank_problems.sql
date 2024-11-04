## Q : Weather Observation Station 3

Query a list of CITY names from STATION for cities that have an even ID number. Print the results in any order, but exclude duplicates from the answer.
The STATION table is described as follows:

Solution: 
 
 SELECT NAME FROM CITY WHERE COUNTRYCODE = 'USA' AND POPULATION > 120000;

## Q : Weather Observation Station  4

Find the difference between the total number of CITY entries in the table and the number of distinct CITY entries in the table.

Solution: 

SELECT (COUNT(city) - COUNT(DISTINCT city)) AS difference
    FROM station;

## Q : Weather Observation Station  5
	
Query the two cities in STATION with the shortest and longest CITY names, as well as their respective lengths (i.e.: number of characters in the name). 
If there is more than one smallest or largest city, choose the one that comes first when ordered alphabetically.	

Solution: 	
(select CITY, length(CITY) as city_len from STATION order by city_len asc, CITY asc limit 1) union
(select CITY, length(city) as city_len from STATION order by city_len desc, CITY asc limit 1);

## Q : Weather Observation Station  6

Query the list of CITY names starting with vowels (i.e., a, e, i, o, or u) from STATION. 
Your result cannot contain duplicates.	
	
Solution: 
SELECT DISTINCT(CITY) 
FROM STATION 
WHERE CITY 
     LIKE 'A%' OR CITY LIKE 'E%' OR CITY LIKE 'I%' OR CITY LIKE 'O%' OR CITY LIKE 'U%' 
ORDER BY CITY ASC;  


## Q : Weather Observation Station  7

Query the list of CITY names ending with vowels (a, e, i, o, u) from STATION. 
Your result cannot contain duplicates.

Solution:
SELECT DISTINCT(CITY)
 FROM STATION 
 WHERE CITY LIKE '%a' OR CITY LIKE '%e' OR CITY LIKE '%i' OR CITY LIKE '%o' OR CITY LIKE '%u';     


## Q : Weather Observation Station  8

Query the list of CITY names from STATION which have vowels (i.e., a, e, i, o, and u) as both their first and last characters. 
Your result cannot contain duplicates.	

Solution:

SELECT DISTINCT CITY 
FROM STATION 
WHERE (CITY LIKE 'A%' OR CITY LIKE 'E%' OR CITY LIKE 'I%' OR CITY LIKE 'O%' OR CITY LIKE 'U%') 
    AND (CITY LIKE '%a' OR CITY LIKE '%e' OR CITY LIKE '%i' OR CITY LIKE '%o' OR CITY LIKE '%u') 
order by city;      

## Q : Weather Observation Station  9

Query the list of CITY names from STATION that do not start with vowels. Your result cannot contain duplicates.

Solution:
SELECT DISTINCT CITY 
FROM STATION 
WHERE upper(SUBSTR(CITY,1,1)) NOT IN ('A','E','I','O','U') 
  AND lower(SUBSTR(CITY,1,1)) NOT IN ('a','e','i','o','u');  

## Q : Weather Observation Station  10

Query the list of CITY names from STATION that do not end with vowels. 
Your result cannot contain duplicates.

Solution:
SELECT DISTINCT 
CITY FROM STATION 
WHERE UPPER(SUBSTR(CITY, LENGTH(CITY), 1)) NOT IN ('A','E','I','O','U') 
  AND LOWER(SUBSTR(CITY, LENGTH(CITY),1)) NOT IN ('a','e','i','o','u');    

## Q : Weather Observation Station  11

Query the list of CITY names from STATION that either do not start with vowels or do not end with vowels. 
Your result cannot contain duplicates.


Solution:
SELECT DISTINCT CITY 
FROM STATION 
WHERE LOWER(SUBSTR(CITY,1,1)) NOT IN ('a','e','i','o','u') 
   OR LOWER(SUBSTR(CITY, LENGTH(CITY),1)) NOT IN ('a','e','i','o','u');   
   
   
## Q : Weather Observation Station  12
Query the list of CITY names from STATION that do not start with vowels and do not end with vowels. 
Your result cannot contain duplicates.

Solution:
SELECT DISTINCT
 CITY FROM STATION 
 WHERE LOWER(SUBSTR(CITY,1,1)) NOT IN ('a','e','i','o','u') 
 AND LOWER(SUBSTR(CITY,LENGTH(CITY),1)) NOT IN ('a','e','i','o','u');    

## Q : Higher Than 75 marks

Query the Name of any student in STUDENTS who scored higher than  Marks. 
Order your output by the last three characters of each name. 
If two or more students both have names ending in the same last three characters (i.e.: Bobby, Robby, etc.), 
secondary sort them by ascending ID.

SELECT NAME FROM STUDENTS 
WHERE MARKS > 75 
ORDER BY SUBSTR(NAME, LENGTH(NAME)-2, 3), ID; 

## Q : Weather Observation Station 15 

Query the Western Longitude (LONG_W) for the largest Northern Latitude (LAT_N) in STATION that is less than . 
Round your answer to  decimal places.

Solution 1: 
select round(LONG_W, 4)
from station
where LAT_N < 137.2345
order by LAT_N desc 
limit 1; 

Solution 2: 

select long_W
from
( select round(LONG_W, 4) as long_W, max(LAT_N) as higher_long
from station
group by long_W
having higher_long < 137.2345
order by higher_long desc) res
limit 1 ; 

## Q : Weather Observation Station 17

Query the Western Longitude (LONG_W)where the smallest Northern Latitude (LAT_N) in STATION is greater than . 
Round your answer to  decimal places.

Solution : 

select long_W
from
( select round(LONG_W, 4) as long_W, min(LAT_N) as smaller_long
from station
group by long_W
having smaller_long > 38.7780
order by smaller_long) res
limit 1 ; 



## Q : Weather Observation Station 18

Consider  and  to be two points on a 2D plane.

 a happens to equal the minimum value in Northern Latitude (LAT_N in STATION).
 b happens to equal the minimum value in Western Longitude (LONG_W in STATION).
 c happens to equal the maximum value in Northern Latitude (LAT_N in STATION).
 d happens to equal the maximum value in Western Longitude (LONG_W in STATION).
Query the Manhattan Distance between points  and  and round it to a scale of  decimal places.

where LAT_N is the northern latitude and LONG_W is the western longitude.

Solution:  

SELECT ROUND(ABS(MIN(LAT_N) - MAX(LAT_N)) + ABS(MAX(LONG_W) - MIN(LONG_W)),4) FROM STATION;

## Q : Weather Observation Station 19

Consider  and  to be two points on a 2D plane 
where  are the respective minimum and maximum values of 
Northern Latitude (LAT_N) and  are the respective minimum and maximum values 
of Western Longitude (LONG_W) in STATION.

Query the Euclidean Distance between points  and  and format your answer to display  decimal digits.
Formula =  d(p,q)={ sqrt {(p_{1}-q_{1})^{2}+(p_{2}-q_{2})^{2}}}.}

Solution:  

select round(SQRT(POW(ABS(min(LAT_N)- max(LAT_N)), 2) + 
                  POW(ABS(min(LONG_W)- max(LONG_W)), 2)
				  ), 
		   4)
from STATION 

## Q : Weather Observation Station 20

A median is defined as a number separating the higher half of a data set from the lower half. 
Query the median of the Northern Latitudes (LAT_N) from STATION and round your answer to  decimal places.

Steps: firstly order the result set into asc order
     2. assign unique row number to each row
	 3. caluculate median value like half of the values before and after the value
	 4. use count(*)/2 function to get the half number of values into total values
		ex: 10 records - then 10/2 = 5 records
	 5. check whether this row number is exists in half number of values.
	 6. once find the median then round that to 4 decimals
	 
select round(lat_n, 4)
from 
( select row_number() over(order by lat_n asc) as rw_number
     ,lat_n 
      from station ) a 
where rw_number= (select round(count(*)/2) from station); 


## Q : interviews


Samantha interviews many candidates from different colleges using coding challenges and contests. 
Write a query to print the contest_id, hacker_id, name, and the sums of total_submissions, total_accepted_submissions, total_views, and total_unique_views for each contest sorted by contest_id. 
Exclude the contest from the result if all four sums are .

Note: A specific contest can be used to screen candidates at more than one college, but each college only holds  screening contest.

with total_subm as
( select Colleges.contest_id, 
         Submission_Stats.total_submissions,
         Submission_Stats.total_accepted_submissions
 from Colleges inner join Challenges
    on Colleges.college_id = Challenges.college_id
inner join Submission_Stats
    on Submission_Stats.challenge_id = Challenges.challenge_id
),
 total_views as
( select Colleges.contest_id, 
         View_Stats.total_views,
         View_Stats.total_unique_views
 from Colleges inner join Challenges
    on Colleges.college_id = Challenges.college_id
inner join View_Stats 
    on View_Stats.challenge_id = Challenges.challenge_id
)
select Contests.contest_id, 
       Contests.hacker_id, 
       Contests.name, 
       sum(ts.total_submissions),
       sum(ts.total_accepted_submissions),
       sum(tv.total_views),
       sum(tv.total_unique_views)
from Contests inner join total_subm ts 
        on ts.contest_id = Contests.contest_id
inner join total_views tv 
       on tv.contest_id = Contests.contest_id
group by 1,2,3
having sum(ts.total_submissions) +
       sum(ts.total_accepted_submissions) +
       sum(tv.total_views)+
       sum(tv.total_unique_views) > 0
order by Contests.contest_id ; 

we may get error with above querry. 
or above

SELECT con.contest_id, con.hacker_id, con.name, SUM(sg.total_submissions), SUM(sg.total_accepted_submissions),
SUM(vg.total_views), SUM(vg.total_unique_views)
FROM Contests AS con 
JOIN Colleges AS col
ON con.contest_id = col.contest_id
JOIN Challenges AS cha 
ON cha.college_id = col.college_id
LEFT JOIN
(SELECT ss.challenge_id, SUM(ss.total_submissions) AS total_submissions, SUM(ss.total_accepted_submissions) AS total_accepted_submissions FROM 
Submission_Stats AS ss GROUP BY ss.challenge_id) AS sg
ON cha.challenge_id = sg.challenge_id
LEFT JOIN
(SELECT vs.challenge_id, SUM(vs.total_views) AS total_views, SUM(total_unique_views) AS total_unique_views FROM View_Stats AS vs GROUP BY vs.challenge_id) AS vg
ON cha.challenge_id = vg.challenge_id
GROUP BY con.contest_id, con.hacker_id, con.name
HAVING SUM(sg.total_submissions)+
       SUM(sg.total_accepted_submissions)+
       SUM(vg.total_views)+
       SUM(vg.total_unique_views) > 0
ORDER BY con.contest_id;

## Q :  Drwa The Traingle 1

* * * * * 
* * * * 
* * * 
* * 
*
P(R) represents a pattern drawn by Julia in R rows. The following pattern represents P(5):
 steps: 1. use the repeat function  Syntax: REPEAT(string, number) to repeat number of times.
        2. iterate through the loop untill it reached to 1.
		3. to do this first declare variable as 'i' datatype - INTEGER, provide default values as 20.
		4. use the while looop to interate values
		5. use the SET function to do the I= i-1
		at the end to run this script, need to create stored PROCEDURE
		use CALL function to call procedure in MYSQL
		IN mysql, when we use ; characters, a problem may arise. by default mysql itself recognise the ; as a statement delimeter. 
		to resolve this need to redefine the delimeter temorarily to cause mysql to pass the stored proecedure.
		

Solution:
		
DELIMITER $$
CREATE PROCEDURE PATTERN_20()
BEGIN
    DECLARE i INT Default 20;
    WHILE i > 0 
    DO
        select REPEAT('* ', i);
        SET i = i-1;
    END While;
END$$
DELIMITER ; 

CALL PATTERN_20();

## Q :  Drwa The Traingle 2

P(R) represents a pattern drawn by Julia in R rows. 
The following pattern represents P(5):

* 
* * 
* * * 
* * * * 
* * * * *

Solution:  

DELIMITER $$
CREATE PROCEDURE pattern_20()
BEGIN
    DECLARE i INT DEFAULT 1;
    WHILE i <=20
    DO
        select REPEAT('* ', i);
        SET i = i + 1;
    END WHILE;
END$$
DELIMITER ; 

CALL pattern_20();

## Q Symmetric Pairs
       
You are given a table, Functions, containing two columns: X and Y.



Two pairs (X1, Y1) and (X2, Y2) are said to be symmetric pairs if X1 = Y2 and X2 = Y1.

Write a query to output all such symmetric pairs in ascending order by the value of X. List the rows such that X1 ≤ Y1.


select A.X, A.Y
from functions A join 
functions  B 
on A.X = B.Y and B.X = A.Y
group by A.X, A.Y
having count(*) > 1 OR A.X < A.Y
order by A.X ;

## Q: 
Generate the following two result sets:
1.	Query an alphabetically ordered list of all names in OCCUPATIONS, immediately followed by the first letter of each profession as a parenthetical (i.e.: enclosed in parentheses). For example: AnActorName(A), ADoctorName(D), AProfessorName(P), and ASingerName(S).
2.	Query the number of ocurrences of each occupation in OCCUPATIONS. Sort the occurrences in ascending order, and output them in the following format:
3.	There are a total of [occupation_count] [occupation]s.
where [occupation_count] is the number of occurrences of an occupation in OCCUPATIONS and [occupation] is the lowercase occupation name. If more than one Occupation has the same [occupation_count], they should be ordered alphabetically.
Note: There will be at least two entries in the table for each type of occupation.
Input Format
The OCCUPATIONS table is described as follows:   Occupation will only contain one of the following values: Doctor, Professor, Singer or Actor.
Sample Input
An OCCUPATIONS table that contains the following records:
 
Sample Output
Ashely(P)
Christeen(P)
Jane(A)
Jenny(D)
Julia(A)
Ketty(P)
Maria(A)
Meera(S)
Priya(S)
Samantha(D)
There are a total of 2 doctors.
There are a total of 2 singers.
There are a total of 3 actors.
There are a total of 3 professors.
Explanation
The results of the first query are formatted to the problem descriptions specifications.
The results of the second query are ascendingly ordered first by number of names corresponding to each profession (), and then alphabetically by profession (, and ).

Solution: 


SELECT CONCAT(NAME,"(",SUBSTR(OCCUPATION,1,1),")") 
FROM OCCUPATIONS 
ORDER BY NAME;

SELECT CONCAT("There are a total of ",COUNT(OCCUPATION)," ",LOWER(OCCUPATION),"s.") 
FROM OCCUPATIONS 
GROUP BY OCCUPATION 
ORDER BY COUNT(OCCUPATION), OCCUPATION;

## Q: Pivot the Occupation column in OCCUPATIONS so that each Name is sorted alphabetically and displayed underneath its corresponding Occupation.
 The output column headers should be Doctor, Professor, Singer, and Actor, respectively.

Solution: 
 
select 
max(case when occupation= 'Doctor' then name end) as Doctor ,
max(case when occupation= 'Professor' then name end) as Professor ,
max(case when occupation= 'Singer' then name end) as Singer ,
max(case when occupation= 'Actor' then name end) as Actor  
from 
(
select row_number() over(partition by occupation order by name ) as row_no,
        name, 
        occupation
from OCCUPATIONs
    ) as sub_query
group by row_no
    ; 
	
## Q:  You are given a table, BST, containing two columns: N and P, 
   where N represents the value of a node in Binary Tree, and P is the parent of N.
   
Solution: 

select N, 
   case when P is null then 'Root'
       when N IN (select distinct P from BST) THEN 'Inner' ELSE 'Leaf' 
   END AS res
  from BST
   order by N;


Q Ambers conglomerate corporation just acquired some new companies. 
Each of the companies follows this hierarchy:

Solution: 

select c1.company_code,
      founder,
      count(distinct lm1.lead_manager_code) as no_of_lead_managers,
      count(distinct sm1.senior_manager_code) as no_of_senior_managers,
      count(distinct m1.manager_code) as no_of_managers,
      count(distinct e1.employee_code) as no_of_employees
from Company c1
join Lead_Manager lm1 
     on c1.company_code = lm1.company_code
join Senior_Manager sm1
     on lm1.lead_manager_code = sm1.lead_manager_code
join Manager m1
     on sm1.senior_manager_code = m1.senior_manager_code
join Employee e1
     on m1.manager_code = e1.manager_code
group by c1.company_code,
      founder
;

Or 

select c1.company_code,
      founder,
      count(distinct e1.lead_manager_code) as no_of_lead_managers,
      count(distinct e1.senior_manager_code) as no_of_senior_managers,
      count(distinct e1.manager_code) as no_of_managers,
      count(distinct e1.employee_code) as no_of_employees
from Company c1
join Employee e1
     on c1.company_code = e1.company_code
group by c1.company_code,
      founder
;

Harry Potter and his friends are at Ollivander's with Ron, finally replacing Charlie's old broken wand.

##Q. Hermione decides the best way to choose is by determining the minimum number of gold galleons needed to buy each non-evil wand of high power and age. 
Write a query to print the id, age, coins_needed, and power of the wands that Rons interested in, sorted in order of descending power.
If more than one wand has same power, sort the result in order of descending age.

Input Format

The following tables contain data on the wands in Ollivanders inventory:

Wands: The id is the id of the wand, code is the code of the wand,coins_needed is the total number of gold galleons needed to buy the wand, 
and power denotes the quality of the wand (the higher the power, the better the wand is).

Wands_Property: The code is the code of the wand, age is the age of the wand, and is_evil denotes whether the wand is good for the dark arts. 
If the value of is_evil is 0, it means that the wand is not evil. The mapping between code and age is one-one, meaning that if there are two pairs,  and , then  and .

Sample Output

9 45 1647 10
12 17 9897 10
1 20 3688 8
15 40 6018 7
19 20 7651 6
11 40 7587 5
10 20 504 5
18 40 3312 3
20 17 5689 3
5 45 6020 2
14 40 5408 1

https://www.hackerrank.com/challenges/harry-potter-and-wands/problem?isFullScreen=true

Solution:

Steps: 1. find the minumum number of gallons needed for each wand by age and power and non evil wand
       2. write inner query to step 1
	   3. check whether coin needed for inner query is matching with the outer Query
	   
select W.id, 
       WP.age, 
       W.coins_needed,
       W.power
from Wands W 
join Wands_Property WP
on W.code = WP.code
where W.coins_needed = 
( select min(W2.coins_needed) as min_coins
    from  Wands W2 join Wands_Property WP2
   on  W2.code = WP2.code 
      where WP2.is_evil = 0 
      and WP.age =  WP2.age
 and  W.power =  W2.power
 )
 order by W.power desc, WP.age desc; 
 
 ##Q.  Julia asked her students to create some coding challenges. Write a query to print the hacker_id, name, and the total number of challenges created by each student. 
 Sort your results by the total number of challenges in descending order. 
 If more than one student created the same number of challenges, then sort the result by hacker_id. If more than one student created the same number of challenges and the count is less than the maximum number of challenges created, then exclude those students from the result.

Input Format

The following tables contain challenge data:

Hackers: The hacker_id is the id of the hacker, and name is the name of the hacker.

Solution:

with total_challenges as 
(
select H.hacker_id, 
       H.name, 
       count(C.challenge_id) as no_of_challenges
     from Hackers H
     join Challenges C
     on H.hacker_id = C.hacker_id
     group by 1, 2
) ,
count_challnges AS
(
select no_of_challenges, 
       count(no_of_challenges) as cnt_of_challnges
    from total_challenges 
    group by 1
)
select tc.hacker_id, 
       tc.name,
       tc.no_of_challenges
from total_challenges tc 
join count_challnges ch 
on tc.no_of_challenges = ch.no_of_challenges
where ch.cnt_of_challnges <= 1
OR tc.no_of_challenges =  (select max(tc.no_of_challenges) from  total_challenges tc )
order by tc.no_of_challenges desc, hacker_id ;

## Q: 
You did such a great job helping Julia with her last coding contest challenge that she wants you to work on this one, too!

The total score of a hacker is the sum of their maximum scores for all of the challenges. Write a query to print the hacker_id, name, and total score of the hackers ordered by the descending score. If more than one hacker achieved the same total score, then sort the result by ascending hacker_id. Exclude all hackers with a total score of  from your result.

https://www.hackerrank.com/challenges/contest-leaderboard/problem?isFullScreen=true

Input Format

The following tables contain contest data:

Hackers: The hacker_id is the id of the hacker, and name is the name of the hacker.

Solution:


WITH a as (
SELECT 
     h.hacker_id
    ,name
    ,challenge_id
    ,max(score) as max_score
FROM Hackers h
join Submissions s on h.hacker_id = s.hacker_id
GROUP BY h.hacker_id, name, challenge_id
    )
    SELECT 
     hacker_id
    ,name
    ,sum(max_score) as total_score
FROM a
GROUP BY hacker_id, name
HAVING sum(max_score) > 0
ORDER BY sum(max_score) desc, hacker_id ;

## Q: 

https://www.hackerrank.com/challenges/sql-projects/problem?isFullScreen=true
You are given a table, Projects, containing three columns: Task_ID, Start_Date and End_Date. It is guaranteed that the difference between the End_Date and the Start_Date is equal to 1 day for each row in the table.


If the End_Date of the tasks are consecutive, then they are part of the same project. Samantha is interested in finding the total number of different projects completed.

Write a query to output the start and end dates of projects listed by the number of days it took to complete the project in ascending order. If there is more than one project that have the same number of completion days, then order by the start date of the project.

Sample Input


Sample Output

2015-10-28 2015-10-29
2015-10-30 2015-10-31
2015-10-13 2015-10-15
2015-10-01 2015-10-04

Explanation

The example describes following four projects:

Project 1: Tasks 1, 2 and 3 are completed on consecutive days, so these are part of the project. Thus start date of project is 2015-10-01 and end date is 2015-10-04, so it took 3 days to complete the project.
Project 2: Tasks 4 and 5 are completed on consecutive days, so these are part of the project. Thus, the start date of project is 2015-10-13 and end date is 2015-10-15, so it took 2 days to complete the project.
Project 3: Only task 6 is part of the project. Thus, the start date of project is 2015-10-28 and end date is 2015-10-29, so it took 1 day to complete the project.
Project 4: Only task 7 is part of the project. Thus, the start date of project is 2015-10-30 and end date is 2015-10-31, so it took 1 day to complete the project.


Solution:

Notes: compare the project start dates and end dates. 
from input table, we see that project first starting date is not exists in end date column. 

select start_date
from projects
where start_date not in (select end_date from projects)

Also, project end date is not exists in project startdate column.

select end_date
from projects
where end_date not in (select start_date from projects)


Solution: 

with project_start_date as 
( select start_date,
       rank() over( order by start_date) as rank_start_date
    from projects
    where start_date not in (select end_date from projects)
), 
project_end_date as
(
select end_date,
        rank() over( order by end_date) as rank_end_date
from projects
where end_date not in (select start_date from projects)
)

select start_date,
    end_date
from project_start_date , 
            project_end_date
where rank_start_date = rank_end_date
order by datediff(day, start_date, end_date), start_date



 