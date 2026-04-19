-- View 1: Artist Productivity Summary
-- This view joins Artists and Albums to show how many albums each artist has.
CREATE VIEW artist_album_stats AS
SELECT ar.name AS artist_name, COUNT(al.album_id) AS album_count
FROM Artist ar
         LEFT JOIN Album al ON ar.artist_id = al.artist_id
GROUP BY ar.name;

-- View 2: High-Engagement Tracks
-- Simplifies identifying tracks with more than 100,000 plays.
CREATE VIEW popular_tracks_view AS
SELECT t.title, s.play_count
FROM Soundtrack t
         JOIN Track_Stats s ON t.track_id = s.track_id
WHERE s.play_count > 100000;