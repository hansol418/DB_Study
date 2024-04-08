--Ʈ�����(ACID)
-- A  ���ڼ� ( Atomicity )
-- C  �ϰ��� ( Consistency ) : �ϰ������� DB ���� ����
-- I  �ݸ��� ( Isolation ) 
   -- :  Ʈ����� ����� �ٸ� Ʈ������� �۾��� ������� ���ϵ��� �����ϴ� ��
-- D  ���Ӽ� ( Durability ) : ���������� ����� Ʈ������� ������ �ݿ��� �Ǵ� ��
   
--13�� p327  
--�����ͻ���
    --USER_   / ALL_  /DBA_
--�ε���  
--View(��)- ������ ���̺�(���Ǽ�, ���ȼ�)
select * from dictionary;
--scott ������ ������ �ִ� ��� ���̺� ��ȸ
select table_name from user_tables;
--scott ������ ������ �ִ� ��� ��ü ���� ��ȸ
select owner, table_name from all_tables;

--p341
--View(��)- ������ ���̺�(���Ǽ�, ���ȼ�)
create view vw_emp20
as (select empno, ename, job, deptno
    from emp
    where deptno > 20
);
select * from vw_emp20;
select * from user_views;

create or replace view vw_emp20
as
select empno, ename, job, deptno
from emp
where deptno>20;
--emp ���̺� ��ü ������  v_emp1  �� ����
create or replace view v_emp1
as
select * 
from emp;
select * from v_emp1;
-- v_emp1 (3000, 'ȫ�浿', sysdate) �߰�
insert into v_emp1(empno, ename, hiredate)
values(3000, 'ȫ�浿', sysdate);
select * from v_emp1;

select * from emp;

delete from emp
where empno =3000;
commit;
select * from emp;

drop view v_emp1;

create or replace view v_emp1
as 
select empno, ename, hiredate
from emp
with read only;  -- �б⸸

select * from v_emp1;
insert into v_emp1(empno, ename, hiredate)
values(3000, 'ȫ�浿',sysdate);  -- �����߻�

--�μ��� �ִ� �޿��� �޴� ����� �μ���ȣ, �μ��� ,�޿� ���
select * from emp;  -- 12��
select * from dept; -- 4��
--�μ��� �ִ� �޿�
select deptno, max(sal) sal
from emp
group by deptno;

select e.deptno, d.dname, e.sal
from emp e, dept d
where e.deptno = d.deptno
and (e.deptno, e.sal) in (select deptno, max(sal)
                        from emp
                        group by deptno);
 ------------------   
 --�ζ��κ�
select e.deptno, d.dname, e.sal
from (select deptno, max(sal) sal
             from emp
             group by deptno) e, dept d
where e.deptno = d.deptno;
--p346
select * from emp order by ename desc;
-- ������ 3���� ���
select * from emp;

select  rownum rn, e.*
from (select *
      from emp 
      order by ename desc) e
where rownum <=3;

--with ��� (p259)
with e as (select * from emp  order by ename desc)
select rownum, e.*
from e
where rownum <=3;

--p340 ������
 create table dept_sequence
 as select *
 from dept
 where 1<>1;
 
 select * from dept_sequence;
 --������ ����
create sequence seq_dept_sequence
INCREMENT BY 10
START WITH 10
MAXVALUE  90
MINVALUE 0
NOCYCLE
NOCACHE;

select * from user_sequences;
select * from dept_sequence;
-- 'DATABASE' 'SEOUL' �� �߰�
insert into dept_sequence(dname, loc)
values('DATABASE', 'SEOUL');
select * from dept_sequence;
insert into dept_sequence(deptno, dname, loc)
values(seq_dept_sequence.nextval,'DATABASE', 'SEOUL');
commit;
select * from dept_sequence;

insert into dept_sequence(deptno, dname, loc)values(seq_dept_sequence.nextval,'DATABASE1', 'SEOUL1');
insert into dept_sequence(deptno, dname, loc)values(seq_dept_sequence.nextval,'DATABASE2', 'SEOUL2');
insert into dept_sequence(deptno, dname, loc)values(seq_dept_sequence.nextval,'DATABASE3', 'SEOUL3');
insert into dept_sequence(deptno, dname, loc)values(seq_dept_sequence.nextval,'DATABASE4', 'SEOUL4');
insert into dept_sequence(deptno, dname, loc)values(seq_dept_sequence.nextval,'DATABASE5', 'SEOUL5');
commit;
select seq_dept_sequence.currval
from dual;
-- ������ ����
drop SEQUENCE seq_dept_sequence;
drop table dept_sequence;

create sequence emp_seq
INCREMENT By 1
START WITH 1
MINVALUE 1
NOCACHE
NOCYCLE;

select emp_seq.nextval  from dual;

alter SEQUENCE emp_seq
INCREMENT By  20
CYCLE;

select emp_seq.nextval  from dual;
drop SEQUENCE emp_seq;

--  p360  ��������  ===> �����͹��Ἲ
--not null
--unique
--primary key(�⺻Ű) - not null / unique
--foreign key(�ܷ�Ű)
--check

-- p362
create table table_notnull(
    login_id varchar2(20) not null,
    login_pwd varchar2(20) not null,
    tel varchar2(20)
);
insert into table_notnull(login_id, login_pwd, tel) values('aa','1111','010-1111-2222');
commit;
select * from table_notnull;
insert into table_notnull(login_id, login_pwd, tel) values('bb','1111','010-1111-2222');
commit;
select * from table_notnull;

insert into table_notnull(login_id, login_pwd) values('cc','1111');
commit;
select * from table_notnull;

insert into table_notnull(login_pwd, tel) values('1111','010-1111-2222'); --�����߻�  not null

create table table_notnull2(
    login_id varchar2(20) CONSTRAINT tbl_nn2_loginID not null,
    login_pwd varchar2(20)CONSTRAINT tbl_nn2_loginPWD not null,
    tel varchar2(20)
);
insert into table_notnull2 values('aa','1111','010-1111-2222');
insert into table_notnull2 values('aa','1111','010-1111-2222');
commit;

alter table table_notnull2
MODIFY (tel CONSTRAINT tbl_nn2_tel not null);
--�����߻�(tel �� not null ��)
--insert into table_notnull2(login_id, login_pwd) values('aa','1111');

--table_notnull2 ����  login_id �� unique �������� �ο�
alter table table_notnull2
modify(login_id  CONSTRAINT tbl_nn2_unique_loginID unique);

select * from table_notnull2;
delete from table_notnull2;
commit;
insert into table_notnull2 values('aa','1111','010-1111-2222');
-- �����߻� (���Ἲ ���� ����(SCOTT.TBL_NN2_UNIQUE_LOGINID)�� ����)
--insert into table_notnull2 values('aa','1111','010-1111-2222');
commit;

--���� ���� tbl_nn2_tel ����
alter table table_notnull2
drop constraint tbl_nn2_tel;

create table table_unique(
    login_id varchar2(20) constraint tbl_unique_loginID unique,
    login_pwd varchar2(20) not null,
    tel varchar2(20)
);
insert into table_unique values('aa','1111','010-1111-2222');
--�����߻�
--insert into table_unique values('aa','1111','010-1111-2222');
insert into table_unique values(null,'1111','010-1111-2222');
insert into table_unique values(null,'3333','010-1111-4444');
select * from table_unique;
-- ���� ���� ��ȸ
select owner, constraint_name
from user_constraints;

drop table table_unique;
drop table table_notnull2;
drop table table_notnull;
----
create table table_pk(
    login_id varchar2(20) primary key,
    login_pwd varchar2(20) not null,
    tel varchar2(20)
);
--�����߻� login_id �⺻Ű�̹Ƿ� �ݵ�� not null,  unique �ؾ� ��.
--insert into table_pk(login_pwd, tel) values('1111','010');
create table table_pk2(
    login_id varchar2(20) CONSTRAINT table_pk2_id primary key,
    login_pwd varchar2(20) not null,
    tel varchar2(20)
);
--�����߻� login_id �⺻Ű�̹Ƿ� �ݵ�� not null,  unique �ؾ� ��.
--insert into table_pk2(login_pwd, tel) values('1111','010');

--1)������ �� ���̺� ����
--board(num, title, writer, content, regdate)
--      number,                       date(�⺻�� : sysdate)
-- num : �⺻Ű
-- ������  ����:board_seq  1/1/1 no
create table board(
    num number(3) primary key,
    title varchar2(30),
    writer varchar2(30),
    content varchar2(100),
    regdate date default sysdate
);

create sequence board_seq
Increment by 1
start with 1
minvalue 1
nocycle
nocache;

--2) ������ �߰�
--(1, board1, ȫ�浿, 1�� �Խñ�, 24/04/08), (2, board2, ������, 2�� �Խñ�, 24/04/08)
insert into board(num, title, writer, content)
values(board_seq.nextval, 'board1','ȫ�浿','1�� �Խñ�');
insert into board
values(board_seq.nextval, 'board1','ȫ�浿','1�� �Խñ�',sysdate);
-- 2���� �����Ƿ� ���Ἲ �������� �������� ����
--insert into board values(2, 'board2','ȫ�浿2','2�� �Խñ�',sysdate);
commit;
select * from board;
--writer �÷�����  name ���� ����
alter table board
rename column writer to name;

insert into board
values(board_seq.nextval, 'board2','ȫ�浿2','2�� �Խñ�',sysdate);
insert into board
values(board_seq.nextval, 'board3','ȫ�浿3','3�� �Խñ�',sysdate);
insert into board
values(board_seq.nextval, 'board4','ȫ�浿4','4�� �Խñ�',sysdate);
insert into board
values(board_seq.nextval, 'board5','ȫ�浿5','5�� �Խñ�',sysdate);
commit;
select * from board;
--board  num ������������ �ؼ� ������ 3���� ���
select * from board order by num desc;

select rownum rn, b.*
from (select * from board order by num desc) b
where rownum <=3;

drop sequence board_seq;
drop table board;
---
create table table_name(
    col1 varchar2(20) CONSTRAINT  table_name_pk_col1 primary key,
    col2 varchar2(20) not null,
    col3 varchar2(20)
);

create table table_name2(
    col1 varchar2(20),
    col2 varchar2(20) not null,
    col3 varchar2(20),
    primary key(col1)
);

create table table_name3(
    col1 varchar2(20),
    col2 varchar2(20) not null,
    col3 varchar2(20),
    CONSTRAINT  table_name3_pk_col1 primary key(col1)
);
drop table table_name;
drop table table_name2;
drop table table_name3;

-----�ܷ�Ű
-- dept_fk(�μ���ȣ, �μ��� , ����)
create table dept_fk(
    deptno number(2) constraint deptfk_depntno_pk primary  key,
    dname varchar2(20),
    loc varchar2(20)
);
--emp_fk(�����ȣ, �����, ��å, �μ���ȣ)
create table emp_fk(
    empno number(2) constraint empfk_empno_pk primary key,
    ename varchar2(20),
    job varchar2(20),
    deptno number(2)
);
insert into dept_fk values(10,'����','�λ�');
insert into dept_fk values(20,'IT','����');
insert into emp_fk values(1, 'ȫ�浿', '���', 30);
commit;
select * from dept_fk;
select * from emp_fk;
drop table emp_fk;
create table emp_fk(
    empno number(2) constraint empfk_empno_pk primary key,
    ename varchar2(20),
    job varchar2(20),
    deptno number(2) constraint empfk_deptno_fk 
    references dept_fk(deptno)
);
-- �����߻� dept_fk ���̺� 30�� �μ��� ���µ� 30�� �μ� �߰��Ϸ��� �ؼ� ����
insert into emp_fk values(1, 'ȫ�浿', '���', 30);
insert into emp_fk values(1, 'ȫ�浿', '���', 20);
insert into emp_fk(empno, ename, job) values(2, '������', '����');
commit;
select * from emp_fk;
delete from emp_fk where empno=1;
insert into emp_fk values(1, 'ȫ�浿', '���', 20);
commit;

select * from dept_fk;
-- �����߻� 
delete from dept_fk where deptno=20;
-- �����߻� 
update emp_fk set deptno =30 where empno =1;
-- �ܷ�Ű ���������� ����
alter table emp_fk
drop CONSTRAINT empfk_deptno_fk;
-- �ܷ�Ű ������  insert ����
insert into emp_fk values(3, '������', '����', 40);
select * from emp_fk;
delete from emp_fk where empno=3;
commit;
--������ �ܷ�Ű �߰�
alter table emp_fk
add  CONSTRAINT empfk_deptno_fk FOREIGN KEY(deptno)
REFERENCES dept_fk(deptno)
on delete cascade;

delete from dept_fk where deptno=20;
select * from dept_fk;
select * from emp_fk;

create table table_check(
    login_id varchar2(20) CONSTRAINT tb_check_id_pk primary key,
    login_pwd varchar(20)
    CONSTRAINT tb_check_pwd_ch check (length(login_pwd) > 3),
    tel varchar2(20)
);
-- �����߻� (üũ ��������(SCOTT.TB_CHECK_PWD_CH)�� ����)
insert into table_check values('aaa','123','010');
--��������
insert into table_check values('aaa','12345','010');
commit;
select * from table_check;

-- board(num, title, userid, content, regdate) : �⺻Ű(num)
-- comments(cnum,userid, msg, regdate, bnum ): �⺻Ű(cnum) �ܷ�Ű(bnum)
-- member(userid,username, tel) �⺻Ű(userid)

-- ������ board_seq  / comment_seq

drop table board;
drop table member;
drop table comments;

create table member(
    userid number(3) CONSTRAINT pk_member1 primary key,
    username varchar2(30),
    tel varchar2(20)
);

create table board(
    num number(3) CONSTRAINT  pk_board1 primary key,
    title varchar2(30),
    userid number(3) CONSTRAINT fk_board1 
    references member(userid)
    on delete cascade,
    content varchar2(100),
    regdate date default sysdate
);
create sequence board_seq
Increment by 1
start with 1
minvalue 1
nocycle
nocache;

create sequence comment_seq
Increment by 1
start with 1
minvalue 1
nocycle
nocache;

create table comments(
    cnum number(3) CONSTRAINT  pk_comments primary key,
    userid number(3) CONSTRAINT fk_comments 
    references member(userid)
    on delete cascade,
    msg varchar2(100),
    regdate date default sysdate,
    bnum number(3) references  board(num)
    on delete cascade
 );

















