-- 1. Calculate the age of user accounts in days
-- Subtracting 'created_at' from 'CURRENT_DATE'.
SELECT username, email, (CURRENT_DATE - created_at::date) AS days_since_registration
FROM "User"
WHERE (CURRENT_DATE - created_at::date) > 365;

-- 2. Find albums released in a specific month
-- EXTRACT(MONTH FROM ...) is used to isolate the month part of the date.
SELECT title, release_date
FROM Album
WHERE EXTRACT(MONTH FROM release_date) = 3;

-- 3. Find tracks uploaded within the last 30 days
-- Using 'NOW()' and 'INTERVAL' to create a dynamic time window.
SELECT title, upload_date
FROM Soundtrack
WHERE upload_date >= NOW() - INTERVAL '30 days';

-- 4. Calculate exact duration since the last play
-- AGE(timestamp, timestamp) calculates the symbolic gap (years, months, days).
SELECT user_id, track_id, AGE(NOW(), played_at) AS time_since_played
FROM Listening_History
ORDER BY played_at DESC;

-- 5. Identify weekend activity
-- EXTRACT(DOW FROM ...) extracts the Day Of Week (0=Sunday, 6=Saturday).
SELECT history_id, played_at
FROM Listening_History
WHERE EXTRACT(DOW FROM played_at) IN (0, 6);