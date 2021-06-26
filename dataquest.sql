

-- 1. Given the table below, write a SQL query that retrieves the personal data about alumni who scored above 16 on their calculus exam.

select a.student_id, 
      a.name, 
      a.surname
from alumni as a
join evaluation as e 
on e.student_id = a.student_id
join curricula as c
on e.class_id = c.class_id
where c.class_name = 'calculus'
and e.grade > 16;

-- 2. Write a query to extract only beverages where fruit_pct is between 35 and 40 (including both ends).

select * FROM
beverages
where fruit_pct between 35 and 40;

-- 3. Write a query to extract only beverages whose contributor only has one name

select *  FROM
beverages
where contributed_by NOT LIKE '% %';

-- 4. Write a query that finds the average fruit_pct by contributor and displays it ascending order.

select avg(fruit_pct), contributed_by
FROM beverages
group by contributed_by
order by contributed_by asc;

-- 5. In what order does SQL run the clauses? Select the correct option from the list of choices below:

1. SELECT, FROM, WHERE, GROUP BY
2. FROM, WHERE, HAVING, SELECT, LIMIT
3. SELECT, FROM, INNER JOIN, GROUP BY
4. FROM, SELECT, LIMIT, WHERE


The correct option is 2. It goes like this:


The SQL engine fetches the data from the tables (FROM and INNER JOIN)
Filters it (WHERE)
Aggregates the data (GROUP BY)
Filters the aggregated data (HAVING)
Selects the columns and expressions to display (SELECT)
Orders the remaining data (ORDER BY)
Limits the results (LIMIT)

-- 6. What is the purpose of an index in a database table?

A: Indexing on table or view help to improve perfromance of the queries and faster retrival of data from database. 

-- 7. What rows of my_table does the following query yield? Give a descriptive answer.

SELECT *
  FROM my_table
 WHERE 1 = 1.0;

A: where 1 = 1 means there no where clause. it will always be True. returns all the records from table.


-- 8 What rows of my_table does the following query yield? Give a descriptive answer.

SELECT *
  FROM my_table
 WHERE NULL = NULL;

it is contrast to above question.
It will not return anything. By defination NULL indicates, value does not exist in the database.

