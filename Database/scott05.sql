--p266
--DML(data manipulation language) :�����͸� �߰�, ����, �����ϴ� ���������۾�
--DDL(data definition language) :��ü�� ����,����,�����ϴ� ������ ���Ǿ� (p311)

--test1(no, name, address, tel)
---number(5),  ���ڿ�(20), ���ڿ�(50), ���ڿ�(20)
create table test1(
    no number(5),
    name varchar2(20),
    address VARCHAR2(50),
    tel VARCHAR2(20)
);
select * from test1;
--(1,'aaa')�߰�(no, name)
insert into test1(no,name) values(1, 'aaa');
--(2, 'bbb', '�λ�','010-1111-2222')
insert into test1(no, name, address,tel)
values(2, 'bbb', '�λ�','010-1111-2222');
--(3, 'ccc', '�λ�','010-1111-2222')
insert into test1 values(3, 'ccc', '�λ�','010-1111-2222');
insert into test1(no, name, address) values(4, 'ddd', '����');
commit;
--����
-- no�� 2���� ����� �̸���  ȫ�浿���� ����
update test1
set name ='ȫ�浿'
where no=2;

-- no�� 4�� name�� test  /  address ����� ����
update test1
set name ='test', address='����'
where no=4; 

--����
-- test1 ���� 1������
delete test1  where no =1;
delete from test1 where no =2;
commit;

delete from test1;

select * from test1;

create table test(
    no number(3) default 0,
    name VARCHAR2(20) default 'NONAME',
    hiredate DATE default sysdate
);
select * from test;
insert into test(no, name) values(1,'ȫ�浿');
insert into test(hiredate) values('24/03/30');
-- test���� ��ȣ�� 1���� ����� �̸��� ������ ����
update test
set name = '������'
where no = 1;
commit;

-- test���� ��ȣ�� 0�� ���� �����ϰ�
-- ��ȣ�� 2�� �����͸� �߰��ϱ�
delete from test where no=0;
insert into test(no) values(2);
------
--CRUD (create, select, update, delete)
--p266 (CTAS : create table as select)
create table dept_temp
as select * from dept;

select * from dept_temp;
--dept_temp ���̺� 50, DATABASE , SEOUL �߰�
insert into dept_temp values(50, 'DATABASE' , 'SEOUL');
commit;

-- ���̺� ������ ����
create table emp_temp
as select * from emp
where 1<>1;

select * from emp_temp;
desc emp_temp;
--emp_temp : empno, ename, job, mgr, hiredate, sal, comm, deptno
--(2111,'�̼���','MANAGER',9999,'07/01/2019',4000,NULL,20) �߰�
insert into emp_temp(empno, ename, job, mgr, hiredate,sal, comm, deptno)
values (2111,'�̼���','MANAGER',9999,
          to_date('07/01/2019','DD/MM/YYYY'),4000,NULL,20);
--(3111,'������','MANAGER',9999,4000,NULL,20) �Ի����� ���ó�¥��  �߰� 
insert into emp_temp(empno, ename, job, mgr, hiredate,sal, comm, deptno)
values (3111,'������','MANAGER',9999,sysdate,4000,NULL,20);

select * from emp_temp;

--3111�� ����� �޿� 5000���� ����
update emp_temp
set sal = 5000
where empno = 3111;

--emp_temp ��� ��� ����
delete from emp_temp;
commit;
--p275 ���������� �̿��ؼ� �� ���� ���� ������ �߰�(values ������� �ʴ´�)
-- �޿����(salgrade)�� 1�� ����� emp_temp �� �߰�
select * from salgrade;
select * from emp where sal between 700 and 1200;

insert into emp_temp(empno, ename, job,mgr, hiredate, sal, comm, deptno)
select e.empno, e.ename, e.job, e.mgr, e.hiredate, e.sal, e.comm, e.deptno
from emp e, salgrade s
where e.sal between s.losal and s.hisal and s.grade=1;

select * from emp_temp;
commit;
---dept ���̺� �����ؼ� dept_temp2 ���̺��� �����ϰ�
-- 40�� �μ����� DATABASE  ����  SEOUL �� ����
create table dept_temp2
as select * from dept;

update dept_temp2
set dname = 'DATABASE', loc='SEOUL'
where deptno = 40;
commit;

select * from dept_temp2;
---
select * from emp_temp;
--7900�� �̸��� ���������� ����
update emp_temp
set ename ='������'
where empno = 7900;
select * from emp_temp;
rollback;

-- dept_temp2  ���̺��� 40�� ���� �����ϱ�
-- dept ���̺��� 40���� ������ �μ���� �������� ����
select * from dept_temp2 ;
select * from dept;

update dept_temp2
set dname =(select dname from dept where deptno=40) ,
    loc =(select loc from dept where deptno = 40)
where deptno = 40;   
rollback;

update dept_temp2
set (dname, loc ) = (select dname, loc
                    from dept
                    where deptno =40)
where deptno = 40;                     
commit;
--dept_temp2 ��� ������ ����
delete from dept_temp2;
select * from dept_temp2;
-- ���̺� ����
drop table dept_temp2;

--  dept ���̺��� �̿��ؼ�  dept_tmp ���̺� �����ϱ�
create table dept_tmp
as select * from dept;

select * from dept_tmp;
-- dept_tmp ���̺� LOCATION �÷� �߰�
alter table dept_tmp
add(LOCATION varchar2(50));
-- 10���� �μ��� location�� �������� ����
update dept_tmp
set location='����'
where deptno = 10;
-- �÷� ���� ����
alter table dept_tmp
modify(location varchar2(70));
commit;
-- ����Ȯ�� 
DESCRIBE dept_tmp;
desc dept_tmp;
-- �÷��� ����
alter table dept_tmp
drop column location;
commit;
select * from dept_tmp;

--�÷��� LOC �� LOCATION ���� ����
alter table dept_tmp
rename COLUMN loc to location;
--���̺� �� ����
rename dept_tmp to dept_tmptmp;

select * from dept_tmptmp;
--��� ������ ����
delete from dept_tmptmp;
rollback;
-- rollback �ϸ� ������ ��� ������ ����
select * from dept_tmptmp; 

--��� ������ ���� ������ �״��(truncate DDL �̹Ƿ� rollback ������� �ʾ� ���� �ȵ�)
truncate table dept_tmptmp;
rollback;
select * from dept_tmptmp; 
-- ���̺� ����(������ ���� ��� ����)
drop table dept_tmptmp;
--9�� �������� p262
--1. ��ü ��� �� ALLEN �� ���� ��å(JOB)�� ������� �������, �μ����� ���
select e.job, e.empno, e.ename, e.sal, e.deptno, d.dname
from emp e, dept d
where e.deptno = d.deptno 
and job = (select job
        from emp
         where ename = 'ALLEN');
--2.��ü ����� ��� �޿����� ���� �޿��� �޴� ������� �������, �μ�����, �޿� ��� ���� ���
--(�޿��� ���� ��, ������ �����ȣ ��������)
select e.empno, e.ename, d.dname, e.hiredate, d.loc, e.sal, s.grade
from emp e, dept d, salgrade s
where e.deptno = d.deptno and
       e.sal between s.losal and s.hisal and
       sal > (select avg(sal) from emp)
order by e.sal desc , e.empno  ;
--3 10�� �μ��� �ٹ��ϴ� ��� �� 30�� �μ����� �������� �ʴ� ��å�� ���� ������� ������� �μ����� ���
select e.empno, e.ename, e.job, e.deptno, d.dname, d.loc
from emp e, dept d
where e.deptno = d.deptno 
and e.deptno = 10
and job not in (select job from emp where deptno = 30);
--4.��å�� SALESMAN�� ������� �ְ� �޿����� ���� �޿��� �޴� ������� �������, �޿� �������
--(�����ȣ ��������)
-- ������ �Լ��� ������� �ʴ� ���
select e.empno, e.ename, e.sal, s.grade
from emp e, salgrade s
where e.sal between s.losal and s.hisal
and sal > (select max(sal) from emp where job='SALESMAN')
order by e.empno;

--������ �Լ��� ��� ���
select e.empno, e.ename, e.sal, s.grade
from emp e, salgrade s
where e.sal between s.losal and s.hisal
and sal > ALL(select sal from emp where job='SALESMAN')
order by e.empno;

---10�� �������� p287
create table chap10hw_emp
 as select * from emp;
create table chap10hw_dept
  as select * from dept;
create table chap10hw_salgrade
  as select * from salgrade;
 -- 10-1 CHAP10HW_DEPT ���̺� 50,60,70,80 ���� �߰�
INSERT INTO CHAP10HW_DEPT (DEPTNO, DNAME, LOC) VALUES (50, 'ORACLE', 'BUSAN'); 
INSERT INTO CHAP10HW_DEPT (DEPTNO, DNAME, LOC) VALUES (60, 'SQL', 'ILSAN');
INSERT INTO CHAP10HW_DEPT (DEPTNO, DNAME, LOC) VALUES (70, 'SELECT', 'INCHEON');
INSERT INTO CHAP10HW_DEPT (DEPTNO, DNAME, LOC) VALUES (80, 'DML', 'BUNDANG'); 
commit;
select * from CHAP10HW_DEPT;
-- 10-2  CHAP10HW_DEPT ���̺� �Ʒ� 8���� ��� �߰�
INSERT INTO CHAP10HW_EMP
VALUES(7201, 'TEST_USER1', 'MANAGER', 7788, TO_DATE('2016-01-02', 'YYYY-MM-DD'), 4500, NULL, 50);
INSERT INTO CHAP10HW_EMP
VALUES(7202, 'TEST_USER2', 'CLERK', 7201, TO_DATE('2016-02-21', 'YYYY-MM-DD'), 1800, NULL, 50);
INSERT INTO CHAP10HW_EMP
VALUES(7203, 'TEST_USER3', 'ANALYST', 7201, TO_DATE('2016-04-11', 'YYYY-MM-DD'), 3400, NULL, 60);
INSERT INTO CHAP10HW_EMP
VALUES(7204, 'TEST_USER4', 'SALESMAN', 7201, TO_DATE('2016-05-31', 'YYYY-MM-DD'), 2700, 300, 60);
INSERT INTO CHAP10HW_EMP
VALUES(7205, 'TEST_USER5', 'CLERK', 7201, TO_DATE('2016-07-20', 'YYYY-MM-DD'), 2600, NULL, 70);
 
INSERT INTO CHAP10HW_EMP
VALUES(7206, 'TEST_USER6', 'CLERK', 7201, TO_DATE('2016-09-08', 'YYYY-MM-DD'), 2600, NULL, 70);
 
INSERT INTO CHAP10HW_EMP
VALUES(7207, 'TEST_USER7', 'LECTURER', 7201, TO_DATE('2016-10-28', 'YYYY-MM-DD'), 2300, NULL, 80);
 
INSERT INTO CHAP10HW_EMP
VALUES(7208, 'TEST_USER8', 'STUDENT', 7201, TO_DATE('2018-03-09', 'YYYY-MM-DD'), 1200, NULL, 80);
commit;
select * from CHAP10HW_EMP;
--3. CHAP10HW_EMP �� ���� ��� �� 
-- 50�� �μ����� �ٹ��ϴ� ������� ��� �޿����� ���� �޿��� �ް� �ִ� �������
-- 70�� �μ��� �ű��
select avg(sal)
from CHAP10HW_EMP
where deptno = 50;

update CHAP10HW_EMP
set deptno = 70
where sal > (
        select avg(sal)
        from CHAP10HW_EMP
        where deptno = 50
);
commit;
select sal from CHAP10HW_EMP where deptno=70;
--4. CHAP10HW_EMP �� ���� ��� ��
--60�� �μ��� ��� �߿� �Ի����� ���� ���� ������� �ʰ� �Ի��� 
-- ����� �޿��� 10% �λ��ϰ� 80�� �μ���  �ű��
update CHAP10HW_EMP
set deptno = 80, sal = sal*1.1
where hiredate >(
    select min(hiredate)
    from CHAP10HW_EMP
    where deptno=60
);
commit;
--5. CHAP10HW_EMP�� ���� ��� �� �޿� ����� 5�� ����� �����Ѵ� SQL
select * from CHAP10HW_EMP
where sal = any (select sal 
               from CHAP10HW_EMP c, chap10hw_salgrade s
               where c.sal between s.losal and s.hisal
               and s.grade = 5);
               
select * from CHAP10HW_EMP
where sal in (select sal 
               from CHAP10HW_EMP c, chap10hw_salgrade s
               where c.sal between s.losal and s.hisal
               and s.grade = 5);  
               
delete from CHAP10HW_EMP
where empno in (select c.empno 
               from CHAP10HW_EMP c, chap10hw_salgrade s
               where c.sal between s.losal and s.hisal
               and s.grade = 5);                 
               
delete from CHAP10HW_EMP
where sal in (select sal 
               from CHAP10HW_EMP c, chap10hw_salgrade s
               where c.sal between s.losal and s.hisal
               and s.grade = 5);    
               
commit;    
select * from CHAP10HW_EMP;

----11�� Ʈ�����
-- Ʈ����� : �� �̻� ���� �� �� ���� �ּ� ���� ������ 
--          �� ���� �����Ͽ� �۾��� �Ϸ��ϰų� ��� �������� �ʰų�(�۾����)
--          ALL or Nothing(commit / rollback)
--          TCL

-- p298 �б��ϰ���
-- �ݸ�����
-- Oracle : Read Commited
-- MySQL  : Repeatable  Commited

--12�� �������� p324
--1.

drop table emp_hw;
create table emp_hw(
    empno number(4),
    ename varchar2(10),
    job   varchar2(9),
    mgr number(4),
    hiredate date,
    sal number(7,2),
    comm number(7,2),
    deptno number(2)
);
--2. emp_hw���̺� bigo �÷� �߰�
alter table emp_hw
add bigo varchar2(20);

select * from emp_hw;
--3. bigo ũ�⸦ 30���� ����
alter table emp_hw
modify bigo varchar2(30);
desc emp_hw;
--4.BIGO�� REMARK�� ����
alter table emp_hw
rename column bigo to remark;
select * from emp_hw;
--5. EMP_HW ���̺� EMP ���̺��� �����͸� ��� ����, �� REMARK ���� NULL �� ����

insert into emp_hw
select empno, ename, job ,mgr, hiredate,sal, comm, deptno,NULL
from emp;

delete from emp_hw;
commit;

select * from emp_hw;
insert into emp_hw(empno, ename, job ,mgr, hiredate,sal, comm, deptno)
select *
from emp;
commit;
--6 EMP_HW ���̺� ����
drop table EMP_HW;





               

















