
link to belw Questions

https://platform.stratascratch.com/coding?is_freemium=1&difficulties=2&code_type=3&page_size=100

Website : stratascratch.com


1. Find the 3 most profitable companies in the entire world.

select company,  profits 
from forbes_global_2010_2014
order by profits desc
limit 3;

2. You have been asked to find the job titles of the highest-paid employees.

with cte as ( 
select worker_title, 
rank() over(order by salary desc ) as rnk
from worker
join  title
on worker.worker_id = title.worker_ref_id
)
select worker_title 
from cte
where rnk = 1; 

3. Calculate each users average session time.
 A session is defined as the time difference between a page_load and page_exit. 
 For simplicity, assume a user has only 1 session per day and if there are multiple of the same events on that day, 
 consider only the latest page_load and earliest page_exit, with an obvious restriction that load time event should happen before exit time event . 
Output the user_id and their average session time.

select user_id, 
     avg(TIMESTAMPDIFF(SECOND,load_time,exit_time )) as session_time
from 
(
SELECT DATE(timestamp),  user_id,
 max(if(action = 'page_load' , timestamp, null) ) as load_time, 
 min(if(action = 'page_exit' , timestamp, null)) as exit_time
 from facebook_web_log
  group by DATE(timestamp), user_id
) t
group by user_id
having session_time is not null
  ;


4. Find the email activity rank for each user. Email activity rank is defined by the total number of emails sent. 
The user with the highest number of emails sent will have a rank of 1, and so on. Output the user, total emails, and their activity rank. 

Order records by the total emails in descending order. Sort users with the same number of emails in alphabetical order.
In your rankings, return a unique value (i.e., a unique rank) even if multiple users have the same number of emails. 
For tie breaker use alphabetical order of the user usernames.

SELECT from_user, 
count(*) as total_emails, 
ROW_NUMBER() OVER(ORDER BY count(*) DESC, from_user ASC)
FROM google_gmail_emails 
GROUP BY from_user
ORDER BY 2 DESC, 1 ; 

5. Write a query that will identify returning active users. A returning active user is a user that has made a second purchase within 7 days of any other of their purchases. 
Output a list of user_ids of these returning active users.

select distinct t1.user_id
from amazon_transactions t1 
join amazon_transactions t2  
on t1.id <> t2.id and t1.user_id=t2.user_id
where datediff(t1.created_at, t2.created_at ) between 0 and 7;

6. You are given a table of product launches by company by year. 
Write a query to count the net difference between the number of products companies launched in 2020 with the number of products companies launched in the previous year. 
Output the name of the companies and a net difference of net products released for 2020 compared to the previous year.

select company_name, count(case when (year = 2020) then 1 end) - count(case when (year = 2019) then 1 end ) as total_launch from car_launches group by company_name;

7. Output a list of projects that are overbudget with their project name, project budget, and prorated total employee expense (rounded to the next dollar amount).

select lp.title, 
    lp.budget,
    ceiling (DATEDIFF( lp.end_date, lp.start_date) * sum(le.salary)/365) AS total
from linkedin_employees le
join linkedin_emp_projects lep
on le.id = lep.emp_id
join linkedin_projects lp
on lep.project_id = lp.id
group by lp.title, lp.budget
HAVING total > budget
order by title asc;

8. What is the overall friend acceptance rate by date? Your output should have the rate of acceptances by the date the request was sent. 
Order by the earliest date to latest.

with tv1 as 
(select * from fb_friend_requests where action = "accepted"),  # 5 
tv2 as 
(select * from fb_friend_requests where action =  "sent" ) 
select tv2.date, count(tv1.action)/count(tv2.action) as acceptance_rate 
from tv1 right join tv2
on tv1.user_id_sender = tv2.user_id_sender
and tv1.user_id_receiver = tv2.user_id_receiver
group by tv2.date; 

9. Rank guests based on the total number of messages theyve exchanged with any of the hosts. Guests with the same number of messages as other guests should have the same rank. 
Do not skip rankings if the preceding rankings are identical.

SELECT DENSE_RANK() OVER(ORDER BY SUM(n_messages) DESC) AS ranking,
       id_guest,
       SUM(n_messages) AS sum_msg
FROM airbnb_contacts
GROUP BY id_guest;

10. Find the number of apartments per nationality that are owned by people under 30 years old.

select nationality, 
count(distinct unit_id) as apartment_count
from airbnb_hosts aj
join airbnb_units au 
on aj.host_id = au.host_id
where age < 30
    and unit_type = 'Apartment'
group by nationality
order by apartment_count desc;

11. Find the number of Apple product users and the number of total users with a device and group the counts by language. 

select language, 
count(distinct case when device in ('macbook pro', 'iphone 5s', 'ipad air' )
           then pe.user_id else null end) as apple_users, 
count(distinct pe.user_id) as t_users
from playbook_events pe 
 join playbook_users pu
on pe.user_id = pu.user_id
group by language
order by t_users desc;

12. Calculate the percentage of spam posts in all viewed posts by day. A post is considered a spam if a string "spam" is inside keywords of the post.

with tv1 as 
(
select * from facebook_posts fp
where fp.post_id in (select fpv.post_id from
                        facebook_post_views fpv )
)
select post_date,
sum(case when  post_keywords like '%spam%' then 1 else 0 end)*1.0 / sum(1) * 100 as spam_posts
from tv1
group by post_date


13. Find the percentage of shipable orders. Consider an order is shipable if the customers address is known.

select 
count(case when address is not null then o.id end)/ count( o.id)* 100 as shippable_orders
from customers  c
join orders o
on c.id = o.cust_id ; 

14. Find matching hosts and guests pairs in a way that they are both of the same gender and nationality.

select distinct ah.host_id, ag.guest_id 
from airbnb_hosts ah 
inner join airbnb_guests  ag
on ag.nationality = ah.nationality
and ag.gender = ah.gender ; 

15. Find the average total compensation based on employee titles and gender. 
Total compensation is calculated by adding both the salary and bonus of each employee.

with tv1 as 
(select  worker_ref_id , sum(bonus) as t_bonus 
from sf_bonus sb
group by worker_ref_id)

select employee_title, 
sex,
avg(salary + t_bonus) as total_compensation
from tv1 
join sf_employee se
on tv1.worker_ref_id = se.id
group by 1, 2 ; 


16. Find the date with the highest total energy consumption from the Meta/Facebook data centers. 
Output the date along with the total energy consumption across all data centers.

with tv1 as
(
select date,consumption 
from fb_eu_energy
union 
select date,consumption
from fb_asia_energy
union 
select date,consumption
from fb_na_energy
), t2 as 
    (select sum(consumption) as t_consumption, date 
    from tv1
    group by date),
        tv3 as
        (select Rank() over(order by t_consumption desc) as rank_co ,
          date ,
          t_consumption 
        from t2)
select t_consumption, date from tv3
where rank_co = 1
;

17. Find the review_text that received the highest number of  'cool' votes.
Output the business name along with the review text with the highest numbef of 'cool' votes.

select business_name, review_text from yelp_reviews
where cool in 
(select max(cool) from yelp_reviews) ; 

18. Find all wineries which produce wines by possessing aromas of plum, cherry, rose, or hazelnut. 
To make it more simple, look only for singular form of the mentioned aromas. 
HINT: if one of the specified words is just a substring of another word, this should not be a hit, but a miss.

Hit 2 : You can use the REGEXP function to match the pattern. The pattern should be the aromas separated by the pipe '|' symbol, which represents 'OR' in regular expressions. 
Also, to ensure that the aroma words are not part of another word, you can use '([^a-z])' which means the aroma word should not be followed by any alphabetic character.

select DISTINCT winery 
from winemag_p1
where lower(description) REGEXP '(plum|cherry|rose|hazelnut)([^a-z])'; 

19. Find songs that have ranked in the top position. Output the track name and the number of times it ranked at the top. 
Sort your records by the number of times the song was in the top position in descending order.

select trackname,
count(*) as total
from spotify_worldwide_daily_song_ranking
WHERE position = 1
group by trackname
order by total desc;

20. Find the Olympics with the highest number of athletes. 
The Olympics game is a combination of the year and the season, and is found in the 'games' column.
 Output the Olympics along with the corresponding number of athletes.

select games, max(ath_count)
from 
( 
select games, count(distinct id) as ath_count 
from olympics_athletes_events
group by games
order by ath_count desc
) as sub_query
; 

21. Find the customer with the highest daily total order cost between 2019-02-01 to 2019-05-01. 
If customer had more than one order on a certain day, sum the order costs on daily basis. Output customers first name, total cost of their items, and the date.

select first_name, 
        order_date,
        sum(total_order_cost) as total
from customers c
join orders
on c.id = cust_id 
where order_date between '2019-02-01' and '2019-05-01'
group by 1, 2
order by 3 desc
limit 1;

22. Find the highest target achieved by the employee or employees who works under the manager id 13.
 Output the first name of the employee and target achieved. 
 The solution should show the highest target achieved under manager_id=13 and which employee(s) achieved it.

select first_name, target
from salesforce_employees
where target in 
    (select  max(target)
    from salesforce_employees
    where manager_id = 13)
and manager_id = 13;


23. Find the employee with the highest salary per department.
Output the department name, employees first name along with the corresponding salary.


select department, first_name, salary
from employee
where (department, salary)
in
(
select department, max(salary) as sal
from employee
group by 1
order by sal desc ) ; 

24. Find employees who are earning more than their managers. Output the employees first name along with the corresponding salary.

select e1.salary as salaryy,  
       e1.first_name
from employee e1
join employee m1
on e1.manager_id = m1.id
where e1.salary > m1.salary ; 

25. Find the second highest salary of employees.

with tv1 as
(
select salary,
dense_rank() over(order by salary desc) as rnk
from employee
)
select salary
from tv1 
where rnk=2 ; 
;

26. Make a report showing the number of survivors and non-survivors by passenger class.
Classes are categorized based on the pclass value as:
pclass = 1: first_class
pclass = 2: second_classs
pclass = 3: third_class
Output the number of survivors and non-survivors by each class.

SELECT
    survived,
    sum(CASE WHEN pclass = 1 THEN 1 ELSE 0 END) AS first_class,
    sum(CASE WHEN pclass = 2 THEN 1 ELSE 0 END) AS second_class,
    sum(CASE WHEN pclass = 3 THEN 1 ELSE 0 END) AS third_class
FROM titanic
GROUP BY 
    survived; 

27. Calculate the total revenue from each customer in March 2019. Include only customers who were active in March 2019.

select cust_id, sum(total_order_cost) as total_revenue
from orders
where month(order_date) = 3
     and year(order_date) = 2019
group by cust_id    
order by total_revenue desc;

28. Calculate the total revenue from each customer in March 2019. Include only customers who were active in March 2019.

select cust_id, sum(total_order_cost) as total_revenue
from orders
where month(order_date) = 3
     and year(order_date) = 2019
group by cust_id    
order by total_revenue desc;

29. Find the rate of processed tickets for each type.

select type,
-- sum(case when processed = 'TRUE' then 1 else 0 end) as  processed_rate,
sum(processed)/count(*)
from facebook_complaints
group by 1;

30. Youre given a dataset of health inspections. Count the number of violation in an inspection in 'Roxanne Cafe' for each year.

select count(violation_id), 
       year(inspection_date)
from sf_restaurant_health_violations 
where business_name = 'Roxanne Cafe' 
and violation_id is not null
group by 2;

31. Classify each business as either a restaurant, cafe, school, or other.


• A restaurant should have the word 'restaurant' in the business name.
• A cafe should have either 'cafe', 'café', or 'coffee' in the business name.
• A school should have the word 'school' in the business name.
• All other businesses should be classified as 'other'.


32. Output the business name and their classification.

select DISTINCT business_name,
CASE
    WHEN lower(business_name) like '%restaurant%' THEN 'restaurant'
    WHEN lower(business_name) like '%cafe%' 
         or lower(business_name) like '%coffee%'
         or lower(business_name) like '%café%' THEN 'cafe'
    when lower(business_name) like '%school%' THEN 'school'
    ELSE 'other'
  END AS business_type
from sf_restaurant_health_violations;

33. What were the top 10 ranked songs in 2010?

select  distinct group_name, song_name, year_rank
from billboard_top_100_year_end
where year = 2010 
order by year_rank
limit 10;

34. Output ids of students with a median score from the writing SAT.

with tv1 as 
(
select student_id, 
sat_writing,
rank() over(order by sat_writing) as rankk
from sat_scores
),
tv2 as
( select FLOOR(count(*)/2) as median_number
from tv1 ;

35. Which user flagged the most distinct videos that ended up approved by YouTube? Output, in one column, their full name or names in case of a tie. 
In the users full name, include a space between the first and the last name.

with tv1 as 
(
select 
dense_rank() over(order by count(distinct uf.video_id) desc) as count_vi,
  concat(user_firstname, ' ',user_lastname) as full_name
from user_flags uf
join flag_review fr
on uf.flag_id = fr.flag_id
where reviewed_outcome = 'APPROVED' 
group by 2 )

select full_name 
from tv1
where tv1.count_vi = 1 ;

36. For each video, find how many unique users flagged it. A unique user can be identified using the combination of their first name and last name. 
Do not consider rows in which there is no flag ID.

select video_id,
count(DISTINCT concat(IFNULL(user_firstname, ''), IFNULL(user_lastname, ''))) as full_name
from user_flags
where flag_id is not null
group by 1 ; 

37. The election is conducted in a city and everyone can vote for one or more candidates, or choose not to vote at all. 
Each person has 1 vote so if they vote for multiple candidates, their vote gets equally split across these candidates. 
For example, if a person votes for 2 candidates, these candidates receive an equivalent of 0.5 vote each.
Find out who got the most votes and won the election. Output the name of the candidate or multiple names in case of a tie. 
To avoid issues with a floating-point error you can round the number of votes received by a candidate to 3 decimal places.


with tv1 as 
(select voter, 
        count(*) as number_of_candidates
from voting_results
group by 1)
, tv2 as
(select candidate, 
        sum(1/number_of_candidates) as votes_by_candidate
from voting_results vr 
join tv1 on tv1.voter = vr.voter
group by 1
HAVING candidate IS NOT NULL)

select candidate 
from tv2
where votes_by_candidate = 
(select max(votes_by_candidate) from tv2)
order by candidate ;

38. You are given a dataset that provides the number of active users per day per premium account. 
A premium account will have an entry for every day that it’s premium. 
However, a premium account may be temporarily discounted and considered not paid, this is indicated by a value of 0 in the final_price column for a certain day. 
Find out how many premium accounts that are paid on any given day are still premium and paid 7 days later.

Output the date, the number of premium and paid accounts on that day, and the number of how many of these accounts are still premium and paid 7 days later. 
Since you are only given data for a 14 days period, only include the first 7 available dates in your output.

select p1.entry_date, 
      count(p1.account_id) as premium_paid_accounts,
      count(p2.account_id) as premium_paid_accounts_after_7d
from premium_accounts_by_day p1
left join premium_accounts_by_day p2
on p1.account_id = p2.account_id
and datediff(p2.entry_date, p1.entry_date)= 7
and p2.final_price != 0 
where p1.final_price != 0  
group by 1
order by 1
limit 7;

39. Output share of US users that are active. Active users are the ones with an "open" status in the table.

with tv1 as 
(select 
count(case when status = 'open' then 1 else null end) as active_users,
count(user_id) as total_users
from fb_active_users
where country = 'USA'
 )
select active_users/total_users as active_users_share
from tv1;


























































