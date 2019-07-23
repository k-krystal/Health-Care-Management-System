
--(declare statement(same))

declare
	first_name varchar(30);
	last_name varchar(30);
	house_no varchar(10);
	street varchar(20);
	city varchar(15);
	sex char(1);
	age number(3);
	p number(10) := :patient_id;
	name varchar2(20);
	count1 number(1);
	doctor_id number(20);
	speciality varchar2(20):= :speciality;
	timing varchar2(20):=:appointment_time;
	doctor_name varchar2(20);
	name_null Exception;
	user_not_found Exception;
	missing_timing Exception;
begin
if timing is null 
then 
	raise missing_timing;
end if;
if p is null
then
	first_name:= :First_name;
	last_name:= :last_name;
	house_no:= :house_no;
	street:=:Street;
	city:= :City;
	sex:= :Sex_M_or_F;
	age := :Age;
	if first_name is null or last_name is null
	then
		raise name_null;
	end if;
	PATIENT_PROC(p,first_name,last_name,house_no,street,city,sex,age);
else

select count(*) into count1  from patient where p_id=p;

if count1=1
then
select first_name||' '||last_name into name from patient where p_id=p;
dbms_output.put_line(name); 
else
raise user_not_found;
end if;
end if;
doctor_id:=accessability(speciality);
set_appointment(p,doctor_id,timing);
select first_name||' '||last_name into doctor_name
from doctor
where doctor_id=d_id;
dbms_output.put_line(name||', with id: '||p||' ,gets appointment at '||timing||' for Dr. '||doctor_name);
EXCEPTION
when  name_null then
raise_application_error(-20001,'first_name is null');
when user_not_found then
raise_application_error(-20002,'Patient not found');
when missing_timing then
raise_application_error(-20004,'appointment timing is not mentioned');
end;




--------------------cursor-----------------------------(to be corrected)
 CREATE OR REPLACE FUNCTION accessability(type IN Varchar2) 
   RETURN NUMBER 
IS

d number(10);
    
printname EXCEPTION;
CURSOR c1 
is 
 SELECT d_id 
      FROM d_specialization x
      WHERE type = x.speciality ; 

   BEGIN 
     OPEN c1;
   LOOP 

FETCH c1 into d;


EXIT WHEN c1%NOTFOUND;

END LOOP;
CLOSE c1;
 
   if d is not null then           
  RETURN d; 
  
else


raise printname;
RETURN 0;    
 

end if;        
EXCEPTION 
when printname then
raise_application_error(-20003,'Doctor not available');
END;




