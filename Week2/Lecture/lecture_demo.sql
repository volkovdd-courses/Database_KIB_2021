-- Before lecture 
DROP TABLE students_f;





-- CREATE TABLE 

CREATE TABLE Students_f( 
    id integer   primary key , 
    name varchar(30) not null, 
    faculty varchar(30),
    city varchar(30),
    gpa decimal(10, 2),
    unique (name) 
);


-- DML 
INSERT INTO students_f(id, name, faculty, city, gpa)
    VALUES (1, 'Ivanov', 'KIB', 'Moscow', 3.0);

INSERT INTO students_f(id, name, faculty, city, gpa)
    VALUES (2, 'Petrov', 'KIB', 'Moscow', 4.5),
           (3, 'Fetisov', 'IT', 'Warsaw', 5.0),
           (4, 'Smith', 'KIB', 'Samara', 4.0);

INSERT INTO students_f
    VALUES (5, 'Alex', 'Economics', 'New York', 4.1);

INSERT INTO students_f(name, faculty, city, id, gpa)
    VALUES ('Jackson', 'IT', 'Moscow', 6, 5.0);

INSERT INTO students_f(id, name)
    VALUES (7, 'Willson');

INSERT INTO students_f
    VALUES (8, 'Lee');



INSERT INTO students_f(id, faculty)
    VALUES (9, 'KIB');

INSERT INTO students_f(id, name, faculty, city)
    VALUES (7, 'Peterson', 'KIB', 'Moscow');

INSERT INTO students_f(id, name, faculty, city)
    VALUES (9, 'Ivanov', 'KIB', 'Moscow');


--SQL 

SELECT * 
  FROM Students_f
 WHERE faculty = 'KIB';


SELECT * 
  FROM Students_f
 WHERE faculty in ('KIB', 'IT');

SELECT name, faculty
  FROM Students_f
 WHERE faculty in ('KIB', 'IT');


SELECT name, name || '->' || faculty
  FROM Students_f
 WHERE faculty in ('KIB', 'IT');

SELECT name, concat(name, '->', faculty)
  FROM Students_f
 WHERE faculty in ('KIB', 'IT');

SELECT name, concat(name, '->', faculty)
  FROM Students_f
 WHERE faculty in ('KIB', 'IT');

SELECT name, gpa, pow(2, gpa)
  FROM Students_f
 WHERE faculty in ('KIB', 'IT');

-- null
SELECT name, gpa
  FROM Students_f
 WHERE gpa = null;


-- AND, OR, NOT 
SELECT name, gpa
  FROM Students_f
 WHERE faculty in ('KIB', 'IT') 
   AND name = 'Ivanov';

SELECT name, gpa
  FROM Students_f
 WHERE faculty in ('KIB', 'IT') 
    OR name = 'Lee';

SELECT name, gpa, faculty
  FROM Students_f
 WHERE not (faculty in ('KIB', 'IT'))
    OR name = 'Ivanov';

SELECT name, gpa, faculty
  FROM Students_f
 WHERE not (faculty in ('KIB', 'IT')) or faculty is null
    OR name = 'Ivanov';

SELECT name, gpa, faculty
  FROM Students_f
 WHERE not (coalesce(faculty, 'A') in ('KIB', 'IT'))
    OR name = 'Ivanov';

SELECT faculty
  FROM Students_f;

-- distinct 
SELECT distinct 
       faculty
  FROM Students_f;

SELECT distinct 
       faculty,
       city
  FROM Students_f;

-- like 
SELECT name, gpa, faculty
  FROM Students_f
 WHERE name like 'I%';

SELECT name, gpa, faculty
  FROM Students_f
 WHERE name like '%ov%';

SELECT name, gpa, faculty
  FROM Students_f
 WHERE name like 'ov%';

SELECT name, gpa, faculty
  FROM Students_f
 WHERE name like 'L_e';

-- Aggregations 

SELECT max(gpa), min(gpa), avg(gpa), sum(gpa)
  FROM Students_f

SELECT count(*), count(gpa), count(distinct gpa)
  FROM Students_f

SELECT faculty, 
       count(id),
       avg(gpa)
  FROM Students_f
 group by faculty

SELECT faculty, 
       count(id),
       avg(gpa)
  FROM Students_f
 group by faculty
having count(*) > 1

-- Показать специфику работы с null



== Соединения таблиц 

DROP TABLE IF EXISTS students;
DROP TABLE IF EXISTS cities;
DROP TABLE IF EXISTS faculties;

CREATE TABLE cities(
    id integer primary key, 
    name varchar(255) not null,
    country_name varchar(255) not null    
);



CREATE TABLE faculties(
    id integer primary key, 
    name varchar(255) not null,
    city_id integer not null, 
    foreign key (city_id) references cities(id)
);


CREATE TABLE students(
    id integer primary key, 
    name varchar(255) not null,
    city_id integer not null, 
    faculty_id integer not null,
    foreign key (city_id) references cities(id),
    foreign key (faculty_id) references faculties(id)
);