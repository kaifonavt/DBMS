-- Modify existing view
CREATE OR REPLACE VIEW popular_tracks_view AS
SELECT t.title, s.play_count, t.upload_date
FROM Soundtrack t
         JOIN Track_Stats s ON t.track_id = s.track_id
WHERE s.play_count > 50000;