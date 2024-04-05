--employees
--1. �μ���ȣ�� 80���� ū �μ��� ������̵�, firstname, �Ŵ��� ���̵� ���
select * from employees;
select employee_id ������̵�, first_name firstname, manager_id "�Ŵ��� ���̵�"
from employees
where department_id > 80;

--2. �μ���ȣ�� 80���� ū �μ��� ������̵�, firstname, �Ŵ��� �̸� ���
select e1.employee_id ������̵�, e1.first_name firstname, e2.first_name "�Ŵ��� �̸�"
from employees e1, employees e2
where e1.manager_id  = e2.employee_id and e1.department_id > 80;

select e1.employee_id ������̵�, e1.first_name firstname, e2.first_name "�Ŵ��� �̸�"
from employees e1, employees e2
where e1.manager_id  = e2.employee_id and e1.department_id > 80;

--3. Donald ���� ������ �޴� ����� ���̵�, �̸�, ���� ���
select salary
from employees
where first_name ='Donald';

select employee_id, first_name, salary
from employees
where salary = (
        select salary
        from employees
        where first_name ='Donald'
);
--4.Donald �Ի����� �����ϰų� �ʰ� �Ի��� ����� ���̵�, �޿�, �Ի��� ���
select hire_date
from employees
where first_name ='Donald';

select employee_id,  salary, hire_date
from employees
where hire_date >= (
        select hire_date
        from employees
        where first_name ='Donald'
);
--5. �μ���ȣ�� 100�� �μ��� ��� �޿����� ���� �޿��� �޴� ����� �̸��� �޿� ���
select first_name, salary from employees where department_id = 100;

select first_name, salary
from employees
where salary > (select avg(nvl(salary,0))
                from employees
                where  department_id = 100
                );
 ------
 --1. sal_history(empid, hiredate,sal) ���̺� ����µ� employees �̿��Ͽ� ������ ����
 select * from employees;
 
 create table sal_history
 as select employee_id, hire_date,salary
 from employees;
 
 select * from sal_history;
 drop table sal_history;
 -- ������ ����  empid, hiredate,sal
 create table sal_history
 as select employee_id, hire_date,salary
 from employees
 where 1=2;
 
 drop table sal_history;
 
 create table sal_history
 as select employee_id as  empid , hire_date as  hiredate,salary as sal
 from employees
 where 1=2;
 
 --2.mgr_history(empid, mgr,sal) ���̺� ����µ� employees �̿��Ͽ� ������ ����  
 create table mgr_history
 as select employee_id as  empid , manager_id as  mgr,salary as sal
 from employees
 where 1=2;
 select * from mgr_history;
--3.employee_id �� 200���� ū �����͸�  sal_history �� ������ �ֱ�
insert into sal_history 
select employee_id empid, hire_date hiredate, salary sal
from employees
where employee_id>200;

rollback;
select * from sal_history;

 --3.employee_id �� 200���� ū �����͸� 
 --���� sal_history �� mgr_history�� ������ �ֱ�
 --���Ǿ��� insert(unconditional insert)
insert all
into sal_history values(empid,hiredate,sal)
into mgr_history values(empid, mgr, sal)
select employee_id empid, hire_date hiredate, salary sal, manager_id mgr
from employees
where employee_id>200;

select * from sal_history;
select * from mgr_history;

delete from sal_history;
delete from mgr_history;
commit;

 --4.employee_id �� 200���� ū ������ �߿��� sal �� 10000���� ũ�� sal_history
 -- mgr�� 200 ���� ũ��  mgr_history�� ������ �ֱ�
 --�����ִ� insert(conditional insert)
insert all
when sal >10000  then
            into sal_history values(empid,hiredate,sal)
when mgr > 200 then            
            into mgr_history values(empid, mgr, sal)
select employee_id empid, hire_date hiredate, salary sal, manager_id mgr
from employees
where employee_id>200;
commit;

select * from sal_history;
select * from mgr_history;
 
 




