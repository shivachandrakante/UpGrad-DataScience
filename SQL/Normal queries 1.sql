use questions;
delimiter //
create function number_( n int)
returns char(10)
deterministic
begin
declare num char(10);
if (mod(n,2)=0) then
set num = 'even';
else
set num = 'odd';
end if;
return (num);
end
//
delimiter ;

select number_(9) as is_enen_odd;

Select * from worker;

select department,avg(salary)from worker group by department
order by avg(salary) desc
limit 1;

select avg(marks) from marks 
group by student_id
order by avg(marks) desc,student_id asc;

use upgrad;
# write your code below
select student_id from marks
group by student_id
having avg(marks)>(select avg(marks) from marks)
order by student_id;


select student_id,marks from marks
group by student_id
having (max(marks)-min(marks))>(select avg(marks) from marks)
order by student_id;


select teacher_name from teacher t 
left join (select course,avg(marks) as 'avgmarks' from marks group by course) m 
on t.course=m.course
order by 'avgmarks' desc limit 1;


select student_name from student s 
left join
(select sal.student_id from roommate r 
inner join salary sal
on r.student_id=sal.student_id
where sal.salary=(select salary from salary d where d.student_id=r.roommate_id)
) p
on s.student_id=p.student_id;




select substring_index(food_name, ' ', -1),avg(price)  from food 
group by substring_index(food_name, ' ', -1)
having food_name in('Maggi', 'Pasta', 'Sandwich')
order by avg(price) desc;

select substring_index(food_name, ' ', -1) as p  from food 
group by substring_index(food_name, ' ', -1)
having p like '%Maggi%' or p like '%Pasta%' or p like '%Sandwich%'
order by avg(price) desc
limit 1;