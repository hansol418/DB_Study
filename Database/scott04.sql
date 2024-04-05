--p238
-- emp, dept �޿��� 3000�̻��̸� ���ӻ���� �ݵ�� �־����
-- �����ȣ, �̸� , ��å(job), mgr, hiredate, sal, comm, deptno, dname, loc
-- join ~ using
select e.empno, e.ename, e.job, e.mgr, e.hiredate, e.sal, e.comm, deptno,
 d.dname, d.loc
from emp e join dept d using (deptno)
where sal >= 3000 and e.mgr is not null;

select e.empno, e.ename, e.job, e.mgr, e.hiredate, e.sal, e.comm, e.deptno,
 d.dname, d.loc
from emp e join dept d 
on e.deptno = d.deptno
where sal >= 3000 and e.mgr is not null;
---p242 ��������
select * from emp;
--WARD ���� ������ ���� ���� ��� �̸� ���
select sal from emp where ename='WARD';
select ename from emp where sal > 1250;

select ename
from emp
where sal > (
                select sal
                from emp
                where ename = 'WARD'
            );
--'ALLEN' �� ����(job)�� ���� ����� �̸�(enmae),�μ���(dname),�޿�(sal),����(job) ���
select job
from emp
where ename = 'ALLEN';
-- job  �� SALESMAN ����� �̸�(ename),�μ���(dname),�޿�(sal),����(job) ���
select e.ename, d.dname, e.sal, e.job
from emp e, dept d
where e.deptno = d.deptno and e.job = 'SALESMAN';

select e.ename, d.dname, e.sal, e.job
from emp e, dept d
where e.deptno = d.deptno 
  and e.job =(
              select job
              from emp
              where ename = 'ALLEN'
              );
              
select e.ename, d.dname, e.sal, e.job
from emp e, dept d
where e.deptno = d.deptno 
  and e.job =(
              select job
              from emp
              where ename = 'ALLEN'
              )
  and e.ename <> 'ALLEN' ;     
-- ALLEN ���� ���� �Ի��� ����� ����  
select hiredate
from emp
where ename = 'ALLEN';
select *
from emp
where hiredate < '81/02/20';

select *
from emp
where hiredate <(
        select hiredate
        from emp
        where ename = 'ALLEN'
        );
-- ��ü ����� ��� �ӱݺ��� ���� ����� 
--�����ȣ(empno), �̸�(ename), �μ���(dname), �Ի���(hiredate) ���   
select avg(sal)
from emp;

select e.empno, e.ename, d.dname, e.hiredate
from emp e, dept d
where e.deptno = d.deptno and
 e.sal > (select avg(sal) from emp);
 
 --p248
 --��ü ����� ��� �޿����� �۰ų� ���� �޿��� �ް� �ִ�
 -- 20�� �μ��� ��� �� �μ�����
 --�����ȣ(empno), �̸�(ename), ����(job), �޿�(sal), �μ���ȣ(deptno), �μ���(dname) ,�μ�����(loc)
select e.empno, e.ename, e.job,e.sal, e.deptno, d.dname, d.loc
from emp e, dept d
where e.deptno = d.deptno 
        and e.deptno=20
        and e.sal <= (
                   select avg(sal)
                   from emp
                );
-- �� �μ��� �ְ� �޿��� ������ �޿��� �޴� ��� ���� ���
select deptno, max(sal)
from emp
group by deptno;

select *
from emp
where sal in (
    select  max(sal)
    from emp
    group by deptno
    );
-- 10�� �μ� �߿��� 30�� �μ����� ����  ����(job)�� �ϴ� (President)
-- ����� �����ȣ, �̸�, �μ���, �Ի��� ,���� ���
select job from emp where deptno=10;
select job from emp where deptno=30;
select job from emp where deptno=10
minus
select job from emp where deptno=30;

select e.empno, e.ename, d.dname, e.hiredate, d.loc, e.job
from emp e, dept d
where e.deptno = d.deptno
    and e.deptno = 10
    and e.job  not in (
                select job
                from emp
                where deptno =30
         );
         
--mgr ��  KING �� ����� �̸���  job  ��� 
select * from emp;
select empno from emp where ename = 'KING';
select empno, ename,job from emp where mgr = 7839;
-- �������� ���
select ename, job
from emp
where mgr = (
    select empno
    from emp
    where ename='KING'
);

-- �������� ��� ����(��������)
select e.ename, e.job
from emp e, emp m
where e.mgr = m.empno and m.ename ='KING';

-- �Ŵ����� KING  �̰ų� FORD  �� ������� �̸��� ���� ���
--��������
 select empno
    from emp
    where ename = 'KING' or ename='FORD';

select ename, job
from emp
where mgr  in (
    select empno
    from emp
    where ename = 'KING' or ename='FORD'
 );
 
 --(��������)
 select e.ename, e.job
 from emp e, emp m
 where e.mgr = m.empno and (m.ename='KING' or m.ename='FORD');
 
 select e.ename, e.job
 from emp e join emp m
 on e.mgr = m.empno and (m.ename='KING' or m.ename='FORD');
 
 --p251
 select ename, sal
 from emp
 where sal < any(select sal
                from emp
                where job='SALESMAN');
                
select ename, sal  from emp;  --12��
                
select sal               --1600  1250 1250  1500
from emp
where job='SALESMAN';

 select ename, sal
 from emp
 where sal < all (select sal     --1600  1250 1250  1500
                from emp
                where job='SALESMAN');
                
-- 30�� �μ�����  �ִ�޿����� ���� �޿��� �޴� ��� ���(any, all ���)
select sal from emp where deptno =30; --1600 1250 1250 2850 1500 950
select sal
from emp
where sal < ( select max(sal)
                from emp
                where deptno=30          
            );
            
select sal from emp
where sal < any(select sal
                from emp
                where deptno=30);
                
--- p239~p240 8�� ��������
--1. �޿�(sal)�� 2000�ʰ��� ������� �μ�����, �������
--deptno, dname, empno, ename, sal(2���� ���)
select d.deptno, d.dname, e.empno, e.ename, e.sal
from emp e, dept d
where e.deptno = d.deptno and e.sal > 2000;

--natural ~ join  
select deptno, d.dname, e.empno, e.ename, e.sal
from emp e NATURAL JOIN dept d
where e.sal > 2000;
-- join ~ on
select d.deptno, d.dname, e.empno, e.ename, e.sal
from emp e join dept d
on e.deptno = d.deptno and e.sal > 2000;
  
--2.�μ��� ��� �޿�, �ִ�޿�, �ּұ޿�, ����� ���
select e.deptno, d.dname, trunc(avg(e.sal)) as avg_sal, 
   max(e.sal) as max_sal,  min(e.sal) as min_sal,count(*) as cnt
from emp e, dept d
where e.deptno = d.deptno 
group by e.deptno, d.dname;

--join using 
select deptno, d.dname, trunc(avg(e.sal)) as avg_sal, 
   max(e.sal) as max_sal,  min(e.sal) as min_sal,count(*) as cnt
from emp e join  dept d
using(deptno) 
group by deptno, d.dname;

--join~on
select e.deptno, d.dname, trunc(avg(e.sal)) as avg_sal, 
   max(e.sal) as max_sal,  min(e.sal) as min_sal,count(*) as cnt
from emp e join dept d
on e.deptno = d.deptno 
group by e.deptno, d.dname;

--3. �μ���ȣ, ����̸� ������ ��� �μ������� ��� ���
-- + 
select d.deptno, d.dname, e.empno, e.ename, e.job, e.sal
from emp e, dept d
where e.deptno(+) = d.deptno 
order by d.deptno, e.ename;

-- left  outer join 
select d.deptno, d.dname, e.empno, e.ename, e.job, e.sal
from dept d left outer join emp e
on e.deptno = d.deptno 
order by d.deptno, e.ename;

-- right outer join
select d.deptno, d.dname, e.empno, e.ename, e.job, e.sal
from emp e right outer join dept d
on e.deptno = d.deptno 
order by d.deptno, e.ename;

--4.��� �μ�����, �������, �޿� �������, �� ����� ���� ����� ������ 
 --�μ���ȣ, ��� ��ȣ ������ �����Ͽ� ���
 select d.deptno, d.dname,
        e.empno, e.ename, e.mgr, e.sal, e.deptno,
        s.losal, s.hisal, s.grade,
        e2.empno mgr_empno, e2.ename mgr_ename
 from emp e, dept d, salgrade s, emp e2
 where e.deptno(+) = d.deptno
 and e.sal between s.losal(+) and s.hisal(+)
 and e.mgr = e2.empno(+)
 order by d.deptno, e.empno;
 --join~on
 select d.deptno, d.dname,
        e.empno, e.ename, e.mgr, e.sal, e.deptno,
        s.losal, s.hisal, s.grade,
        e2.empno mgr_empno, e2.ename mgr_ename
 from emp e right outer join dept d    on (e.deptno = d.deptno)
            left outer join salgrade s on (e.sal between s.losal and s.hisal)
            left outer join emp e2     on (e.mgr = e2.empno)
 order by d.deptno, e.empno;
 ---
 select * from dept;
 select *
 from dept
 where EXISTS (
        select deptno
        from dept
        where deptno =20
      );
--p258 �μ��� �ִ� �޿��� ���� ��� ���� ���
select *
from emp
where (deptno, sal) in (
                    select deptno,  max(sal)
                    from emp
                    group by deptno
                    );

 select deptno,  max(sal)
 from emp
 group by deptno;

 

 








