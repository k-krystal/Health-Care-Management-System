
create table patient(
	p_id number(10)   ,
	first_name varchar(30) NOT NULL,
	last_name varchar(30) NOT NULL,
	house_no varchar(10),
	street varchar(20),
	city varchar(15),
	sex char(1),
	constraint patientPK primary key(p_id)
	
	
	);
create table p_phone(
  	p_id number(10) ,
  	phone_no number(10),
  	constraint patientFK foreign key(p_id) references patient(p_id)
  	ON DELETE CASCADE

);
create sequence p_sequence
	start with 1;
	--increment by 1

create or replace trigger p_trigger
before insert on patient
for each row
begin
:new.p_id:=p_sequence.NEXTVAL;
end;

create table doctor(
	d_id number(10)   ,
	first_name varchar(30) NOT NULL,
	last_name varchar(30) NOT NULL,
	house_no varchar(10),
	street varchar(20),
	constraint doctorPK primary key(d_id)
	);

create table d_phone(
  	d_id number(10) ,
  	phone_no number(10),
  	constraint doctorFK foreign key(d_id) references doctor(d_id)
  	ON DELETE CASCADE

);

create table d_speciality(
  	d_id number(10) ,
  	speciality varchar(20),
  	constraint doctorFK1 foreign key(d_id) references doctor(d_id)
  	ON DELETE CASCADE

);

create sequence d_sequence
	start with 1;
	--increment by 1

create or replace trigger d_trigger
before insert on doctor
for each row
begin
:new.d_id:=d_sequence.NEXTVAL;
end;

create table appointment(
	p_id number(10),
	d_id number(10), 
	appointment date,
	constraint doctorAppointFK foreign key(d_id) references doctor(d_id)
  	ON DELETE CASCADE,
  	constraint patientAppointFK foreign key(p_id) references patient(p_id)
  	ON DELETE CASCADE
	);

create table treatment(
	t_id number(10) primary key,
	type varchar(20),
	cost number(20),
	description varchar(100)
	);

create table follows( 
	d_id number(10),
	t_id number(10),
	constraint treatementFK foreign key(t_id) references treatment(t_id)
  	ON DELETE CASCADE,
  	constraint doctortreatmentFK foreign key(d_id) references doctor(d_id)
  	ON DELETE CASCADE
	);
create table undergoes( 
	p_id number(10),
	t_id number(10),
	constraint treatementFK1 foreign key(t_id) references treatment(t_id)
  	ON DELETE CASCADE,
  	constraint patienttreatmentFK foreign key(p_id) references patient(p_id)
  	ON DELETE CASCADE
	);

create table lab(
	l_no number(10)   ,
	lab_name varchar(30) NOT NULL,
	constraint labPK primary key(l_no),
	constraint labFK foreign key(l_no) references patient(p_id)
  	ON DELETE CASCADE
	);

create table employee(
	e_id number(10)   ,
	e_name varchar(30) NOT NULL,
	house_no varchar(10),
	street varchar(20),
	city varchar(10),
	working_hrs float(4),
	constraint employeePK primary key(e_id)
	);
alter table doctor add city varchar(10);

create table e_phone(
  	e_id number(10) ,
  	phone_no number(10),
  	constraint empFK foreign key(e_id) references employee(e_id)
  	ON DELETE CASCADE

);

create table nurse(
	e_id number(10) PRIMARY KEY,
  	n_speciality varchar(10),
  	constraint nurseFK foreign key(e_id) references employee(e_id)
  	ON DELETE CASCADE 

);

CREATE DOMAIN s_domain varchar CHECK (VALUE == 'D' OR VALUE =='N');

create table receptionist(
	e_id number(10) PRIMARY KEY  ,
	r_qualification varchar(10),
	shift varchar(1) not null,
	constraint rFK foreign key(e_id) references employee(e_id)
  	ON DELETE CASCADE,
    constraint shiftFK foreign key(shift) references s_domain(shift)
	);

create table s_domain(
	shift varchar(1) primary key
);

create table bills(
	e_id number(10),
b_no number(10) PRIMARY KEY,
b_date date,
constraint bFK foreign key(e_id) references employee(e_id)
  	ON DELETE CASCADE,
);
alter table bills add b_amount number(38);
create sequence b_sequence
	start with 1;
	--increment by 1

create or replace trigger b_trigger
before insert on bills
for each row
begin
:new.b_no:=b_sequence.NEXTVAL;
end;

CREATE OR REPLACE PROCEDURE PATIENT_PROC
(
	first_name IN  varchar2 ,
	last_name  IN varchar2 ,
	house_no IN varchar2,
	street IN varchar2,
	city IN varchar2,
	sex IN char
	)
as

begin

INSERT INTO Patient ( first_name,
last_name,
house_no,
street,
city,
sex 
) VALUES (first_name,
last_name,
house_no ,
street,
city,
sex);
end;








