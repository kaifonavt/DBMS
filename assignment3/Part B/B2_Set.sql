-- Query 1: Statistics by Country and Subscription Type
-- Multi-dimensional report for regional management.
SELECT
    COALESCE(ar.country, 'Total (All Countries)') AS country,
    COALESCE(u.subscription_type, 'Total (All Types)') AS sub_type,
    COUNT(h.history_id) AS play_count
FROM Artist ar
JOIN Soundtrack t ON ar.artist_id = t.artist_id
JOIN Listening_History h ON t.track_id = h.track_id
JOIN "User" u ON h.user_id = u.user_id
GROUP BY GROUPING SETS ((ar.country, u.subscription_type), (ar.country), ())
ORDER BY ar.country NULLS LAST, u.subscription_type NULLS LAST;

-- Query 2: Full analysis matrix using CUBE
-- Finding hidden patterns between Artist Countries and User Subscriptions.
SELECT
    ar.country,
    u.subscription_type,
    GROUPING(ar.country) AS country_level,
    GROUPING(u.subscription_type) AS sub_level,
    COUNT(*) AS total_interactions
FROM Artist ar
         JOIN Soundtrack t ON ar.artist_id = t.artist_id
         JOIN Listening_History h ON t.track_id = h.track_id
         JOIN "User" u ON h.user_id = u.user_id
GROUP BY CUBE (ar.country, u.subscription_type);

--- Query 3: Identify "Power Users" (Premium users who have high listening activity)
-- Finding top customers who use the service extensively.
SELECT user_id FROM "User" WHERE subscription_type = 'premium'
INTERSECT
SELECT user_id FROM Listening_History GROUP BY user_id HAVING COUNT(*) > 5;

-- Query 4: Detailed play count matrix
-- Comprehensive view of interactions by user type and artist country.
SELECT
    ar.country,
    u.subscription_type,
    COUNT(h.history_id) AS total_plays
FROM Artist ar
         JOIN Soundtrack t ON ar.artist_id = t.artist_id
         JOIN Listening_History h ON t.track_id = h.track_id
         JOIN "User" u ON h.user_id = u.user_id
GROUP BY CUBE (ar.country, u.subscription_type);

-- Query 5: Hierarchical report: Country -> Artist -> Album
-- Analyzing content distribution from a geographic to a specific product level.
SELECT
    COALESCE(ar.country, 'GLOBAL') AS region,
    COALESCE(ar.name, 'ALL ARTISTS') AS artist,
    COUNT(al.album_id) AS album_count
FROM Artist ar
         LEFT JOIN Album al ON ar.artist_id = al.artist_id
GROUP BY ROLLUP (ar.country, ar.name);

-- Query 6: Performance metrics by release year
-- Comparing popularity and reach of content based on its age.
SELECT
    EXTRACT(YEAR FROM al.release_date) AS release_year,
    SUM(ts.play_count) AS total_plays,
    AVG(ts.unique_listeners) AS avg_listeners
FROM Album al
         JOIN Soundtrack t ON al.album_id = t.album_id
         JOIN Track_Stats ts ON t.track_id = ts.track_id
GROUP BY ROLLUP (EXTRACT(YEAR FROM al.release_date));