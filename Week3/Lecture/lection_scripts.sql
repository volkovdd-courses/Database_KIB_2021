- Джоины LEFT, RIGHT, FULL (+)
- Подзапросы (+)
- Операция со множествами (+)
- WITH (Common Table Expression) (+)
- Ограничения целостности (foreign key, not null)
- DDL, DML


select *
  from a1, a2;

SELECT t.album_id, count(*)
  FROM genre g
  JOIN track t
    on g.genre_id = t.genre_id
 where g.genre_id = 1
 group by t.album_id;


create table boys(name varchar(30), city varchar(30));
create table girls(name varchar(30), city varchar(30));

insert into boys
    values ('John', 'Moscow'), ('Jack', 'Moscow'),
           ('Simon', 'London'), ('Nikita', 'New-York');


insert into girls
    values ('Ann', 'Moscow'), ('July', 'Moscow'),
           ('Kate', 'London'), ('Serena', 'Boston');

select *
  from boys
 inner
  join girls g
    on boys.city = gcity;

select *
  from boys
  left
  join girls g
    on boys.city = g.city;


select *
  from boys
  right
  join girls g
    on boys.city = g.city;

select *
  from boys
  full
  join girls g
    on boys.city = g.city;

create table a(a int);
create table b(b int);
insert into a values (1), (1),(1),(1),(1);
insert into b values (1), (1),(1),(1);
Какое возможное минимальное и максимальное значения
будут в следующих запросах?
a) select count(*) -- a (1, 2, 3, 4, 5)
     from a   -- b (1, 2, 3, 4)
     join b on a.a = b.b
b) select count(*)
     from a
     left join b on a.a = b.b
c) select count(*)
     from a
     right join b on a.a = b.b
d) select count(*)
     from a
     full join b on a.a = b.b;



create table students(name text, faculty_id int);
create table faculties(id int, name text);
insert into faculties values (1, 'IT'), (2, 'KIB');
insert into students values ('ivanov', 1),  ('ivanov', 2),
                            ('petrov', 2), ('sidorov', null);
select s.name as s_name, f.name as f_name
  from students s
  left
  join faculties f
    on s.faculty_id = f.id
 where f.name = 'KIB';

select s.name as s_name, f.name as f_name
  from students s
  left
  join faculties f
    on s.faculty_id = f.id
   and f.name = 'KIB';


SELECT *
  FROM track
  JOIN genre g
    on track.genre_id = g.genre_id
 WHERE g.name = 'Rock';

SELECT *
  FROM track
 WHERE genre_id = (select genre.genre_id FROM genre where name = 'Rock');

>, =, !=, >, >=, <= -- скалярный
in

SELECT *
  FROM track
 WHERE genre_id in  (select genre.genre_id FROM genre where name like '%ROCK');

select *
  from track
 where genre_id in (select genre.genre_id
                      FROM genre
                     where name in ('Jazz', 'Rock') )
   and media_type_id in (select media_type.media_type_id
                           from media_type
                           where media_type.name in ('MPEG audio file',
                                                     'Protected AAC audio file') )
SELECT t.*
  FROM track t
  JOIN genre g
    on t.genre_id = g.genre_id
  JOIN media_type mt
    on t.media_type_id = mt.media_type_id
 WHERE (g.name, mt.name) in (('Jazz', 'MPEG audio file'),
                             ('Rock', 'Protected AAC audio file'));


select *
  from genre
  join track t on genre.genre_id = t.genre_id;

select *
  from track;


EXISTS - выдает true, если в подзапросе вернулась хотя бы одна строка и
false, если 0 строк

select *
  from track;

-- Вывести все треки с немаксимальным количеством миллисекунд в рамках жанра.

SELECT *
  FROM track
WHERE (genre_id, milliseconds) not in (
        SELECT genre_id,
               max(milliseconds) as max_ms
          FROM track
         GROUP
            BY genre_id);

   SELECT t2.*
    FROM
        (
            SELECT genre_id,
                   max(milliseconds) as max_ms
            FROM track
            GROUP BY genre_id
        ) t1
    JOIN track t2
      ON t2.genre_id = t1.genre_id
   WHERE t2.milliseconds < t1.max_ms;
create view t11 as
 SELECT genre_id,
               max(milliseconds) as max_ms
   FROM track
  GROUP BY genre_id

    ;

select *
  from t11;
WITH  t1 as
(
 SELECT genre_id,
               max(milliseconds) as max_ms
   FROM track
  GROUP BY genre_id
),
t2 as
(
 SELECT genre_id,
               max(milliseconds) as max_ms
   FROM track
  GROUP BY genre_id
)
select *
  from t2;

-- Вывести все треки по каждому жанру превышающие средний размер
-- трека в рамках этого жанра


select *
  from track
 where milliseconds > (select avg(milliseconds) from track group by genre_id);

 -- 1 abc 1 100
  -- 2 abcd 1 50
-- 10 d  2 100
select *
  from track t1
  -- 1 abc 1 100
 where exists (
     select 1
       from (select t1.genre_id, avg(milliseconds) as avg_ms
               from track t2  -- (1 90), (2 100)
             group by genre_id) t2
      where t1.genre_id = t2.genre_id
        and t1.milliseconds > t2.avg_ms
           )


-- Вывести все треки по каждому типу медиа кроме наименьшего в рамках это типа
-- id  mt ms
-- 1   1  100
-- 2   1  200

select *
  from track t1
 where exists(
     select *
       from track t2
      where t1.media_type_id = t2.media_type_id
        and t1.milliseconds > t2.milliseconds
           )
-- t1: 1   1  100 +

-- t2: 1   1  100  -
-- --  2   1  200  -
-- --  3   1  50   +

-- t1: 2   1  200 +

-- t2: 1   1  100 +
-- --  2   1  200 -
-- --  3   1  50  +


-- t1: 3   1  50 -

-- t2: 1   1  100 -
-- --  2   1  200 -
-- --  3   1  50  -



select t.*, (select '1' as a )
  from track t;


-- Операция со (мульти)-множествами
A B
-- UNION
-- INTERSECT
-- EXCEPT


create table a1(a int, b text);

create table a2(c int, d text);

insert into a1 values
    (1, 'a'), (1, 'a'), (1, 'b'),
    (2, 'a'), (2, 'b'), (3, 'c');

insert into a1 values (1, 'a');


insert into a2 values
    (1, 'a'), (1, 'a'), (2, 'b'),
    (3, 'a'), (4, 'b'), (5, 'c');


select *
  from a1;
select *
  from a2;

select a, b
  from a1

except all

select c, d
  from a2;

симметрическая разница для a1, a2

select a, b
  from (
       select a, b
         from a1

        except

      select c, d
         from a2
        ) a
union
select c,d
    from
(
        select c, d
         from a2

        except

    select a, b
         from a1

        ) a;


select 1
union
select '1.5'


select '1.5'
union
select 1::text;

select '1.5'
union
select cast(1 as text);
-- 12 0
.
