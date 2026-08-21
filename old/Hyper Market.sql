create database Market_system;
use Market_system;
--------------------------------------
create table  adminn
(
	admin_id int primary key ,
	admin_name varchar(50), 
	admin_pass int not null,
	admin_userName varchar(50) unique
);
----------------------------------------
create table  marketing_emp
(
	m_id int primary key,
	m_name varchar(50), 
	m_pass int not null,
	m_userName varchar(50) unique
);
-----------------------------------------
create table  inventory_emp
(
	i_id int primary key ,
	i_name varchar(50), 
	i_pass int not null,
	i_userName varchar(50) unique,
	i_massege varchar(200) default 'hello'
);
------------------------------------------
create table  seller_emp
(
	s_id int primary key ,
	s_name varchar(50), 
	s_pass int not null,
	s_userName varchar(50) unique
);
------------------------------------------
create table   product
(
	p_id int primary key ,
	p_name varchar(50), 
	p_amount int ,
	p_range int,
	--start_date date,
	cur_date date,
	expiry_date date
);
-----------------------------------------
create table set_offers
(
	mark_id int foreign key references  marketing_emp(m_id)on delete cascade on update cascade,
	pro_id int foreign key references product(p_id)on delete cascade on update cascade,
	inv_id int foreign key references  inventory_emp(i_id)on delete cascade on update cascade,
	offer int,
	--start_date date,
	cur_date date,
	end_date date,
);
------------------------------------------
