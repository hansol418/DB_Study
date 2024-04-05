--1.ename ���� ó������ 2���ڸ� �����Ͽ� �ҹ��ڷ� ���
select ename, substr(ename, 1,2) �̸� ,lower(substr(ename, 1,2)) �ҹ����̸�
from emp;

--REPLACE
select '010-1234-5678' as rep_before,
        replace('010-1234-5678','-',' ') rep_after
from dual;
--2. ename ���� S ��  s�� �����Ͽ� ���
select ename, replace(ename, 'S', 's')
from emp;

select 'Orace', LPAD('Orace',10,'#') as  LPAD1,
                RPAD('Orace',10,'#') as  RPAD1,
                LPAD('Orace',10) as  LPAD2,
                RPAD('Orace',10) as  RPAD2
from dual;
-- ���� : concat
select concat(ename, job)
from emp;
select concat(ename, ':')
from emp;
--3. concat ����Ͽ�  ename : job  ��)SMITH:CLERK
select concat(concat(ename,':'), job)
from emp;

select concat(ename, concat(':',job))
from emp;

--4. ���ڿ� ����
select ename || ':' || job ename_job
from emp;

--5. �����ȣ(empno)�� �� 2�ڸ��� ǥ���ϰ� �� 2�ڸ��� *ǥ�� ���
select empno, substr(empno,1,2),rpad(substr(empno,1,2),4,'*')
from emp;

select  rpad(substr(empno,1,2),4,'*') �����ȣ
from emp;

select  rpad(substr(empno,1,2),length(empno),'*') �����ȣ
from emp;
-- ��������
select trim('   oracle    ') as str, length(trim('   oracle    ')) ����,
       Ltrim('   oracle    ') as Lstr, length(Ltrim('   oracle    ')) Ltrim����,
       Rtrim('   oracle    ') as Rstr, length(Rtrim('   oracle    ')) Rtrim����
from dual;

--����
-- round(�ݿø�)
select round(123.567,1),round(123.567,2),
       round(123.567,-1), round(123.567)
from dual;

--Trunc(����)
select TRUNC(15.79, 1),TRUNC(15.793, 2),TRUNC(15.793, -1),TRUNC(15.793)
from dual;

--ceil, floor  ���� ����� ū��, ���� ���� ��ȯ
select ceil(3.14),floor(3.14),ceil(-3.14),floor(-3.14),trunc(-3.14),trunc(3.14)
from dual;

--������
select mod(15,6)
from dual;

--��¥
select sysdate ����,  sysdate+1 ����, sysdate-1 ����, sysdate+3
from dual; 

select sysdate, add_months(sysdate,3)
from dual;

select add_months('22/05/15',3)
from dual;
--����� ��ȣ, �̸�, �Ի���, �Ի� 10�� �� ��¥ ���
select empno, ename, hiredate, add_months(hiredate,120) �Գ���
from emp;

select empno, ename, hiredate,sysdate,
  months_between(hiredate,sysdate) as months1,
  months_between(sysdate,hiredate) as months2,
  trunc(months_between(sysdate,hiredate)) as months3
from emp;

select empno, ename, hiredate,sysdate,
  trunc(months_between(sysdate,hiredate))||'����' as �ٹ�������
from emp;

select empno, ename, hiredate,sysdate,
  concat(trunc(months_between(sysdate,hiredate)),'����') as �ٹ�������
from emp;
--
select sysdate, next_day(sysdate,'������'), last_day(sysdate), last_day('22/05/01')
from dual;
--6. �����ȣ(empno)�� ¦���� ����� ��ȣ(empno), �̸�(ename), ����(job) ���
select empno, ename, job
from emp
where mod(empno,2)=0;
--7. �μ���ȣ�� 10���� ����� �ٹ������� ���(����)
select ename, trunc(months_between(sysdate, hiredate))||'����' �ٹ�������
from emp
where deptno=10;

--�޿�(sal)�� 1500���� 3000 ������ ����� �� �޿��� 15%�� ȸ��� ����
-- �̸�, �޿�, ȸ��(�ݿø�) ���
select ename, sal,sal*0.15 ȸ��, round(sal*0.15)
from emp
where sal>1500 and sal<=3000;

--p157����ȯ�Լ�
--����+����(500==>����)
select empno,ename, empno+'500' 
from emp
where ename='SMITH';
--�����߻�
--select  'ABCD'+ empno, empno
--from emp
--where ename='SMITH';

select to_char(sysdate,'YYYY/MM/DD HH24:MI:SS') ���糯¥�ð�
from dual;

select to_char(sysdate, 'MM') from dual;
select to_char(sysdate, 'DD') from dual;
select to_char(sysdate, 'SS') from dual;
select to_char(sysdate, 'MI') from dual;
select to_char(sysdate, 'MON') from dual;
select to_char(sysdate, 'MONTH') from dual;
select to_char(sysdate, 'day') from dual;
select to_char(sysdate, 'DAY') from dual;
-- �Ի����� 1,2,3���� ����� ���(empno), �̸�(ename), �Ի���(hiredate) ���
select empno,ename,hiredate
from emp
where to_char(hiredate,'MM') in('01','02','03');

select empno,ename,hiredate
from emp
where to_char(hiredate,'MM') between '01' and '03';

--
select sal, to_char(sal,'$999,999') sal_$,
            to_char(sal, 'L999,999') as sal_L,
            to_char(sal, '000,999') as sal_0
from emp;

select to_char(123456, '$99,999')
from dual;

select to_number('1,300','999,999')-to_number('1,500','999,999')
from dual;
--80/12/17  �� ���ķ� �Ի��� ��� ���
select empno, ename, hiredate
from emp
where hiredate > '80/12/17';

select empno, ename, hiredate
from emp
where hiredate > to_date('1980/12/17', 'YYYY/MM/DD');

--   ���, �̸�, �޿�, Ŀ�̼�, �޿�+Ŀ�̼� ���
select empno, ename, sal, comm,nvl(comm,0),sal+nvl(comm,0)
from emp;

 --nvl2(��, null �ƴҶ�,  null)
select empno, ename, comm, nvl2(comm,'O','X')  
from emp;
-- ���� (1��ġ�޿�+comm)
select empno, ename, sal*12+nvl(comm,0) ����1 ,
    nvl2(comm, sal*12+comm, sal*12) ����2
from emp;

--mgr �� null �̸� 'CEO'�� ���,  empno, ename, mgr
select empno, ename,nvl(to_char(mgr),'CEO')
from emp;

select empno, ename,nvl(to_char(mgr),'CEO')
from emp
where mgr is null;

--p170
-- job �� ���� �޿� �λ���� �ٸ��� ����
-- MANAGER 1.5  /    SALESMAN 1.2 / ANALST 1.05  / 1.04
-- decode
select empno, ename, job, sal,
       decode(job, 'MANAGER', sal*1.5,
                    'SALESMAN',sal*1.2,
                    'ANALST',sal*1.05,
                    sal*1.04) upsal
from emp;

--case when  end
select empno, ename, job, sal,
   case job
    when 'MANAGER' then sal*1.5
    when 'SALESMAN' then sal*1.2
    when 'ANALST' then sal*1.05
    else sal*1.04
   end  as upsal
from emp;

-- comm �� null �̸� �ش���Ծ���, comm=0 �̸� �������
-- comm  �� ������(50) ����:50
-- empno, ename, comm, comm_text ���
--case when  end
 select empno, ename, comm,
 case 
    when comm is null then '�ش���׾���'
    when comm=0 then '�������'
    when comm > 0 then '����:'||comm
 end as comm_text
 from emp;
 
select empno, ename,comm,
    decode (comm , null, '�ش���׾���',
               0 , '�������',
                '����:'||comm)
    as comm_text
 from emp;
 
  select empno, ename,to_char(comm),
    decode (comm , null, '�ش���׾���'
               , 0 , '�������'
               , '����:'||comm)
    as comm_text
 from emp;
 
 --professor ���̺� �̿�
 --1. professor ���̺��� ������(name)�� �а���ȣ(deptno), �а��� ���
 -- �а���ȣ�� 101�� ��ǻ�Ͱ��а� 101�� �ƴ� �а��� �а���
 -- �ƹ��͵� ������� ������
 select name, deptno, decode(deptno, 101,'��ǻ�Ͱ��а�')  �а��� 
 from professor;
 
 select name, deptno,
 case  when deptno=101 then '��ǻ�Ͱ��а�'
 end �а���
 from professor;
 
 --2. professor ���̺��� ������(name)�� �а���ȣ(deptno), �а��� ���
 -- �а���ȣ�� 101�� ��ǻ�Ͱ��а� 101�� �ƴ� �а��� ��Ÿ�� ���
 select name ,deptno, 
    decode(deptno, 101, '��ǻ�Ͱ��а�', '��Ÿ')  "�а���"
  from professor;
  
 select name, deptno,
 case  when deptno=101 then '��ǻ�Ͱ��а�'
        else '��Ÿ'
 end �а���
 from professor;
 
 select name, deptno,
 case  deptno when 101 then '��ǻ�Ͱ��а�'
        else '��Ÿ'
 end �а���
 from professor;
 
--3. �а���ȣ�� 101�� �а����� ��ǻ�Ͱ��а�  �� ����ϰ�
-- 102����  ��Ƽ�̵����а� 
-- 201 ����Ʈ���� ���� ������ ��Ÿ
 select name ,deptno, 
    decode(deptno, 101, '��ǻ�Ͱ��а�',
                   102, '��Ƽ�̵����а�',
                   201,'����Ʈ���� ����',
                   '��Ÿ')  �а���
  from professor;
  
  select name, deptno,
 case  deptno 
        when 101 then '��ǻ�Ͱ��а�'
        when 102 then '��Ƽ�̵����а�'
        when 201 then '����Ʈ���� ����'
        else '��Ÿ'
 end �а���
 from professor; 
 
 select name, deptno,
 case   
        when deptno = 101 then '��ǻ�Ͱ��а�'
        when deptno = 102 then '��Ƽ�̵����а�'
        when deptno = 201 then '����Ʈ���� ����'
        else '��Ÿ'
 end �а���
 from professor; 
 --p174 ��������
 --1. 
 select empno, rpad(substr(empno,1,2),length(empno),'*')  MASKING_EMPNO,
        ename,
        rpad(substr(ename,1,1),length(ename),'*') MASKING_ENAME
 from emp;
 
 select empno, rpad(substr(empno,1,2),length(empno),'*')  MASKING_EMPNO,
        ename,
        rpad(substr(ename,1,1),length(ename),'*') MASKING_ENAME
 from emp
 where length(ename) >=5 and length(ename) <6;

 select empno, rpad(substr(empno,1,2),length(empno),'*')  MASKING_EMPNO,
        ename,
        rpad(substr(ename,1,1),length(ename),'*') MASKING_ENAME
 from emp
 where length(ename) =5 ;

--2. 
select empno, ename, sal,
  trunc(sal/21.5) day_pay,
  round(sal/21.5/8) time_pay
from emp;

-- �Ҽ� ����° �ڸ����� ����  /  �ι�° �Ҽ������� �ݿø�
select empno, ename, sal,
  trunc(sal/21.5,2) day_pay,
  round(sal/21.5/8,1) time_pay
from emp;
--3.
select empno, ename, 
       hiredate, next_day(add_months(hiredate,3), '������') R_JOB
from emp;

select empno, ename, hiredate,
       to_char(next_day(add_months(hiredate,3), '������'), 'YYYY-MM-DD' ) R_JOB,
       nvl(to_char(comm),'N/A') COMM
from emp;
--4.
select empno, ename,mgr,
 case 
    when mgr is null then '0000'
    when substr(mgr,1,2) ='75' then '5555'
    when substr(mgr,1,2) ='76' then '6666'
    when substr(mgr,1,2) ='77' then '7777'
    when substr(mgr,1,2) ='78' then '8888'
    else to_char(mgr)
  end as CHG_MGR
from emp;

--decode
select  empno, ename,mgr,
    decode(substr(mgr,1,2), null, '0000',
         '75', '5555',
         '76', '6666',
         '77', '7777',
         '78', '8888',
         to_char(mgr)
     ) as  CHG_MGR
from emp;

select sal from emp;
select sum(sal) from emp;
select DISTINCT(sal) from emp;
select sum(DISTINCT(sal)) from emp;
select  sum(sal) �հ�,  sum(DISTINCT(sal)) �հ�2
from emp ;
-- �޿��հ� �� comm �հ�
select sum(sal), sum(comm)
from emp;

select sal from emp;
select ename from emp;
select count(sal) from emp;
select count(distinct(sal)) from emp;
select count(ename) from emp;
select count(*) from emp;

--�μ���ȣ�� 30�� ��� ��
select count(*)
from emp
where deptno=30;

-- comm �� null �� �ƴ� ����
select count(comm), count(*)
from emp
where comm is not null;

select count(sal), count(distinct(sal)), count(all sal)
from emp;
desc emp;

--�ִ밪
select max(sal)
from emp;

--�ּҰ�
select min(sal) from emp;

select max(sal), min(sal) from emp;

--���
select avg(sal) from emp;
--����� �ݿø��ؼ� ���ϱ� (�Ҽ�ù��°���� ���)
select round(avg(sal),1) from emp;

-- �μ���ȣ�� 20�� ����� �Ի��� �� ���� �ֱ� �Ի��� ���
select max(hiredate)
from emp
where deptno=20;
--professor ���̺�
select * from professor;
-- 1. �� ���� �� ���
select count(*) from professor;
-- 2.������ �޿� �հ�
select sum(sal) from professor;
--3. �޿� ���
select avg(sal) from professor;

--4. �޿� ����� ���ϴ� �Ҽ��� ù°�ڸ����� �ݿø�
select round(avg(sal)) from professor;
select round(avg(sal),0) from professor;
--5. �����߿��� �ְ�޿�
select max(sal) from professor;
--6. ���� �߿��� �ּұ޿�
select min(sal) from professor;

--7. ���� �߿��� �ְ� �޿��� �޴� ����� �̸��� �޿� ���
select name, sal
from professor
where sal = 500;

select name, sal
from professor
where sal = (select max(sal) from professor);



