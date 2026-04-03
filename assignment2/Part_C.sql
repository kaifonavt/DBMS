-- Query 1: Get all tracks with their album titles
SELECT t.title AS track_name, a.title AS album_name
FROM Soundtrack t
         INNER JOIN Album a ON t.album_id = a.album_id;

-- Query 2: List all playlists and their owners
SELECT p.name AS playlist_name, u.username
FROM Playlist p
         INNER JOIN "User" u ON p.user_id = u.user_id;

-- Query 1: Show all users and their playlists (including users without playlists)
SELECT u.username, p.name AS playlist_name
FROM "User" u
         LEFT JOIN Playlist p ON u.user_id = p.user_id;

-- Query 2: List all artists and their albums
SELECT ar.name AS artist_name, al.title AS album_name
FROM Artist ar
         LEFT JOIN Album al ON ar.artist_id = al.artist_id;

-- Query 1: Show all tracks and their stats
SELECT t.title, s.play_count
FROM Soundtrack t
         RIGHT JOIN Track_Stats s ON t.track_id = s.track_id;

-- Query 2: List all albums and their artists
SELECT al.title, ar.name
FROM Album al
         RIGHT JOIN Artist ar ON al.artist_id = ar.artist_id;

-- Query 1: Comprehensive list of users and listening activity
SELECT u.username, h.played_at
FROM "User" u
         FULL JOIN Listening_History h ON u.user_id = h.user_id;

-- Query 2: Link tracks and stats to find orphans
SELECT t.title, ts.play_count
FROM Soundtrack t
         FULL JOIN Track_Stats ts ON t.track_id = ts.track_id;

-- Query: Generate all possible "User-Country" combinations for a survey
SELECT u.username, c.country_name
FROM "User" u
         CROSS JOIN (SELECT DISTINCT country AS country_name FROM Artist) c;

-- Query: Join Soundtrack and Album based on shared 'album_id'
SELECT title, album_id
FROM Soundtrack
         NATURAL JOIN Album;

-- Query: Find artists from the same country
SELECT a1.name AS Artist_A, a2.name AS Artist_B, a1.country
FROM Artist a1
         INNER JOIN Artist a2 ON a1.country = a2.country
WHERE a1.artist_id < a2.artist_id;