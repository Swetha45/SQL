-- 1. Write a query to display the name ( first name and last name ) for those employees who gets more salary than the employee whose ID is 163. 

SELECT first_name, last_name 
 FROM employees 
WHERE salary > ( SELECT salary FROM employees 
                  WHERE employee_id=163 );

-- 2. Write a query to display the name ( first name and last name ), salary, department id, job id for those employees who works in the same designation as the employee works whose id is 169. 

select first_name, last_name , salary, department_id, job_id
from employees
where job_id = ( SELECT job_id FROM employees 
                  WHERE employee_id=169 );
 
-- 3. Write a query to display the name ( first name and last name ), salary, department id for those employees who earn such amount of salary which is the smallest salary of any of the departments.

select FIRST_NAME, LAST_NAME, SALARY, DEPARTMENT_ID
from employees
where salary in (select min(salary) from employees
                   group by DEPARTMENT_ID);

--  4. Write a query to display the employee id, employee name (first name and last name ) for all employees who earn more than the average salary.

select EMPLOYEE_ID, FIRST_NAME, LAST_NAME
from employees
where salary > (select avg(salary) from employees
                  );

-- 5. Write a query to display the employee name ( first name and last name ), employee id and salary of all employees who report to Payam.

select FIRST_NAME, LAST_NAME, EMPLOYEE_ID, SALARY
from employees
where MANAGER_ID in (select EMPLOYEE_ID  
                       from employees
                       where FIRST_NAME = 'Payam' 
                    ) ; 

-- 6. Write a query to display the department number, name ( first name and last name ), job and department name for all employees in the Finance department. 

select departments.DEPARTMENT_ID,
       FIRST_NAME,
       LAST_NAME,
       DEPARTMENT_NAME,
       JOB_ID
from employees 
JOIN departments
      on employees.DEPARTMENT_ID = 
         departments.DEPARTMENT_ID
where DEPARTMENT_NAME  = 'Finance' ;

-- 7. Write a query to display all the information of an employee whose salary and reporting person id is 3000 and 121 respectively.

select *
from employees
where salary = 3000 
   and MANAGER_ID = 121 ;

-- 8. Display all the information of an employee whose id is any of the number 134, 159 and 183.  

select *
from employees
where EMPLOYEE_ID in (134, 159, 183 ) ;

-- 9. Write a query to display all the information of the employees whose salary is within the range 1000 and 3000. 

select *
from employees
where salary between 1000 and 3000 ;

-- 10. Write a query to display all the information of the employees whose salary if within the range of smallest salary and 2500.  

SELECT * 
FROM employees 
WHERE salary BETWEEN  
(SELECT MIN(salary) 
FROM employees) AND 2500;

-- 11. Write a query to display all the information of the employees who does not work in those departments where some employees works whose manager id within the range 100 and 200.

select *
from employees 
where employees.DEPARTMENT_ID not in  ( select departments.DEPARTMENT_ID
                                        from departments
                                        where MANAGER_ID between 100 and 200
                                      ) ;

-- 12. Write a query to display all the information for those employees whose id is any id who earn the second highest salary. 

select * from employees 
 where salary in (
               select MAX(salary) 
                from employees
                   where SALARY < (select max(salary) 
                                     from employees ) 
                  ); 
       
-- 13. Write a query to display the employee name( first name and last name ) and hiredate for all employees in the same department as Clara. Exclude Clara.  

select FIRST_NAME,
       LAST_NAME,
       HIRE_DATE
from employees
where DEPARTMENT_ID in ( select DEPARTMENT_ID from employees 
                              where FIRST_NAME = 'Clara'  )
and FIRST_NAME != 'Clara' ;

-- 14. Write a query to display the employee ID and name ( first name and last name ) of all employees who works in such a department where the employees are working whose name containing a letter 'T' 

select EMPLOYEE_ID,
       concat (FIRST_NAME, ' ', LAST_NAME) as name,
       DEPARTMENT_ID
from employees
where DEPARTMENT_ID in (select DEPARTMENT_ID
                         FROM employees 
                         where FIRST_NAME like '%T%' );
-- 15. Write a query to display the employee number, name( first name and last name ), and salary for all employees who earn more than the average salary and who work in a department with any employee with a J in their name.   

select EMPLOYEE_ID,
       concat (FIRST_NAME, ' ', LAST_NAME) as name,
       salary 
from employees  
where  salary > (select avg(salary) from employees ) 
      and DEPARTMENT_ID in (select DEPARTMENT_ID
                         FROM employees 
                         where FIRST_NAME like '%J%' );

-- 16. Display the employee name( first name and last name ), employee id, and job title for all employees whose department location is Toronto.  

select EMPLOYEE_ID,
       FIRST_NAME,
       LAST_NAME,
       JOB_ID
from employees e, departments d, locations l
where e.DEPARTMENT_ID = d.DEPARTMENT_ID
and d.LOCATION_ID = l.LOCATION_ID
and CITY like '%Toronto%';

-- 17. Write a query to display the employee number, name( first name and last name ) and job title for all employees whose salary is smaller than any salary of those employees whose job title is MK_MAN.

select EMPLOYEE_ID,
       FIRST_NAME,
       LAST_NAME,
       JOB_ID
from employees e
where salary < ANY (select salary from employees 
                     where JOB_ID = 'MK_MAN' ) ;

-- 18. Write a query to display the employee number, name( first name and last name ) and job title for all employees whose salary is smaller than any salary of those employees whose job title is MK_MAN. Exclude Job title MK_MAN.  

select EMPLOYEE_ID,
       FIRST_NAME,
       LAST_NAME,
       JOB_ID
from employees e
where salary < ANY (select salary from employees 
                     where JOB_ID = 'MK_MAN' ) 
and JOB_ID != 'MK_MAN' ;

-- 19. Write a query to display the employee number, name( first name and last name ) and job title for all employees whose salary is more than any salary of those employees whose job title is PU_MAN. Exclude job title PU_MAN.  

select EMPLOYEE_ID,
       FIRST_NAME,
       LAST_NAME,
       JOB_ID
from employees e
where salary > ANY (select salary from employees 
                     where JOB_ID = 'PU_MAN' ) 
and JOB_ID != 'PU_MAN' ;

-- 20. Write a query to display the employee number, name( first name and last name ) and job title for all employees whose salary is more than any average salary of any department.

SELECT employee_id, first_name, last_name, job_id  
FROM employees  
WHERE salary > ALL  
( SELECT AVG(salary)  
FROM employees  
GROUP BY department_id 
);

-- 21 . Write a query to display the employee name( first name and last name ) and department for all employees for any existence of those employees whose salary is more than 3700.  

SELECT first_name, 
       last_name, 
       DEPARTMENT_ID  
FROM employees 
where salary >ANY (select salary from employees
                  where  salary > 3700 );

(or) 

SELECT first_name, last_name, department_id 
FROM employees 
WHERE EXISTS 
(SELECT * 
FROM employees 
WHERE salary >3700 );

-- 22. Write a query to display the department id and the total salary for those departments which contains at least one employee. 

select e.department_id, 
       sum(salary)
from employees e 
where e.department_id in (select d.department_id from departments d)
GROUP by e.department_id
having count(EMPLOYEE_ID) >=1
order by e.department_id asc;

-- 23. Write a query to display the employee id, name ( first name and last name ) and the job id column with a modified title SALESMAN for those employees whose job title is ST_MAN and DEVELOPER for whose job title is IT_PROG.

select EMPLOYEE_ID,
       FIRST_NAME,
       LAST_NAME,
       case when JOB_ID = 'ST_MAN' then 'SALESMAN'  
            when JOB_ID = 'IT_PROG' then 'DEVELOPER'  
       else JOB_ID
        end as j_role
from employees  ; 

--24. Write a query to display the employee id, name ( first name and last name ), salary and the SalaryStatus column with a title HIGH and LOW respectively for those employees whose salary is more than and less than the average salary of all employees.

select EMPLOYEE_ID,
       FIRST_NAME,
       LAST_NAME,
       CASE WHEN salary >= ( SELECT avg(salary) from employees)  THEN 'HIGH' 
       else 'low' 
    end as SalaryStatus
 from employees  ;  

-- 25. Write a query to display the employee id, name ( first name and last name ), SalaryDrawn, AvgCompare (salary - the average salary of all employees) and the SalaryStatus column with a title HIGH and LOW respectively for those employees whose salary is more than and less than the average salary of all employees.

select EMPLOYEE_ID,
       FIRST_NAME,
       LAST_NAME,
       salary as SalaryDrawn,
       round (( salary - ( SELECT avg(salary) from employees) ), 2) as AvgCompare,
       CASE WHEN salary >= ( SELECT avg(salary) from employees)  THEN 'HIGH' 
       else 'low' 
    end as SalaryStatus
 from employees  ;  

-- 26. Write a subquery that returns a set of rows to find all departments that do actually have one or more employees assigned to them. 

select * from departments d
where d.DEPARTMENT_ID in (select distinct e.DEPARTMENT_ID from employees e  ) ;

-- 27. Write a query that will identify all employees who work in departments located in the United Kingdom.  

select * from 
employees e, departments  d, locations l, countries c
where e.DEPARTMENT_ID = d.DEPARTMENT_ID
and d.LOCATION_ID = l.LOCATION_ID
and l.COUNTRY_ID = c.COUNTRY_ID
and COUNTRY_NAME = 'United Kingdom' ;

-- 28. Write a query to identify all the employees who earn more than the average and who work in any of the IT departments.

select * from employees e  
where salary > (select avg(salary) from employees )
and e.DEPARTMENT_ID in ( select d.DEPARTMENT_ID 
                          from departments d  
                          where DEPARTMENT_NAME like '%IT%') ;

-- 29.  Write a query to determine who earns more than Mr. Ozer.

select * from employees
where salary > (select salary from employees where LAST_NAME = 'Ozer') ; 

-- 30 . Write a query to find out which employees have a manager who works for a department based in the US. 

select FIRST_NAME,
       LAST_NAME,
       MANAGER_ID
from 
employees e
where MANAGER_ID in (select  EMPLOYEE_ID from employees 
                     where DEPARTMENT_ID in (select DEPARTMENT_ID from departments 
                                              where LOCATION_ID in (select LOCATION_ID from locations 
                                                                     where COUNTRY_ID = 'US')
                                              
                                              )
                     
                     );

-- 31. Write a query which is looking for the names of all employees whose salary is greater than 50% of their department’s total salary bill. 

SELECT e1.first_name, e1.last_name 
FROM employees e1 
WHERE salary > 
( SELECT (SUM(salary))*.5 
FROM employees e2 
WHERE e1.department_id=e2.department_id);

-- 32. Write a query to get the details of employees who are managers. 

SELECT e1.first_name, e1.last_name 
FROM employees e1 
WHERE e1.MANAGER_ID in 
( SELECT d.MANAGER_ID
   FROM departments d
);

--  33. Write a query to get the details of employees who manage a department.

SELECT * 
FROM employees 
WHERE employee_id=ANY 
( SELECT manager_id FROM departments );

-- 34. Write a query to display the employee id, name ( first name and last name ), salary, department name and city for all the employees who gets the salary as the salary earn by the employee which is maximum within the joining person January 1st, 2002 and December 31st, 2003.  

select EMPLOYEE_ID,
       FIRST_NAME,
       LAST_NAME,
       salary,
       DEPARTMENT_NAME,
       city
from employees e, departments d, locations l
where e.DEPARTMENT_ID = d.DEPARTMENT_ID
and d.LOCATION_ID = l.LOCATION_ID
and salary =ANY (select max(salary) from employees 
where hire_date BETWEEN '01/01/2002' AND '12/31/2003');

-- 35. Write a query in SQL to display the department code and name for all departments which located in the city London.

select DEPARTMENT_ID,
       DEPARTMENT_NAME,
       city
from  departments d, locations l
where d.LOCATION_ID = l.LOCATION_ID
and  city = 'London' ; 

-- 36. Write a query in SQL to display the first and last name, salary, and department ID for all those employees who earn more than the average salary and arrange the list in descending order on salary. 

select FIRST_NAME,
       LAST_NAME,
       salary,
       DEPARTMENT_ID 
from employees e 
where salary > (select avg(salary) from employees )
order by salary DESC
;

-- 37. Write a query in SQL to display the first and last name, salary, and department ID for those employees who earn more than the maximum salary of a department which ID is 40.  

select FIRST_NAME,
       LAST_NAME,
       salary,
       DEPARTMENT_ID 
from employees e 
where salary > (select max(salary) from employees where DEPARTMENT_ID = 40 ) 
;

-- 38. Write a query in SQL to display the department name and Id for all departments where they located, that Id is equal to the Id for the location where department number 30 is located.  

select DEPARTMENT_NAME,
       DEPARTMENT_ID,
       LOCATION_ID
from departments
where location_id = (select LOCATION_ID from departments 
                        where DEPARTMENT_ID = 30 );

-- 39. Write a query in SQL to display the first and last name, salary, and department ID for all those employees who work in that department where the employee works who hold the ID 201. 

select FIRST_NAME,
       LAST_NAME,
       salary,
       DEPARTMENT_ID 
from employees e 
where DEPARTMENT_ID = (select DEPARTMENT_ID from employees 
                        where EMPLOYEE_ID = 201 ) ;

-- 40. Write a query in SQL to display the first and last name, salary, and department ID for those employees whose salary is equal to the salary of the employee who works in that department which ID is 40. 

select FIRST_NAME,
       LAST_NAME,
       salary,
       DEPARTMENT_ID 
from employees e 
where salary in (select salary from employees 
                        where DEPARTMENT_ID = 40 ) ;

-- 41. Write a query in SQL to display the first and last name, and department code for all employees who work in the department Marketing.  

select FIRST_NAME,
       LAST_NAME,
       e.DEPARTMENT_ID 
from employees e 
where e.DEPARTMENT_ID = (select d.DEPARTMENT_ID from departments d
                            where d.DEPARTMENT_NAME = 'Marketing' ) ; 

-- 42.Write a query in SQL to display the first and last name, salary, and department ID for those employees who earn more than the minimum salary of a department which ID is 40. 

select FIRST_NAME,
       LAST_NAME,
       salary,
       DEPARTMENT_ID 
from employees e 
where salary > ANY (select min(salary) from employees 
                        where DEPARTMENT_ID = 40 ) ;
                    
-- 43. Write a query in SQL to display the full name,email, and designation for all those employees who was hired after the employee whose ID is 165.  

select FIRST_NAME,
       LAST_NAME,
       EMAIL,
       JOB_ID
from employees e 
where HIRE_DATE > (select HIRE_DATE from employees where EMPLOYEE_ID = 165 ) ; 

-- 44. Write a query in SQL to display the first and last name, salary, and department ID for those employees who earn less than the minimum salary of a department which ID is 70.

select FIRST_NAME,
       LAST_NAME,
       salary,
       DEPARTMENT_ID
from employees e 
where salary < ANY (select min(salary) from employees 
                        where DEPARTMENT_ID = 70 ) ;

-- 45. Write a query in SQL to display the first and last name, salary, and department ID for those employees who earn less than the average salary, and also work at the department where the employee Laura is working as a first name holder.  

select FIRST_NAME,
       LAST_NAME,
       salary,
       DEPARTMENT_ID
from employees e 
where salary < (select avg(salary) from employees e1 ) 
and  DEPARTMENT_ID  in (select e2.DEPARTMENT_ID  from employees e2
                                          where FIRST_NAME = 'Laura' ) ;

-- 46. Write a query in SQL to display the first and last name, salary and department ID for those employees whose department is located in the city London. 

select FIRST_NAME,
       LAST_NAME,
       salary,
       DEPARTMENT_ID
from employees
where DEPARTMENT_ID IN (select DEPARTMENT_ID from departments where LOCATION_ID in (select LOCATION_ID from locations where CITY = 'London' ));

-- 47. Write a query in SQL to display the city of the employee whose ID 134 and works there.

select city 
from locations
where LOCATION_ID = (select LOCATION_ID from departments 
                where DEPARTMENT_ID in (select DEPARTMENT_ID from employees
                                            where EMPLOYEE_ID = 134 )); 

-- 48.Write a query in SQL to display the details of those departments which max salary is 7000 or above for those employees who already done one or more jobs.  

SELECT *
  FROM departments
  WHERE department_id IN (SELECT department_id
                            FROM employees
                            WHERE employee_id IN (SELECT employee_id
                                                    FROM job_history
                                                    GROUP BY employee_id
                                                    HAVING COUNT(*) > 1)
                            GROUP BY department_id
                            HAVING MAX(salary) > 7000);

-- 49. Write a query in SQL to display the detail information of those departments which starting salary is at least 8000. 


select * from departments
where DEPARTMENT_ID in (select DEPARTMENT_ID from employees 
group by DEPARTMENT_ID
having min(SALARY )>= 8000) ;

-- 50. Write a query in SQL to display the full name (first and last name) of manager who is supervising 4 or more employees. 

select CONCAT(first_name, ' ', last_name) AS full_name
from employees
where employee_id in (select MANAGER_ID from employees 
GROUP BY manager_id
HAVING COUNT(*) >= 4 );

-- 51. Write a query in SQL to display the details of the current job for those employees who worked as a Sales Representative in the past. 

SELECT *
  FROM jobs
  WHERE job_id IN (SELECT job_id
                     FROM employees
                     WHERE employee_id IN (SELECT employee_id
                                             FROM job_history
                                             WHERE job_id = 'SA_REP'));
    

-- 52. Write a query in SQL to display all the information about those employees who earn second lowest salary of all the employees. */

SELECT *
  FROM employees
  WHERE salary IN (SELECT MIN(salary)
                     FROM employees
                     WHERE salary > (SELECT MIN(salary)
                                       FROM employees));