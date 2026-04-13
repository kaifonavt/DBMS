-- Query 1: Track daily growth of play counts
-- Comparing today's performance with yesterday's to detect trends.
SELECT
    track_id,
    played_at::date AS play_date,
    COUNT(*) AS daily_plays,
    LAG(COUNT(*)) OVER (PARTITION BY track_id ORDER BY played_at::date) AS prev_day_plays,
    COUNT(*) - LAG(COUNT(*)) OVER (PARTITION BY track_id ORDER BY played_at::date) AS diff
FROM Listening_History
GROUP BY track_id, played_at::date;

-- Query 2: Contribution of each artist to total plays
-- Identifying market share of artists within the platform.
SELECT
    ar.name,
    SUM(ts.play_count) AS artist_plays,
    ROUND(100.0 * SUM(ts.play_count) / SUM(SUM(ts.play_count)) OVER (), 2) AS percent_of_total
FROM Artist ar
         JOIN Soundtrack t ON ar.artist_id = t.artist_id
         JOIN Track_Stats ts ON t.track_id = ts.track_id
GROUP BY ar.name;

-- Query 3: 7-day moving average of user registrations
-- Smoothing out daily fluctuations to see long-term growth trends.
SELECT
    created_at::date AS reg_date,
    COUNT(user_id) AS daily_users,
    AVG(COUNT(user_id)) OVER (
        ORDER BY created_at::date
        ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
        ) AS moving_avg_7d
FROM "User"
GROUP BY created_at::date;