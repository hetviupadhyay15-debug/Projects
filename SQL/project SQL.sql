create database project;
use project;
drop table emp_data;
create table emp_data(
emp_no int(4) primary key default 0,
e_name varchar(15) default null,
job varchar(15)  default null,
Mrg int(4)  default null,
Hiredate date  default null,
sal decimal(7,2) default null,
comm decimal(7,2) default null,
dept_no int(2) default null
);
 
 INSERT INTO emp_data 
 VALUES 
 (7369,'SMITH','CLERK',7902,'1980-12-17',800.00,NULL,20),
 (7499,'ALLEN','SALESMAN',7698,'1981-02-20',1600.00,300.00,30),
 (7521,'WARD','SALESMAN',7698,'1981-02-22',1250.00,500.00,30),
 (7566,'JONES','MANAGER',7839,'1981-04-02',2975.00,NULL,20),
 (7654,'MARTIN','SALESMAN',7698,'1981-09-28',1250.00,1400.00,30),
 (7698,'BLAKE','MANAGER',7839,'1981-05-01',2850.00,NULL,30),
 (7782,'CLARK','MANAGER',7839,'1981-06-09',2450.00,NULL,10),
 (7788,'SCOTT','ANALYST',7566,'1987-06-11',3000.00,NULL,20),
 (7839,'KING','PRESIDENT',NULL,'1981-11-17',5000.00,NULL,10),
 (7844,'TURNER','SALESMAN',7698,'1981-08-09',1500.00,0.00,30),
 (7876,'ADAMS','CLERK',7788,'1987-07-13',1100.00,NULL,20),
 (7900,'JAMES','CLERK',7698,'1981-03-12',950.00,NULL,30),
 (7902,'FORD','ANALYST',7566,'1981-03-12',3000.00,NULL,20),
 (7934,'MILLER','CLERK',7782,'1982-01-23',1300.00,NULL,10);
 
  select * from emp_data;
  
  drop table dept_table;
  create table dept_table(
  Dept_no int primary key default 0,
  D_name varchar(14) default null,
  Loc varchar(13)
  );
  
 insert into dept_table 
 values(10,'Accounting','new york'),
 (20,'Research','dallas'),
 (30,'sales','chicago'),
 (40,'operations','boston');

  
drop table student_table;
create table student_table(
  R_no int primary key default 0,
  S_name varchar(14) default null,
  City varchar(13) default null,
  State varchar(20) default null
  );
  
  
  drop table emp_log;
create table  emp_log(
  Emp_id int  default 0,
  Log_date Date default null,
  New_salary int default null,
  Action  varchar(20) default null
  );


 
 
 #que 1 Select unique job from EMP table. 
 
select distinct job from emp_data;

#que 2 List the details of the emps in asc order of the Dptnos and desc of Jobs?

select *  from emp_data
order by  dept_no asc ,job desc;

 #que 3 Display all the unique job groups in the descending order?
 
 select distinct job from emp_data
 order by job desc;
 
 #que4. List the emps who joined before 1981. 
 
select * from emp_data
 where hiredate < "1981-1-1";
 
 #que 5. List the Empno, Ename, Sal, Daily sal of all emps in the asc order of Annsal. 
 
 select emp_no,
 e_name,
 sal,
 sal/30 as annsal 
 from emp_data
 order by annsal *12 asc;

#que 6 List the Empno, Ename, Sal, Exp of all emps working for Mgr 7369.

select emp_no,
e_name,
sal,
timestampdiff(year,hiredate,curdate()) as exp
from emp_data
where Mrg= 7369;

#que 7 Display all the details of the emps who’s Comm. Is more than their Sal?

select * from emp_data
where comm > sal;

#que 8. List the emps who are either ‘CLERK’ or ‘ANALYST’ in the Desc order. 
select * from emp_data
where job in ("clerk" ,"analyst") 
order by sal desc;

#que 9. List the emps Who Annual sal ranging from 22000 and 45000.
select * from emp_data
where sal *12 between 22000 and 45000;

# que10. List the Enames those are starting with ‘S’ and with five characters.
select e_name from emp_data
where e_name like 's____';

# que 11. List the emps whose Empno not starting with digit78. 
 select  emp_no from emp_data
 where emp_no not like "78%";
 
 #que 12. List all the Clerks of Deptno 20. 
 select * from emp_data
 where job = 'CLERK' and dept_no = 20;
 
 #que 13. List the Emps who are senior to their own MGRS. 
 select 
  manager.e_name as manager_name,
 senior.e_name as  senior_name
 from emp_data as  manager
 left join emp_data as senior
 on  manager.mrg = senior.emp_no ;
 
 #que 14. List the Emps of Deptno 20 who’s Jobs are same as Deptno10. 
 select * from emp_data
 where dept_no = 20 and job IN (SELECT job FROM emp_data WHERE dept_no = 10);
 
 #que 15. List the Emps who’s Sal is same as FORD or SMITH in desc order of Sal. 
 select * from emp_data
 where sal in ( 
 select sal from emp_data 
 where e_name in ('FORD','SMITH')
 )
 order by sal desc;
 
 #que 16. List the emps whose jobs same as SMITH or ALLEN.
 select * from emp_data
 where job in (
 select job from emp_data 
 where e_name in ('SMITH','ALLEN'));

# que 17. Any jobs of deptno 10 those that are not found in deptno 20. 

select * from emp_data 
where dept_no =10 and job not in (
select job from emp_data
where dept_no = 20);

#que 18. Find the highest sal of EMP table. 

 select max(sal) from emp_data;

#que 19. Find details of highest paid employee. 

select * from emp_data
order by sal desc
limit 1;

#que 20. Find the total sal given to the MGR. 

select sum(sal) as mrg_salary 
 from emp_data
 where job = 'manager';

#que 21. List the emps whose names contains ‘A’.

select * from emp_data
where e_name like '%A%';

#que 22. Find all the emps who earn the minimum Salary for each job wise in ascending order.

select job , min(sal) from emp_data 
group by job 
order by min(sal);

# que 23. List the emps whose sal greater than Blake’s sal.

select * from emp_data 
where sal > (select sal from emp_data where e_name ='blake');

#que 24  Create view v1 to select ename, job, dname, loc whose deptno are same.
drop view v1;
create view v1 as
select e_name,job,d_name,loc 
from emp_data
inner join dept_table 
on dept_table.dept_no=emp_data.dept_no;

select * from v1;

#que 25. Create a procedure with dno as input parameter to fetch ename and dname. 
delimiter //
create procedure fetch_data(in dept_no int)
begin
       select e_name ,d_name from emp_data
        join dept_table
        on emp_data.dept_no = dept_table.dept_no
        where emp_data.dept_no = dept_no;
end//
delimiter ;
 call fetch_data(20);
 
#que  26. Add column Pin with bigint data type in table student.
alter table student_table
add pin bigint;

select * from student_table;

# que 27. Modify the student table to change the sname length from 14 to 40. 
#Create trigger to insert data in emp_log table whenever any update of sal 
#in EMP table. You can set action as ‘New Salary’. 

alter table student_table 
modify s_name varchar(40);

delimiter //
create trigger insert_data
after update on emp_data
for each row
begin 
       if old.sal != new.sal then
       insert into emp_log(emp_id,log_date,new_salary,action)
       values (new.emp_no,current_date(),new.sal,'new_salary');
       end if;
end//
delimiter ;

update emp_data
set sal = sal +500
where job  = 'manager';

select * from emp_log;
select * from emp_data;
