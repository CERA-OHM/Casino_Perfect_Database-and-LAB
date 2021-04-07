--L0801
create table emp2 as select * from employees;

create or replace procedure upcom_emp is
begin
  update emp2
  set salary = salary * 1.2
  where commission_pct is null;
  end;
/
set severoutput on
exec upcom_emp;

--L0802
create table emp3 as
select employee_id, first_name, phone_number, hire_date
from employees
where 1=0;

create or replace procedure ins_empd80 is
n_id employees.employee_id%type;
n_fn employees.first_name%type;
n_pn employees.phone_number%type;
n_hd employees.hire_date%type;
cursor cu is 
select employee_id, first_name, phone_number, hire_date 
from employees e
where e.department_id = 80;
begin
open cu;
  loop
        fetch cu into n_id, n_fn, n_pn, n_hd;
        exit when cu%notfound;
        insert into emp3 (employee_id, first_name, phone_number, hire_date)
        values (n_id, n_fn, n_pn, n_hd);
  end loop;
close cu;
end;
/
set severoutput on
exec ins_empd80;

--L0803
create or replace procedure loop_emp(emp_id in number) is
 cursor sh_emp is 
 select employee_id,first_name,last_name
 from employees
 where employee_id between emp_id and emp_id + 9;
 
 begin
  for emp_info in sh_emp
  loop
  dbms_output.put_line(emp_info.employee_id|| ' '|| emp_info.first_name||' '||
                      emp_info.last_name);
  end loop;
 end;
 /
 
 set severoutput on
 exec loop_emp(106);
 
 --L0804
 create or replace procedure loop_emp2(emp_id_in in number, row_num in number) is
  lcount number(10):= 1;
  emp_id employees.employee_id%type;
  emp_fn employees.first_name%type;
  emp_ln employees.last_name%type;
  cursor sh_emp is 
  select employee_id,first_name,last_name
  from employees
  where employee_id between emp_id_in and emp_id_in + row_num;
 
 begin
 open sh_emp;
  while lcount<= row_num loop
  fetch sh_emp into emp_id, emp_fn, emp_ln;
  dbms_output.put_line(emp_id|| ' '|| emp_fn||' '|| emp_ln);
  lcount := lcount+1;
  end loop;
 close sh_emp;
 end;
 /
 set severoutput on
 exec loop_emp2(106,15);
 
  --L0805
 drop procedure upcom_emp;
 drop procedure ins_empd80;
 drop procedure loop_emp;
 drop procedure loop_emp2;