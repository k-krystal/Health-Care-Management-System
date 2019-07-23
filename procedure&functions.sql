-- patient procedure inserrt values into patient table
CREATE OR REPLACE PROCEDURE PATIENT_PROC
(
	p out number,
	first_name IN  varchar2 ,
	last_name  IN varchar2 ,
	house_no IN varchar2,
	street IN varchar2,
	city IN varchar2,
	sex IN char,
	age in number
	)
as

begin

INSERT INTO Patient ( first_name,
last_name,
house_no,
street,
city,
sex,
age
) VALUES (first_name,
last_name,
house_no ,
street,
city,
sex,
age);
select p_sequence.currval into p from dual;
end;






--this procedure is basically to find interaction among the corresponding patient and receptionist

create or replace procedure entries
(
receptionist_id in number,
patient_id in number
)   
as

begin

insert into interacts_with(
r_id,
p_id) values (receptionist_id,patient_id);

end;




-- this procedure deletes the appointments for the patient who have been diagones/treated 
--or who did not come in another few hours corresponding to given time.
                
create or replace procedure appointment_delete(
	patient_id in number,
	doctor_id in number

)
as 
begin
delete from appointment where p_id=patient_id and d_id=patient_id;

end;  


--this sets appointment for the patients
create or replace procedure set_appointment(p_id in patient.p_id%type, d_id in doctor.d_id%type, timing in varchar2)
	is
	 todatDate varchar2(20);
	begin
	Select (sysdate||' '||timing||':00') into todatDate  from dual ;	
	insert into appointment values(p_id,d_id,todatDate);
end;


-- It is a functions which returns the number of appointments deleted in order to keep a record

CREATE OR REPLACE FUNCTION deleted_appointments
RETURN NUMBER
IS
r number(10);

BEGIN
delete from  appointment; 
r:=sql%rowcount;

return r;

END;


--this function returns the doctor id corresponding to the specialization
CREATE OR REPLACE FUNCTION accessability(type IN Varchar2) 
   RETURN NUMBER 
IS
   d number(10);
   count_d number(10); 
printname EXCEPTION;
   BEGIN 
   select count(d_id) into count_d from d_specialization where type=speciality;
   if count_d=0 then
   raise printname;
end if;
      SELECT d_id 
      INTO d 
      FROM d_specialization x
      WHERE type = x.speciality and rownum<=1; 
       return d;
    
EXCEPTION 
when printname then
raise_application_error(-20003,'Doctor not available');
END;



--sql statement to call doctor speicalization
declare
disease varchar2(20):=:specialization;
d1 number(10);



begin

select d_id into d1 from d_specialization x where disease=x.speciality;
dbms_output.put_line(d1);

end;



--sql statemtent to call deleted appointments procedure
declare
output number(10); 
begin                 

output:=deleted_appointments;
dbms_output.put_line(output);
end;