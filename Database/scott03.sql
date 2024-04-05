--1. professor���̺��� �� ���� �� ���
select count(*) from professor;

--2. ������ �޿� �հ�
select sum(sal) from professor;

--3. ������ �޿� ���
select avg(sal) from professor;

--4. ������ �޿��� ����� ���ϴµ� �Ҽ��� ù° �ڸ����� �ݿø�
select round(avg(sal)) from professor;

--5. ������ �߿��� �ְ� �޿�
select max(sal) from professor;

--6.������ �߿��� �ּ� �޿�
select min(sal) from professor;
--7. �����߿� �ְ� �޿��� �޴� ����� �̸��� �޿��� ���
select name, sal
from professor
where sal=500;

select name, sal
from professor
where sal=(select max(sal) from  professor);
----
-- emp ���̺�
--1. 10�� �μ��� ��� �޿�
select round(avg(sal))
from emp
where deptno=10;

--20�� �μ��� ��� �޿� 
select round(avg(sal)) from emp where deptno =20;

-- 30�� �μ��� ��� �޿�
select round(avg(sal)) from emp where deptno =30;

--
select round(avg(sal)) from emp where deptno =10
union
select round(avg(sal)) from emp where deptno =20
union
select round(avg(sal)) from emp where deptno =30;

-- �μ��� ���� ��� �޿���� (�μ���ȣ, ������)
select deptno, round(avg(sal)) as "�μ��� ��ձ޿�"
from emp group by deptno;

-- �μ��� ���� ��� �޿���� (�μ���ȣ, ������) �μ��� ��������
select deptno, round(avg(sal)) as "�μ��� ��ձ޿�"
from emp 
GROUP BY deptno
order by deptno;

-- emp ���̺��� �μ���ȣ �� ��å(job) �� ��ձ޿�, �μ���ȣ ��������, ���� �޿� ������ ���
select deptno, job, round(avg(sal)) avgsal
from emp
GROUP BY deptno, job
order by deptno desc, avgsal desc;

-- emp ���̺��� �μ���ȣ �� ��å(job) �� ��ձ޿�, �μ���ȣ ��������, job �̸� ������������ ���
select deptno, job, round(avg(sal)) 
from emp
GROUP BY deptno, job
order by deptno desc, job asc;

----professor ���̺� ���
select * from professor;
--1. �а���(deptno) �������� ��� �޿�
select deptno, avg(sal)
from professor
group by deptno;

-- 2. �а��� �������� �հ� �޿�(sal)
select deptno, sum(sal),count(*)
from professor
group by deptno
order by deptno;

--3. �а��� ���޺�(posotion) �������� ��� �޿�
select deptno, position, avg(sal)
from professor
group by deptno, position
order by deptno;
--4. ���� �߿��� �޿�(sal)�� ��������(comm)�� ��ģ �ݾ��� ���� ���� ����
-- ���� ���� ���  ���
-- ��,  comm �� ���� ������ �޿��� 0���� ���, �޿��� �Ҽ��� ��° �ڸ����� �ݿø�
 select round(max(nvl(sal+comm, 0)), 1) �ִ밪,
        round(min(nvl(sal+comm, 0)), 1) �ּҰ�
 from professor;
 
select round(max(sal+nvl(comm,0)), 1) �ִ밪,
       round(min(sal+nvl(comm,0)), 1) �ּҰ�
 from professor;
 ---
 --5.���޺� ��� �޿��� 300���� ũ�� '���' �۰ų� ������ '����'
  --- ���޺�(position), ��ձ޿�, ��� ���
select position, avg(sal),
       case when avg(sal) > 300 then '���'
            when avg(sal) <=300 then '����'
       end   ���
from professor
group by position;
-----
--emp ���̺��� �Ի��� �⵵�� �ο� �� 
-- total 1980  1981   1982
--  12     1    10     1 
select hiredate from emp;
select count(*) total,
        sum(decode(to_char(hiredate,'YYYY'),1980,1,0)) "1980�⵵",
        sum(decode(to_char(hiredate,'YYYY'),1981,1,0)) "1981�⵵",
        sum(decode(to_char(hiredate,'YYYY'),1982,1,0)) "1982�⵵"
from emp;
-- emp ���̺��� 1000�̻��� �޿��� ������ �ִ� ����鿡 ���ؼ��� �μ��� ����� ���ϵ�
-- �μ��� ����� 2000 �̻��� �μ���ȣ, �μ��� ��ձ޿� ���

select deptno, round(avg(sal))
from emp
where sal>1000
group by deptno
having avg(sal) >=2000;

select deptno, round(avg(sal))
from emp
group by deptno
having avg(sal) >=2000;

--professor ���̺�
-- �а���(deptno) ���޺�(position) �������� ��� �޿� �߿��� ��� �޿��� 400�̻��ΰ� ���
-- �а���ȣ ���� ��ձ޿�
select deptno, position, avg(sal)
from professor
group by deptno, position
having avg(sal) >= 400;

---p196
select deptno,job,count(*),max(sal), sum(sal), min(sal), avg(sal)
from emp
group by deptno, job
order by deptno, job;
-- rollup(A,B,C)  A,B,C / A,B / A �� ���� �� ���
-- rollup(A,B)  A,B / A �� ���� �� ���
select deptno, job, count(*), max(sal), sum(sal),min(sal), round(avg(sal))
from emp
group by rollup(deptno, job)
order by deptno,job;
-- cube(A,B,C)  A,B,C / A,B / A,C / B,C/ A/B/C �� ���� �� ���
-- cube(A,B)  A,B / A /B �� ���� �� ���
select deptno, job, count(*), max(sal), sum(sal),min(sal), round(avg(sal))
from emp
group by cube(deptno, job)
order by deptno,job;

---- ����  p215
select * from emp;
select * from dept;
--  �����ȣ(empno), ����̸�(ename),   job, dname, loc
select * 
from emp, dept; 

select *
from emp e, dept d
where e.deptno = d.deptno;

select empno, ename, job, e.deptno,dname, loc
from emp e, dept d
where e.deptno = d.deptno;

---
 select * from emp;
 select * from salgrade;
 --������
 select *
 from emp e, salgrade  s
 where e.sal between s.losal and s.hisal;
 -- �ڽ��� ���(mgr) �� �̸� ���
  select * 
  from emp e1, emp e2
  where e1.mgr = e2.empno;
  
  --��ü����(��������)
  select e1.empno, e1.ename, e1.mgr, e2.empno ���ȸ����ȣ, e2.ename ����̸�
  from emp e1, emp e2
  where e1.mgr = e2.empno;
  
  --emp ���̺���  deptno�� 30���� ����� ��ȸ�Ͽ�
  --comm ���� ���� ��� 'Exist' ��
  --comm ����  null ��� 'Null' ���
select empno, ename, comm, nvl2(comm, 'Exist','Null')
from emp
where deptno =30;

-- �޿��� 2500�����̰� ����� 9999 ������ ����� ������ ���
-- �����ȣ(empno), �̸�(ename), �޿�(sal), �μ���ȣ(deptno), �μ���(dname), �μ�����(loc)
 select e.empno, e.ename, e.sal, d.deptno, d.dname, d.loc
from emp e, dept d
where e.deptno = d.deptno and e.sal <=2500 and e.empno<9999;

-- �̸��� 'ALLEN' �� ����� �μ��� ���
select e.ename, d.dname
from emp e, dept d
where ename = 'ALLEN' and e.deptno = d.deptno;

select e.ename, d.dname
from emp e, dept d
where  e.deptno = d.deptno and ename = 'ALLEN';

--1. �޿��� 3000���� 5000������ ������ �̸��� �Ҽ� �μ����� ����϶�
select e.ename, d.dname, e.sal
from emp e, dept d
where e.deptno = d.deptno
    and e.sal between 3000 and 5000;
    
select e.ename, d.dname, e.sal
from emp e join dept d
on e.deptno = d.deptno
and e.sal between 3000 and 5000;
    

--2. ������ MANAGER�� ����� �̸�, �μ����� ����϶�
select e.ename, d.dname, e.sal
from emp e, dept d
where e.deptno = d.deptno and e.job = 'MANAGER';

select e.ename, d.dname, e.sal
from emp e join dept d
on e.deptno = d.deptno and e.job = 'MANAGER'; 

--p212~213 ��������
--1. emp ���̺�/ �μ���ȣ, ��ձ޿�, �ְ�޿�, �����޿�, ����� ���
--��, ��ձ޿��� �Ҽ��� ����, �� �μ���ȣ�� ���
select  deptno, 
        trunc(avg(sal)) avg_sal,
        max(sal) max_sal,
        min(sal) min_sal,
        count(*) as cnt
from emp
group by deptno
order by deptno;

--2, ���� ��å�� �����ϴ� ����� 3�� �̻��� ��å�� �ο���
select job, count(*)
from emp
group by job
having count(*)  >=3;

--3. ������� �Ի翬���� �������� �μ����� ����� �Ի��ߴ��� ���
select  to_char(hiredate, 'YYYY') HIRE_YEAR, deptno, count(*) CNT
from emp
group by to_char(hiredate, 'YYYY'),deptno;

--4. �߰�����(comm)�޴� ��� ���� ���� �ʴ� ��� �� ���
select nvl2(comm, 'O','X') EXIST_COMM , count(*) CNT
from emp
group by nvl2(comm, 'O','X');

--5. �� �μ��� �Ի翬���� �����, �ְ�޿�, �޿� ��, ��� �޿� ����ϰ�
-- �� �μ��� �Ұ�� �Ѱ� ���
select deptno, 
        to_char(hiredate,'YYYY') HIRE_YEAR, 
        count(*) CNT,
        max(sal) MAX_SAL,
        sum(sal) SUM_SAL,
        round(avg(sal),1) AVG_SAL
from emp
group by rollup(deptno, to_char(hiredate,'YYYY'))
order by deptno;
---------
-- ����
--1. ACCOUNTING �μ� �Ҽ� ����� �̸��� �Ի����� ���
select ename, hiredate
from emp e,dept d
where e.deptno = d.deptno and   dname='ACCOUNTING';
-- join~on ���
select e.ename, e.hiredate
from emp e join dept d
on e.deptno = d.deptno and d.dname='ACCOUNTING';

--2. 0���� ����  comm �� �޴� ��� �̸��� �μ��� ���
select e.ename, d.dname
from emp e, dept d
where e.deptno = d.deptno 
    and e.comm is not null
    and e.comm > 0; 
    
select e.ename, d.dname
from emp e, dept d
where e.deptno = d.deptno 
    and e.comm is not null
    and e.comm <> 0;     
    
select e.ename, d.dname
from emp e, dept d
where e.deptno = d.deptno 
    and e.comm > 0;     
    
select e.ename, d.dname
from emp e, dept d
where e.deptno = d.deptno 
    and e.comm <> 0;      

-- join ~ on
select e.ename, d.dname
from emp e join dept d
            on  e.deptno = d.deptno 
            and e.comm is not null
            and e.comm <> 0;
            
-- 3.  ���忡�� �ٹ��ϴ� ����� �̸��� �޿��� ����϶�
select e.ename, e.sal
from emp e, dept d
where e.deptno = d.deptno 
   and d.loc = 'NEW YORK';

--join ~ on
select  e.ename, e.sal
from emp e join dept d
on e.deptno = d.deptno
and  d.loc = 'NEW YORK';

--4. SMITH�� ������ �ٹ������� �ٹ��ϴ� ����� �̸��� ���
select * from emp;
select * from dept;

select ename
from emp
where deptno = (select deptno from emp where ename='SMITH')
  and ename <> 'SMITH';
-- ��������  
select friend.ename as "SMITH ����"
from emp e, emp friend
where e.deptno = friend.deptno 
        and e.ename = 'SMITH' 
        and friend.ename <> 'SMITH';
        
select f.ename as smith����
from emp e join emp f
on e.deptno = f.deptno 
    and e.ename = 'SMITH' and f.ename <> 'SMITH';
    
-- �Ŵ����� KING�� ������� �̸��� ������ ����϶�
select e.ename, e.job, e.mgr
from emp e, emp m
where e.mgr = m.empno
    and m.ename= 'KING';
    
select ename, job, mgr
from emp
where mgr = (select empno from emp where ename = 'KING');

select e.ename, e.job, e.mgr
from emp e join emp m
            on e.mgr = m.empno 
            and m.ename = 'KING';
            
-- p229
select * from emp;
select e1.empno, e1.ename, e1.mgr �Ŵ�����ȣ
from emp e1, emp e2
where e1.mgr = e2.empno(+);

select * from emp;
select e1.empno, e1.ename, e1.mgr �Ŵ�����ȣ
from emp e1, emp e2
where e1.mgr(+)= e2.empno;

--p232  ǥ��
select e.empno, e.ename,e.sal, e.mgr, deptno, d.dname, d.loc
from emp e natural join dept d
where e.sal>2000
order by deptno, e.empno;
--
select e.empno, e.ename,e.sal, e.mgr, deptno, d.dname, d.loc
from emp e join dept d using(deptno)
where e.sal > 2000
order by deptno, e.empno;

--p234(join~on : ���� ���� ����ϴ� ���)
select  e.empno, e.ename,e.sal, e.mgr, e.deptno, d.dname, d.loc
from emp e join dept d
on e.deptno = d.deptno 
where e.sal > 2000;

-----
select * from emp;
select * from dept;
--��� �μ� ���
select e.ename, d.deptno, d.dname
from emp e, dept d
where e.deptno(+) = d.deptno
order by e.deptno;

select e.ename, d.deptno, d.dname
from emp e right outer join dept d 
        on e.deptno = d.deptno;
        
select e.ename, d.deptno, d.dname
from dept d left outer join emp e
        on e.deptno = d.deptno;        
       
 ----

select e.ename, d.deptno, d.dname
from emp e, dept d
where e.deptno = d.deptno(+)
order by e.deptno;

select e.ename, d.deptno, d.dname
from emp e left outer join dept d 
        on e.deptno = d.deptno;








 





  



















