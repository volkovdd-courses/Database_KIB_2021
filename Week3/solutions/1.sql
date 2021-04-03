-- Вывести все альбомы со средней длинной трека, большей 250 секунд.
-- Вывести название альбома и количество треков. (album_name, cnt).

SELECT al.title as "album_name",
       count(t.*) as "cnt"
FROM album as al
    JOIN track as t USING (album_id)
    group by al.album_id
HAVING avg(t.milliseconds) > 250000;

