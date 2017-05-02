CREATE TABLE Faculty (
    faculty_name VARCHAR(15) UNIQUE,
    faculty_number INTEGER UNIQUE,
	mngr_id VARCHAR(10),
	mngr_start_date DATE,
	PRIMARY KEY(faculty_name, faculty_number));
	
	
CREATE TABLE Faculty_loc(
faculty_name VARCHAR(15),
faculty_number INTEGER,
faculty_loc varchar(100),
PRIMARY key (faculty_number, faculty_loc),
FOREIGN KEY (faculty_name, faculty_number) REFERENCES Faculty (faculty_name, faculty_number));	
	
CREATE TABLE Course(
name VARCHAR(15),
course_id 	VARCHAR(10) UNIQUE,
faculty_name VARCHAR(15),
faculty_number INTEGER,    
PRIMARY KEY(course_id),
FOREIGN KEY (faculty_name, faculty_number) REFERENCES Faculty (faculty_name, faculty_number) );	

CREATE TABLE Professor (
first_name varchar(15), 
last_name varchar(20), 
prof_id varchar(10) not null , 
faculty_name VARCHAR(15) UNIQUE,
faculty_number INTEGER UNIQUE,
nationalcode varchar(12) UNIQUE not null, 
address varchar(100), 
telephone varchar(50), 
birth_date Date , 
sex varchar(6), 
salary decimal(10, 2),
PRIMARY key(prof_id), 
FOREIGN key (faculty_name, faculty_number) REFERENCES Faculty(faculty_name, faculty_number)	);

ALTER TABLE Faculty add FOREIGN KEY(mngr_id) REFERENCES Professor(prof_id) ON UPDATE CASCADE;

CREATE TABLE Student(
first_name varchar(15), 
last_name varchar(20), 
s_id varchar(10) UNIQUE not null,
faculty_name VARCHAR(15) UNIQUE,
faculty_number INTEGER UNIQUE,
entrance_year varchar(4) ,    
nationalcode varchar(12) UNIQUE not null, 
address varchar(100), 
telephone varchar(50), 
birth_date Date , 
sex varchar(6),
supervisor_id varchar(10),
project_id varchar(10), 
project_prof_id varchar(10), 
PRIMARY KEY(s_id), FOREIGN key (faculty_name, faculty_number) REFERENCES Faculty(faculty_name, faculty_number),
FOREIGN KEY (supervisor_id) REFERENCES Professor (prof_id)  ON DELETE SET NULL);

CREATE TABLE class(class_number varchar(3),
faculty_name VARCHAR(15),
faculty_number INTEGER ,
FOREIGN key (faculty_name, faculty_number) REFERENCES Faculty(faculty_name, faculty_number));

CREATE table Take_Course(
name varchar(15),    
grade decimal(2, 2),
prof_id varchar(10) not null,
s_id varchar(10), term varchar(3) not null, 
passed boolean default false , 
class_time Time, 
class_number VARCHAR(3) NOT NULL , 
teacherassistant_id varchar(10),
course_id varchar(10),
faculty_name VARCHAR(15),
faculty_number INTEGER ,
PRIMARY KEY(course_id, prof_id),    
FOREIGN KEY (prof_id) REFERENCES Professor (prof_id),
FOREIGN KEY (course_id) REFERENCES Course(course_id),
FOREIGN key (faculty_name, faculty_number) REFERENCES Faculty (faculty_name, faculty_number),
FOREIGN KEY (teacherassistant_id) REFERENCES Student(s_id)  ON DELETE SET NULL);

CREATE table Project(
name VARCHAR(20),
subject varchar (100),    
project_id varchar(10),    
prof_id varchar(10),
term varchar(3),    
faculty_name VARCHAR(15) UNIQUE,
faculty_number INTEGER UNIQUE,
PRIMARY KEY (project_id), 
FOREIGN key (faculty_name, faculty_number) REFERENCES Faculty(faculty_name, faculty_number) ,   
FOREIGN KEY (prof_id) REFERENCES Professor(prof_id)   
);

ALTER TABLE Student add FOREIGN KEY(project_id) REFERENCES Project(project_id)  ON DELETE SET NULL;

CREATE TABLE Prerequisite_Course(
name varchar(20),
pre_course_id varchar(10),
course_id varchar(10),
term varchar(3),
passed boolean DEFAULT false,    
PRIMARY KEY(pre_course_id),
FOREIGN key(course_id) REFERENCES Course(course_id), 
FOREIGN key(pre_course_id) REFERENCES Course(course_id));

