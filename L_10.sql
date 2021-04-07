--L1001
create table emp_bk as select* from employees;
create table job_bk as select* from employees;
create table dml_log(user_l varchar2(50), dml_l varchar2(20), date_l date);

create or replace trigger a_dml
after insert or update or delete on emp_bk
begin
  if inserting then
    insert into dml_log values(user, 'insert', sysdate);
  elsif updating then
    insert into dml_log values(user, 'update', sysdate);
  else insert into dml_log values(user, 'delete', sysdate);
  end if;
end;
/
delete from emp_bk where employee_id = 100;
rollback;

--L1002
create or replace trigger d_dmp
before delete on emp_bk
  for each row
begin
  dbms_output.put_line(user || ' ' || 'delete' || ' ' || :old.employee_id || ' ' || 
  :old.first_name || ' ' || :old.last_name);
end;
/
delete from emp_bk where department_id = 100;
rollback;

--L1003
create or replace trigger u_job_bk
after update of job_id on job_bk
  for each row
begin
  update emp_bk set job_id = :new.job_id
  where job_id = :old.job_id;
end;
/

update job_bk set job_id  = 'SL_REPRE' where job_id = 'AD_VP';
rollback;