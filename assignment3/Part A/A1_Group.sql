-- 1 Query: Count the number of albums released by each artist.--
SELECT ar.name AS artist_name, COUNT(al.album_id) AS total_albums
FROM Artist ar LEFT JOIN Album al ON ar.artist_id = al.artist_id
GROUP BY ar.name ORDER BY total_albums DESC;

-- 2 Query: Count users by country and subscription type.
SELECT ar.country, u.subscription_type, COUNT(u.user_id) AS user_count
FROM "User" u
         CROSS JOIN (SELECT DISTINCT country FROM Artist) ar
GROUP BY ar.country, u.subscription_type
ORDER BY ar.country, u.subscription_type;

-- Query 3: Find meaningful playlists (containing more than 3 tracks)
SELECT
    p.name AS playlist_name,
    COUNT(pt.track_id) AS track_count
FROM Playlist p
         JOIN Playlist_Track pt ON p.playlist_id = pt.playlist_id
GROUP BY p.name
HAVING COUNT(pt.track_id) > 3;

-- Query 4: Total tracks distributed by Artist Country and Album Year
SELECT
    COALESCE(ar.country, 'ALL COUNTRIES (Grand Total)') AS artist_country,
    COALESCE(CAST(EXTRACT(YEAR FROM al.release_date) AS VARCHAR), 'ALL YEARS (Subtotal)') AS release_year,
    COUNT(s.track_id) AS total_tracks
FROM Artist ar
         JOIN Album al ON ar.artist_id = al.artist_id
         JOIN Soundtrack s ON al.album_id = s.album_id
GROUP BY ROLLUP (ar.country, EXTRACT(YEAR FROM al.release_date))
ORDER BY ar.country, release_year;

