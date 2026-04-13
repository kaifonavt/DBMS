-- Query 1: Find tracks with play counts higher than the average
-- Identifying "above-average" performers for a special playlist.
SELECT title
FROM Soundtrack
WHERE track_id IN (
    SELECT track_id
    FROM Track_Stats
    WHERE play_count > (SELECT AVG(play_count) FROM Track_Stats)
);

-- Query 2: Find all artists who have released at least one album
-- Distinguishing active recording artists from performers without albums.
SELECT name
FROM Artist
WHERE artist_id IN (SELECT DISTINCT artist_id FROM Album);

-- Query 3: Find tracks that have the maximum play count within their own album
-- Identifying the "lead single" or most popular track for every album.
SELECT t.title, t.album_id
FROM Soundtrack t
WHERE (SELECT s.play_count FROM Track_Stats s WHERE s.track_id = t.track_id) = (
    SELECT MAX(s2.play_count)
    FROM Track_Stats s2
             JOIN Soundtrack t2 ON s2.track_id = t2.track_id
    WHERE t2.album_id = t.album_id
);

-- Query 4: Find users who have at least one private playlist
-- Identifying privacy-conscious users for security feature testing.
SELECT username
FROM "User" u
WHERE EXISTS (
    SELECT 1
    FROM Playlist p
    WHERE p.user_id = u.user_id AND p.is_public = FALSE
);

-- Query 5: Find tracks with more plays than ALL tracks from a specific artist (e.g., ID 1)
-- Benchmarking content against a specific "top" artist.
SELECT track_id, play_count
FROM Track_Stats
WHERE play_count > ALL (
    SELECT s.play_count
    FROM Track_Stats s
             JOIN Soundtrack t ON s.track_id = t.track_id
    WHERE t.artist_id = 1
);

-- Query 6: Find playlists created at the exact same time as another specific entry
-- Detecting potential duplicate or automated playlist creations.
SELECT playlist_id, name, user_id, created_at
FROM Playlist
WHERE (user_id, created_at) = (
    SELECT user_id, created_at
    FROM Playlist
    WHERE playlist_id = 10
) AND playlist_id <> 10;