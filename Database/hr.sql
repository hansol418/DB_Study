-- hr�������� �����Ͽ�
-- @��������\test_data_eng_����.sql �� �����մϴ�.(f5)]
--@D:\jung\test_data_eng_����.sql;

--1) Professor ���̺��� ������ �̸��� �а� ���� ����ϵ�
--�а� ��ȣ�� 101 �� �̸� ��Computer Engineering�� , 
--102 ���̸� ��Multimedia Engineering' , 
--103 ���̸� ��Software Engineering'
-- �������� ��ETC�� �� ����ϼ���.
select * from Professor;
select profno, name, deptno, 
    decode(deptno, 101, 'Computer Engineering',
    102, 'Multimedia Engineering',
    103, 'Software Engineering',
    'ETC') �а���
from Professor;

--2) student
select * from student;
--tel�� ������ȣ���� 02 ����, 051 �λ�, 052 ���, 053 �뱸 
-- �������� ��Ÿ�� ���
--�̸�, ��ȭ��ȣ, ���� ���
select name, tel from student;
select  substr(tel, 1,3) from student;
select instr(tel, ')') from student;
select  substr(tel, 1,instr(tel, ')')-1) from student;
select name, tel, 
    decode(substr(tel, 1,instr(tel, ')')-1), '2','����',
            '051','�λ�',
            '052','���',
            '053','�뱸',
            '��Ÿ')����
from student;
--professor ���̺�
--�а����� �Ҽ� �������� ��ձ޿�, �ּұ޿�, �ִ�޿� ���
--��, ��ձ޿��� 300 �Ѵ� �͸� ���
select deptno, round(avg(pay)) ��ձ޿�, min(pay) �ּұ޿�, max(pay) �ִ�޿�
from professor
group by deptno
having avg(pay)>300
order by deptno;


--student ���̺�
--�л� ���� 4�� �̻��� �г⿡ ���ؼ� �г�, �л� ��, ��� Ű, ��� �����Ը� ���
--��, ��� Ű�� ��� �����Դ� �Ҽ��� ù ��° �ڸ����� �ݿø��ϰ�,
--��¼����� ��� Ű�� ���� ������ ������������ ����Ͽ���.
select * from student;
select grade||'�г�', count(*) �л���, round(avg(height)) ���Ű, round(avg(weight)) ��ո�����
from student
group by grade
having count(*) >= 4
order by avg(height) desc;

-- �л��̸�, �������� �̸� ���
select * from student;
select * from professor;

select s.name �л��̸� , p.name ��������
from student s, professor p
where s.profno = p.profno;

--join~on
select s.name �л��̸� , p.name ��������
from student s  join professor p
on s.profno = p.profno;

--gift, customer
select * from  gift;
select * from customer;
-- ���̸�, ����Ʈ ,����
select c.gname ���̸�,  c.point  ����Ʈ, g.gname ����
from customer c, gift g
where c.point between g_start and g_end;

--join on
select c.gname ���̸�,  c.point  ����Ʈ, g.gname ����
from customer c join  gift g
on c.point between g_start and g_end;

-- 
select * from student;
select * from score;
select * from hakjum;
-- �л����� �̸�, ����(total) ���� ���
select s.name, s1.total, h.grade
from student s, score s1, hakjum h
where s.studno = s1.studno 
  and s1.total between h.min_point and h.max_point;
  
select s.name, s1.total, h.grade
from student s, score s1, hakjum h
where s.studno = s1.studno 
   and s1.total >=  h.min_point
   and s1.total <= h.max_point;

--join ~ on
select s.name, s1.total, h.grade
from  student s join  score s1 
                on s.studno = s1.studno
                join hakjum h
                on s1.total >=  h.min_point
                and s1.total <= h.max_point;
--   student ,     professor      
-- �л��̸��� �������� �̸� ����ϵ� ���������� �������� ���� �л� �̸��� ���
--15��
select s.name, p.name 
from student s, professor p
where s.profno = p.profno;
--20 ��
select count(*) from student;
select s.name, p.name 
from student s, professor p
where s.profno = p.profno(+);
-- ǥ��
select s.name, p.name 
from student s left outer join professor p
on  s.profno = p.profno;

select s.name, p.name
from professor p  right outer join   student s
on  s.profno = p.profno;

-- 101(deptno1) �� �а��� �Ҽӵ� �������� �̸� ���
-- ��, ���������� ���� �л��� ���(�л��̸�, ���������̸� ���)
select deptno1, name, profno
from student
where deptno1=101;

select s.name �л�, p.name ��������, deptno1
from student s, professor p
where s.profno = p.profno(+) and s.deptno1= 101;

select s.name �л�, p.name ��������, deptno1
from student s left outer join professor p
    on s.profno = p.profno
    where s.deptno1 =101;
----------------------
select * from dept2;
select * from emp2;
-- dept2���� area�� Seoul Branch Office �� ����� �����ȣ, �̸�, �μ���ȣ ���
select empno, name, deptno
from emp2 e, dept2 d
where e.deptno = d.dcode and area= 'Seoul Branch Office';
--��������
select empno, name, deptno
from emp2
where deptno in (
            select dcode
            from dept2
            where area ='Seoul Branch Office'
        ) ;
-----student ���̺�
-- student ���̺��� �� �г⺰ �ִ� �����Ը� ���� �л��� �г�, �̸�, ������ ���
--�г⺰ �ִ� ������
select  grade, max(weight)
from student
group by grade;

select grade, name ,weight
from student
where (grade, weight)  in ( 
                        select  grade, max(weight)
                        from student
                        group by grade
                        );
-- (professor,  department)  ���̺�
-- �� �а��� �Ի��� ���� ������ ������ ������ȣ, �̸� ,�а��� ���
-- �� �Ի����� ��������   (professor,  department) 
select * from professor;
select deptno, min(hiredate)
from professor
group by deptno;

select p.profno, p.name, p.deptno, d.dname, p.hiredate
from professor p , department d
where p.deptno = d.deptno
and (p.deptno, p.hiredate) in (select deptno, min(hiredate)
                                from professor
                                group by deptno)
order by p.hiredate;  

select p.profno, p.name, p.deptno, d.dname, p.hiredate
from professor p , department d
where p.deptno = d.deptno
and (p.deptno, p.hiredate) in (select deptno, min(hiredate)
                                from professor
                                group by deptno)
order by p.deptno;  

select p.profno, p.name, p.deptno, d.dname, p.hiredate
from professor p , department d
where p.deptno = d.deptno
and (p.deptno, p.hiredate) in (select deptno, min(hiredate)
                                from professor
                                group by deptno)
order by 3;  -- 3 �� select  ����




    

















