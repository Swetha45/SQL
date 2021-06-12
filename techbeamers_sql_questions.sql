CREATE DATABASE ORGANIZATION;

SHOW DATABASES;

USE ORGANIZATION;

CREATE TABLE Worker (
	WORKER_ID numeric NOT NULL PRIMARY KEY,
	FIRST_NAME Varchar(25),
	LAST_NAME Varchar(25),
	SALARY numeric(15),
	JOINING_DATE DATETIME,
	DEPARTMENT Varchar(25)
);

select * from Worker;

INSERT INTO Worker 
	(WORKER_ID, FIRST_NAME, LAST_NAME, SALARY, JOINING_DATE, DEPARTMENT) VALUES
       (001, 'Swetha', 'Verma', 80000, '2021-10-11', 'Admin')
		(002, 'Niharika', 'Verma', 80000, '2021-10-11', 'Admin'),
		(003, 'Vishal', 'Singhal', 300000, '2019-02-20', 'HR'),
		(004, 'Amitabh', 'Singh', 500000, '2018-02-20', 'Admin'),
		(005, 'Vivek', 'Bhati', 500000, '2021-06-11', 'Admin'),
		(006, 'Vipul', 'Diwan', 200000, '2017-05-11', 'Account'),
		(007, 'Satish', 'Kumar', 75000, '2015-04-20', 'Account'),
		(008, 'Geetika', 'Chauhan', 90000, '2014-03-11', 'Admin'),
        (009, 'Geetika', 'cha', 90000, '2018-11-11', 'Admin'),
        (010, 'Geeta', 'cha', 90000, '2017-09-12', 'HR'),
        (011, 'Satish', 'Kumar', 99000, '2016-07-20', 'Account')
        ;


CREATE TABLE Bonus(
	WORKER_REF_ID numeric FOREIGN KEY REFERENCES Worker(WORKER_ID),
	BONUS_AMOUNT int,
	BONUS_DATE DATE
);

select * from Bonus; 

INSERT INTO Bonus 
	(WORKER_REF_ID, BONUS_AMOUNT, BONUS_DATE) VALUES
		(001, 5000, '2016-02-20'),
		(002, 3000, '2015-10-09'),
		(003, 4000, '2018-01-20'),
		(001, 4500, '2018-11-20'),
		(011, 3500, '2011-12-11'),
        (009, 4000, '2019-02-20'),
		(001, 4500, '2010-06-20'),
		(005, 3400, '2013-06-23'),
        (008, 2200, '2010-04-01'),
        (003, 10000, '2010-05-13');


CREATE TABLE Title (
	WORKER_REF_ID numeric FOREIGN KEY (WORKER_REF_ID) REFERENCES Worker(WORKER_ID),
	WORKER_TITLE Varchar(25),
	AFFECTED_FROM DATE
);

INSERT INTO Title 
	(WORKER_REF_ID, WORKER_TITLE, AFFECTED_FROM) VALUES
 (001, 'Manager', '2016-02-20' ),
 (002, 'Executive', '2016-06-11'),
 (008, 'Executive', '2016-06-1'),
 (005, 'Manager', '2016-06-11'),
 (004, 'Asst. Manager', '2016-06-11'),
 (007, 'Executive', '2016-06-11'),
 (006, 'Lead', '2016-06-11'),
 (003, 'Lead', '2016-06-11');

 select * from Title ; 

-- Q-1. Write an SQL query to fetch “FIRST_NAME” from Worker table using the alias name as <WORKER_NAME>.

SELECT FIRST_NAME AS WORKER_NAME from Worker;

-- Q2 Write an SQL query to fetch “FIRST_NAME” from Worker table in upper case.

Select upper(FIRST_NAME) from Worker;

-- lower

Select lower(FIRST_NAME) from Worker;


--  Q-3. Write an SQL query to fetch unique values of DEPARTMENT from Worker table.


Select distinct DEPARTMENT from Worker;

-- Q-4. Write an SQL query to print the last four characters of  FIRST_NAME from Worker table.

Select SUBSTRING(FIRST_NAME , LEN(FIRST_NAME) -3, 4), FIRST_NAME from Worker;


-- Q-5. Write an SQL query to find the position of the alphabet (‘a’) in the first name column from Worker table.

Select CHARINDEX('e', FIRST_NAME) as char_place , FIRST_NAME from Worker;

-- Q-6 Write an SQL query to print the WORKER_TITLE from Title table after removing white spaces from the right  and  left sides.

SELECT trim(WORKER_TITLE) as remove_space,WORKER_TITLE  from Title;

-- Q-8. Write an SQL query that fetches the unique values of DEPARTMENT from Worker table and prints its length.

Select distinct len(DEPARTMENT) string_length , DEPARTMENT from Worker;

-- Q-9. Write an SQL query to print the WORKER_TITLE from Title table after replacing ‘e’ with ‘E’.

SELECT  WORKER_TITLE , REPLACE (WORKER_TITLE, 'e', 'E') from Title;


-- Q-10. Write an SQL query to print the FIRST_NAME and LAST_NAME from Worker table into a single column COMPLETE_NAME. A space char should separate them.

Select CONCAT(FIRST_NAME, ' ', LAST_NAME) AS 'COMPLETE_NAME' from Worker;

-- Q-11. Write an SQL query to print all details from the TITLE table order by WORKER_TITLE Ascending and AFFECTED_FROM descending

Select * from TITLE  order by WORKER_TITLE asc , AFFECTED_FROM desc;

-- Q-13. Write an SQL query to print details for Workers with the dept name as "admin" and “HR” from Worker table.

select DEPARTMENT, Worker.* from Worker where DEPARTMENT in ('admin', 'hr'); 

-- Q-14. Write an SQL query to print details of workers excluding first names, “Vipul” and “Satish” from Worker table.

Select * from Worker where FIRST_NAME not in ('Vipul','Satish');

-- Q-15. Write an SQL query to print details of Workers with DEPARTMENT name as “Admin”.

Select * from Worker where DEPARTMENT like 'Admin%';

-- Q-16. Write an SQL query to print details of the Workers whose FIRST_NAME contains ‘a’.

Select * from Worker where FIRST_NAME like '%a%';

-- Q-17. Write an SQL query to print details of the Workers whose FIRST_NAME ends with ‘a’.

Select * from Worker where FIRST_NAME like '%a';

-- Q-18. Write an SQL query to print details of the Workers whose FIRST_NAME ends with ‘h’ and contains five alphabets.

Select * from Worker where FIRST_NAME like '_____h';

-- Q-19. Write an SQL query to print details of the Workers whose SALARY lies between 100000 and 500000.

Select * from Worker where SALARY between 100000 and 500000;

-- Q-20. Write an SQL query to print details of the Workers who have joined in Feb’2014.

Select * from Worker where year(JOINING_DATE) = 2016 and month(JOINING_DATE) = 7;

-- Q-21. Write an SQL query to fetch the count of employees working in the department ‘Admin’.

SELECT COUNT(*) FROM worker WHERE DEPARTMENT = 'Admin';
 
-- Q-22. Write an SQL query to fetch worker names with salaries >= 50000 and <= 100000.

SELECT concat(FIRST_NAME, ' ', LAST_NAME) as u_name , SALARY, WORKER_ID  FROM worker where SALARY >= 50000 and SALARY <= 80000 ; 

-- Q-23. Write an SQL query to fetch the no. of workers for each department in the descending order.

SELECT COUNT(DEPARTMENT) no_of_workers, DEPARTMENT from worker
group by DEPARTMENT
order by no_of_workers desc; 

-- Q-24. Write an SQL query to print details of the Workers who are also Managers.

Select WORKER_TITLE , Worker.* from Title, Worker
where WORKER_REF_ID = WORKER_ID 
   and WORKER_TITLE = 'Manager';

-- Q-25. Write an SQL query to fetch duplicate records having matching data in some fields of a table.

    select WORKER_TITLE, COUNT(WORKER_TITLE) as num
    from Title
    group by WORKER_TITLE 
    having COUNT(WORKER_TITLE) > 1;

-- Q-26. Write an SQL query to show only odd and even rows from a table.

select * from Bonus where (WORKER_REF_ID%2) = 1; 

select * from Bonus where (WORKER_REF_ID%2) = 0;

-- Q-28. Write an SQL query to clone a new table from another table.

select * into Bonus1 from Bonus ; 

select * from Bonus1; 

-- Q-29. Write an SQL query to fetch intersecting records of two tables.

select * from Bonus
INTERSECT
select * from Bonus1; 


select * from Worker
INTERSECT
select * from Title; --- inserct will not work

-- Q-30. Write an SQL query to show records from one table that another table does not have.

select * from Worker
Minus
select * from Title; 

-- Q-31. Write an SQL query to show the current date and time

select SYSDATETIME();

-- Yesteday date
select getdate()-1

-- Q-32. Write an SQL query to show the top n (say 5) records of a table.

select top 5 * FROM Worker order by SALARY DESC;

--- Q-33. Write an SQL query to determine the nth (say n=5) highest salary from a table.

SELECT max(Salary)
FROM Worker where Salary in (
 SELECT DISTINCT TOP 5 Salary
 FROM Worker 
 ORDER BY Salary DESC
 )

-- Q-34. Write an SQL query to determine the 6th highest salary without using TOP or limit method.

SELECT Salary
FROM Worker W1
WHERE 7-1 = (
 SELECT COUNT( DISTINCT ( W2.Salary ) )
 FROM Worker W2
 WHERE W2.Salary >= W1.Salary
 );

-- Q-35. Write an SQL query to fetch the list of employees with the same salary.

select w1.worker_id, w1.first_name, w1.last_name, w1.SALARY, w2.SALARY from Worker w1, Worker w2 
where w1.WORKER_ID = w2.WORKER_ID 
 and  W1.Salary = W2.Salary  ; 

-- Q-36. Write an SQL query to show the second highest salary from a table.

select * from Worker w
where 3-1 = ( select count(distinct salary ) from Worker w1  
                where w1.SALARY >= w.Salary); 

-- or

Select max(Salary) from Worker 
where Salary not in (Select max(Salary) from Worker);

-- Q-37. Write an SQL query to show one row twice in results from a table.

select FIRST_NAME, DEPARTMENT, w.* from worker W where W.DEPARTMENT='Admin' 
union all 
select FIRST_NAME, DEPARTMENT, W1.* from Worker W1 where W1.DEPARTMENT='Admin';

-- Q-38. Write an SQL query to fetch intersecting records of two tables.

select FIRST_NAME, DEPARTMENT from worker W where W.DEPARTMENT='HR' 
INTERSECT
select FIRST_NAME, DEPARTMENT from Worker W1 where W1.DEPARTMENT='HR';

-- Q-39. Write an SQL query to fetch the first 50% records from a table.

SELECT *
FROM Bonus
WHERE WORKER_REF_ID <= 
( select count(distinct WORKER_REF_ID)/2 as half_rows from Bonus ); 
 
-- Q-40. Write an SQL query to fetch the departments that have less than five people in it.

select  DEPARTMENT, COUNT(DEPARTMENT) 
from Worker
group by DEPARTMENT
having count(DEPARTMENT) < 5 ; 

-- Q-41. Write an SQL query to show all departments along with the number of people in there.

select  DEPARTMENT, COUNT(CONCAT(FIRST_NAME, ' ', LAST_NAME)) no_of_people
from Worker
group by DEPARTMENT ;

