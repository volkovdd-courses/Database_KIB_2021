-- Для всех треков жанра Rock и Metal, для каждого артиста подсчитать количество треков.
-- Вывести имя артиста, количество треков. (artist_name, qty)

SELECT artist.name as artist_name,
       count(*) as qty
FROM track as t
    JOIN genre USING(genre_id)
    JOIN album USING(album_id)
    JOIN artist USING(artist_id)
WHERE genre.name in ('Rock', 'Metal')
GROUP BY artist.artist_id;