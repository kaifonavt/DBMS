-- Materialized View for regional analytics
CREATE MATERIALIZED VIEW regional_performance_report AS
SELECT ar.country, SUM(ts.play_count) AS total_regional_plays
FROM Artist ar
         JOIN Soundtrack s ON ar.artist_id = s.artist_id
         JOIN Track_Stats ts ON s.track_id = ts.track_id
GROUP BY ar.country;