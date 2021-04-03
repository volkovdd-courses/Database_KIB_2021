-- Для каждого набора жанр, тип медиа вывести количество треков.
-- Если для набора жанр, тип медиа треков нет, то такой набор выводить не требуется. (genre_name, media_type_name, cnt)

SELECT g.name as genre_name,
       mt.name as media_type_name,
       count(t)
FROM track t
    JOIN genre g USING (genre_id)
    JOIN media_type mt USING (media_type_id)
GROUP BY g.genre_id, mt.media_type_id;
