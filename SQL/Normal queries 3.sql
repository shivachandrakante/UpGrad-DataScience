
create database companydb_pp;
use company;
SET SQL_SAFE_UPDATES = 0;

-- ------------------------------ Session 1 :: START ------------------------------

-- 1.1 Adding and deleting column :: START

select
  *
from 
  employee;
 
 -- adding a new column
 alter table employee
  add des varchar(50) default 'manager';
 
 
 -- updating a value of a column in a particular row
update employee
  set des = 'dummy1'
where 
  ssn = 123456789;
 Alter table employee

Add col varchar(15)

Default 'upgrad' ;

Select * from employee

Where col = 'upgrad' ;
 
 -- removing a column
 alter table employee
  drop column des;
 
 -- 1.1 Adding and deleting column :: END
 
 
 
 
 
 
 
 -- 1.2 : Changing column name and data type :: START

select
  *
from 
  employee;

desc employee;

-- Modifying the column data-type
alter table employee
  modify salary float(10,4);

-- Changing the column name
alter table employee
  change minit minitial char(1);
  

-- 1.2 : Changing column name and data type :: END

-- 1.3: Adding and Removing Key :: START

drop table if exists recipes;
# creating a new table
create table recipes (
  recipe_id int not null,
  recipe_name varchar(30) not null,
  nothing int not null,
  primary key (recipe_name),
  unique (recipe_id)
);

# inserting values into thee new table
insert into recipes 
    (recipe_id, recipe_name,nothing) 
values 
    (1,"Tacos",4),
    (2,"Tomato Soup",5),
    (3,"Grilled Cheese",4),
    (4,"Something good",6),
    (5,"Something not so good",3),
    (6,"Something wonderful",5);
    
select *
from recipes;

desc recipes;

# dropping primary key
alter table recipes
drop primary key;

#adding primary key
alter table recipes
add primary key (recipe_id);

desc employee;

# dropping foreign key
alter table employee
drop foreign key fk_super_ssn;

#adding a foreign key
alter table employee
	add constraint fk_super_ssn foreign key (super_ssn) references employee(ssn);

-- 1.3: Adding and Removing Key :: END

-- 1.4: String Manipulation :: START

-- selecting a sub-string using delimiter occurences
-- +ve is left and -ve is right
select 
  recipe_name                                          as orig_recipe_name, 
  substring_index(recipe_name, ' ', 1)      as upd_reciper_name
from recipes;

#concat two or more string
select 
  concat(fname, ' ' , lname) as name,
  -- substring_index( concat(fname, ' ' , lname) , ' ' , -1)  as test_name,
  ssn
from employee;

-- 1.4 String Manipulation :: END

-- 1.5 Date Manipulation :: START

select * 
from employee;

select 
  bdate, 
  extract(year from bdate)      as year,
  extract(month from bdate)   as month,
  extract(day from bdate)       as day
from employee;

-- 1.5 Date Manipulation :: END

-- ------------------------------ Session 1 :: END ------------------------------
select essn, pno, hours,

avg(hours) over() as Average,

hours*100/sum(hours) over (partition by pno) as contribution_project,

hours*100/sum(hours) over (partition by essn) as contribution_personal

from works_on

order by essn;

select * from works_on;

drop procedure  employee_details;
delimiter $$
create procedure employee_details(in n char(9))
begin
select concat('Hello, ',n,'!') as Greetings ; 
end $$
delimiter ;

call employee_details('tony');

create database demo;
use demo;
create table DemoTable2040
    (
    StudentCode varchar(20)
    );

insert into DemoTable2040 values('John-232'), ('Carol-901'), ('David-987');
select substring_index(StudentCode,'-',1) as name_,
substring_index(StudentCode,'-',-1) as number_
 from demotable2040;
 
 set @mon=extract(month from curdate());
select concat_ws('-',year(curdate()),@mon+1,01); 




CREATE TABLE memberships (
    id INT AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(355) NOT NULL,
    plan VARCHAR(255) NOT NULL,
    expired_date DATE NOT NULL
);


INSERT INTO memberships(email, plan, expired_date)
VALUES('john.doe@example.com','Gold','2017-07-13'),
      ('jane.smith@example.com','Platinum','2017-07-10'),
      ('david.corp@example.com','Silver','2017-07-15'),
      ('julia.william@example.com','Gold','2017-07-20'),
      ('peter.drucker@example.com','Silver','2017-07-08');
      


select datediff(expired_date,curdate()) as daydiff from memberships; 


select ssn, bdate
from employee
order by extract(month from bdate) desc, extract(day from bdate);

select * from employee;
select avg(substring_index(address, ' ', 1))
from employee;


select avg(abs(substring_index(address, ' ', 1)-638)) as dis from employee where fname!='Franklin' and dno=5;


select * from employee e
straight_join  employee t on 
t.ssn=666884444;

select e.fname,year(e.bdate)-year(b.bdate)
from employee e   
inner join employee b  on e.super_ssn = b.ssn
where e.ssn = '987654321';

select *,
abs((salary%year(bdate)-year('2020-09-30'))) as ord
from employee
order by ord desc;


select sum(abs(year(bdate)-2018)) from employees;

select fname,ssn,dno, salary/(abs(year(bdate)-year('2018-09-30'))),

rank() over(order by salary/abs((year(bdate)-year('2018-09-30'))) desc) as 'Rank'

from employee;
select * from employee;

select employee_name from employee order by joining_date and designation;
select * from department;

use company;

select * from employee where super_ssn=888665555;

Select * from employee;

select des from employee group by des
order by avg(salary);