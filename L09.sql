--L0901
create table emp_bk as select * from employees;
create table job_bk as select * from jobs;

create or replace package edit_emp is
procedure insert_emp(i_emp_id emp_bk.employee_id %type,
    i_email emp_bk.email %type,
    i_phone emp_bk.phone_number %type,
    i_hire_date emp_bk.hire_date %type,
    i_job_id emp_bk.job_id %type,
    i_salary emp_bk.salary %type,
    i_lastname emp_bk.last_name %type);
procedure update_emp(u_emp_id emp_bk.employee_id %type,
    u_email emp_bk.email %type,
    u_phone emp_bk.phone_number %type,
    u_hire_date emp_bk.hire_date %type,
    u_job_id emp_bk.job_id %type,
    u_salary emp_bk.salary %type,
    u_lastname emp_bk.last_name %type);
procedure delete_emp(emp_idtd in number);
end;
/
create or replace package body edit_emp is

  procedure insert_emp(
    i_emp_id emp_bk.employee_id %type,
    i_email emp_bk.email %type,
    i_phone emp_bk.phone_number %type,
    i_hire_date emp_bk.hire_date %type,
    i_job_id emp_bk.job_id %type,
    i_salary emp_bk.salary %type,
    i_lastname emp_bk.last_name %type) is
  begin
    insert into emp_bk(employee_id, email, phone_number, hire_date, job_id, salary, last_name)
    values (i_emp_id, i_email, i_phone, i_hire_date, i_job_id, i_salary, i_lastname);
  end;

  procedure update_emp(u_emp_id emp_bk.employee_id %type,
    u_email emp_bk.email %type,
    u_phone emp_bk.phone_number %type,
    u_hire_date emp_bk.hire_date %type,
    u_job_id emp_bk.job_id %type,
    u_salary emp_bk.salary %type,
    u_lastname emp_bk.last_name %type) is
  begin
    update emp_bk set email = u_email, phone_number = u_phone, hire_date = u_hire_date,
    job_id = u_job_id, salary = u_salary, last_name = u_lastname
    where employee_id = u_emp_id;
  end;

procedure delete_emp(emp_idtd in number) is
  begin
    delete from emp_bk
    where employee_id = emp_idtd;
  end;
end;
/

exec edit_emp.insert_emp(999, 'BEE', '123.456.7890', '01-JUN-99', 'PU_MAN', 10000, 'OHM');
select * from emp_bk where employee_id = 999;

exec edit_emp.update_emp(999, 'BEE', '123.456.7890', '01-JUN-99', 'PU_MAN', 10000, 'OHM');
select * from emp_bk where employee_id = 999;

exec edit_emp.delete_emp(999);
select * from emp_bk where employee_id = 999;

--L0902
create or replace package L0708 is
  procedure ins_empd80;
  procedure loop_emp(emp_id employees.employee_id%type);
  procedure loop_emp2 ( 
   emp_id employees.employee_id%type,
   num_row in number );
end;
/
create or replace package body L0708 is
  procedure ins_empd80 is 
   eid employees.employee_id%type;
   fname employees.first_name%type;
   phone employees.phone_number%type;   
   hdate employees.hire_date%type;   
   cursor cs is    
      select employee_id, first_name, phone_number, hire_date      
      from employees where department_id = 80;
  begin
   open cs;   
   loop
      fetch cs into eid, fname, phone, hdate;      
      exit when cs%notfound;      
      insert into emp3 values (eid, fname, phone, hdate);      
   end loop;
  end;
  procedure loop_emp(emp_id in employees.employee_id%type) is
   cursor cs is  
      select employee_id, first_name, last_name      
      from employees       
      where employee_id >= emp_id     
      order by employee_id;
  begin
   for emp_info in cs loop   
      dbms_output.put_line(      
         emp_info.employee_id || ' '          
         || emp_info.first_name || ' '         
         || emp_info.last_name );         
   exit when cs%rowcount = 10;   
   end loop;
  end;
  procedure loop_emp2 (   
   emp_id in employees.employee_id%type,
   num_row in number )
  is 
   eid employees.employee_id%type;   
   fname employees.first_name%type;
   lname employees.last_name%type;   
   cursor cs is    
      select employee_id, first_name, last_name     
      from employees       
      where employee_id >= emp_id     
      order by employee_id;
  begin
   open cs;   
   while cs%rowcount < num_row loop   
      fetch cs into eid, fname, lname;      
      dbms_output.put_line(eid || ' ' || fname || ' ' || lname);      
   end loop;
  end;
end;
/

set severoutput on
exec L0708.ins_empd80;
select * from emp3;
exec L0708.loop_emp(106);
exec L0708.loop_emp2(106, 15);
/

--L0903
create table ddl_info (
  user_name varchar(30) not null,
  ddl_info varchar(100) not null,
  date_edit date);
create or replace trigger create_trig
after create on database
begin
insert into ddl_info
values (user, 'CREATE', sysdate);
end;
/
create or replace trigger alter_trig
after create on database
begin
insert into ddl_info
values (user, 'alter', sysdate);
end;
/
create or replace trigger drop_trig
after create on database
begin
insert into ddl_info
values (user, 'DROP', sysdate);
end;
/