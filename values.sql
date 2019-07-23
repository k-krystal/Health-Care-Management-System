--values 


insert into doctor( d_id,
first_name ,
last_name,
house_no,
street ,city ) values('5','Rakejhsh','Singh','72/4','Ajesh Nagar','Jalandhar');


select * from doctor;

update doctor SET street='Suranj Colony' where d_id=6;





select * from d_specialization;
select * from d_specialization where d_id=4;
insert into d_specialization values ('6','Pediatrician');
insert into d_specialization values(1,'Allergist');
insert into d_specialization values(1,'Anesthesiologist');
insert into d_specialization values(2,'Cardiologist');
insert into d_specialization values(2,'Cardiologist');
insert into d_specialization values(3,'Oncologit');
insert into d_specialization values(3,'Nephrologist');
insert into d_specialization values(3,'Gastroenterologist');
insert into d_specialization values(6,'Urologist');



select p_sequence.nextval from dual;

alter sequence p_sequence 
increment by 1;


insert into employee
 values('2','Harman Singh','367','Shastri Nagar','Jalandhar','8');


insert into employee
 values('1','Raman Singh','727','Ajesh Nagar','Jalandhar','8');

select * from s_domain;
insert into s_domain values('N');
insert into receptionist
 values(2,'B.Ed','N');

 insert into treatment values(2,'Eye Treatment',10000,'Laser Treatment ');
















