BEGIN;
-- Registering a new album and its lead track simultaneously
INSERT INTO Album (title, release_date, artist_id) VALUES ('Global Hits', NOW(), 1);
INSERT INTO Soundtrack (title, duration, album_id, artist_id)
VALUES ('Intro', '00:02:00', (SELECT MAX(album_id) FROM Album), 1);
COMMIT;