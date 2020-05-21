create database questions;
use questions;
CREATE TABLE Worker (
	WORKER_ID INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
	FIRST_NAME CHAR(25),
	LAST_NAME CHAR(25),
	SALARY INT(15),
	JOINING_DATE DATETIME,
	DEPARTMENT CHAR(25)
);

INSERT INTO Worker 
	(WORKER_ID, FIRST_NAME, LAST_NAME, SALARY, JOINING_DATE, DEPARTMENT) VALUES
		(001, 'Monika', 'Arora', 100000, '14-02-20 09.00.00', 'HR'),
		(002, 'Niharika', 'Verma', 80000, '14-06-11 09.00.00', 'Admin'),
		(003, 'Vishal', 'Singhal', 300000, '14-02-20 09.00.00', 'HR'),
		(004, 'Amitabh', 'Singh', 500000, '14-02-20 09.00.00', 'Admin'),
		(005, 'Vivek', 'Bhati', 500000, '14-06-11 09.00.00', 'Admin'),
		(006, 'Vipul', 'Diwan', 200000, '14-06-11 09.00.00', 'Account'),
		(007, 'Satish', 'Kumar', 75000, '14-01-20 09.00.00', 'Account'),
		(008, 'Geetika', 'Chauhan', 90000, '14-04-11 09.00.00', 'Admin');

CREATE TABLE Bonus (
	WORKER_REF_ID INT,
	BONUS_AMOUNT INT(10),
	BONUS_DATE DATETIME,
	FOREIGN KEY (WORKER_REF_ID)
		REFERENCES Worker(WORKER_ID)
        ON DELETE CASCADE
);

INSERT INTO Bonus 
	(WORKER_REF_ID, BONUS_AMOUNT, BONUS_DATE) VALUES
		(001, 5000, '16-02-20'),
		(002, 3000, '16-06-11'),
		(003, 4000, '16-02-20'),
		(001, 4500, '16-02-20'),
		(002, 3500, '16-06-11');
        
        
CREATE TABLE Title (
	WORKER_REF_ID INT,
	WORKER_TITLE CHAR(25),
	AFFECTED_FROM DATETIME,
	FOREIGN KEY (WORKER_REF_ID)
		REFERENCES Worker(WORKER_ID)
        ON DELETE CASCADE
);

INSERT INTO Title 
	(WORKER_REF_ID, WORKER_TITLE, AFFECTED_FROM) VALUES
 (001, 'Manager', '2016-02-20 00:00:00'),
 (002, 'Executive', '2016-06-11 00:00:00'),
 (008, 'Executive', '2016-06-11 00:00:00'),
 (005, 'Manager', '2016-06-11 00:00:00'),
 (004, 'Asst. Manager', '2016-06-11 00:00:00'),
 (007, 'Executive', '2016-06-11 00:00:00'),
 (006, 'Lead', '2016-06-11 00:00:00'),
 (003, 'Lead', '2016-06-11 00:00:00');
 


select * from worker where salary between 100000 and 500000;
select * from worker;

select sysdate();

describe worker;
select * from worker;

select * from worker where year(joining_date)=2014 and month(joining_date)=2;

select count(*) from worker where department='admin';



select department as 'depatment_count' from worker
group by department 
order by count(*) desc;



 select * from worker;
 select * from title;
 
 select * from worker w 
 left  outer join title t on w.worker_id=t.worker_ref_id where t.worker_title='manager';
 
 select * from worker where mod(worker_id,2)=0;
 
 set @num=(select count(*) from worker);
 
select * from 
(select * ,dense_rank() over(order by salary desc ) as 'idx' from worker
 group by department) t;

insert into worker values(12,'Tony','Stark',10000000,'2014-03-09 02:00:20','Ethics');

delete from worker where worker_id=12;

drop table table1;
drop table table2;
 
CREATE TABLE table1 (
	ID INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
	FIRST_NAME CHAR(25),
	LAST_NAME CHAR(25)
);
CREATE TABLE table2 (
	ID INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
	LAST_NAME CHAR(25)
);

INSERT INTO table1 
	(ID, FIRST_NAME, LAST_NAME) VALUES
		(001, 'Monika', 'Arora'),
		(002, 'Niharika', 'Verma'),
		(003, 'Vishal', 'Singhal'),
		(004, 'Amitabh', 'Singh'),
		(005, 'Vivek', 'Bhati'),
		(006, 'Vipul', 'Diwan'),
		(007, 'Satish', 'Kumar'),
		(008, 'Geetika', 'Chauhan');
        
INSERT INTO table2
	(ID, LAST_NAME) VALUES
		(001,  'HR'),
		(002,   'Admin'),
		(003,  'HR'),
		(004,  'Admin'),
		(005,  'Admin'),
		(006,   'Account'),
		(007, 'Account'),
		(008,   'Admin');
        
        
select * from table1 t1
left join table2 t2 on
ID=ID;
 
 select  joining_date
from worker
order by extract(month from joining_date) , extract(day from joining_date);
 
 select * from employee;