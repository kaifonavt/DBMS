INSERT INTO "User" (username, email, password, subscription_type, created_at)
VALUES
    ('PowerUser', 'power@gmail.com', 'hash1', 'premium', '2025-01-10'),
    ('Newbie', 'new@yahoo.com', 'hash2', 'free', '2026-03-01'),
    ('MusicLover', 'lover@gmail.com', 'hash3', 'premium', '2025-06-15');

-- Fill remaining to reach 30+ using series
INSERT INTO "User" (username, email, password, subscription_type, created_at)
SELECT
    'user_' || i,
    'user' || i || '@test.com',
    'pass' || i,
    CASE WHEN i % 4 = 0 THEN 'premium' ELSE 'free' END,
    CASE WHEN i % 2 = 0 THEN '2025-08-20'::date ELSE '2026-01-15'::date END
FROM generate_series(4, 35) s(i);

-- 3. Populate Artists (Specific countries for CUBE/ROLLUP tasks)
INSERT INTO Artist (name, bio, country)
SELECT
    'Artist ' || i,
    'Bio for artist ' || i,
    CASE
        WHEN i <= 10 THEN 'USA'
        WHEN i <= 20 THEN 'UK'
        ELSE 'Kazakhstan'
        END
FROM generate_series(1, 30) s(i);

-- 4. Populate Albums (Varying release months for Task B3)
INSERT INTO Album (title, release_date, artist_id)
SELECT
    'Album ' || i,
    CASE
        WHEN i % 3 = 0 THEN '2025-03-15'::date -- Spring releases
        WHEN i % 3 = 1 THEN '2025-07-20'::date
        ELSE '2026-02-10'::date
        END,
    (i % 30) + 1
FROM generate_series(1, 35) s(i);

-- 5. Populate Soundtrack (Tracks)
INSERT INTO Soundtrack (title, duration, album_id, artist_id, upload_date)
SELECT
    'Track ' || i,
    '00:03:30'::interval,
    (i % 35) + 1,
    (i % 30) + 1,
    NOW() - (i || ' days')::interval
FROM generate_series(1, 40) s(i);

-- 6. Populate Listening History (Crucial for INTERSECT and Window Functions)
-- We make User 1 a "Power User" with many plays
INSERT INTO Listening_History (user_id, track_id, played_at)
SELECT 1, (i % 5) + 1, '2026-04-01'::timestamp + (i || ' hours')::interval
FROM generate_series(1, 10) s(i);

-- Random history for others
INSERT INTO Listening_History (user_id, track_id, played_at)
SELECT
    (i % 30) + 2,
    (i % 40) + 1,
    '2026-03-01'::timestamp + (i || ' hours')::interval
FROM generate_series(1, 50) s(i);

-- 7. Populate Track Stats (For AVG and MAX subqueries)
INSERT INTO Track_Stats (track_id, play_count, unique_listeners)
SELECT
    i,
    (random() * 200000)::int,
    (random() * 50000)::int
FROM generate_series(1, 40) s(i);

-- 8. Populate Playlists (For HAVING count > 3 task)
INSERT INTO Playlist (name, user_id, is_public, created_at)
SELECT 'Playlist ' || i, (i % 30) + 1, (i % 2 = 0), NOW() FROM generate_series(1, 10) s(i);

INSERT INTO Playlist_Track (playlist_id, track_id)
SELECT (i % 10) + 1, (i % 40) + 1 FROM generate_series(1, 50) s(i);