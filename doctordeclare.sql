


-- statement to tell the visit history of patient provided his/her id
-- for doctor
-----------------------------
declare 
doc_id number:=:yours_id;
patient_id number:=:patient_id;
Today date;
diag varchar2(100):=:diagonosis;
t_id number:= :treatment_id;
isMust Exception;
begin
if doc_id is null or patient_id is null
then raise isMust;
end if;
appointment_delete(patient_id,doc_id);
insert into follows values(doc_id,t_id);
insert into undergoes values(patient_id,t_id); 
select sysdate into today from dual;
insert into visithistory(visit_date,p_id,d_id,diagonosis) values(today,patient_id,doc_id,diag);
Exception 
when  isMust then
raise_application_error(-20005,'id must');
end