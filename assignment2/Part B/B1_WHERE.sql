-- 1. Identify active premium members for marketing campaigns
-- Business Logic: Filtering users who pay for premium and joined before 2026.
SELECT username, email
FROM "User"
WHERE subscription_type = 'premium'
  AND created_at < '2026-01-01';
-- 2. Find "Viral" tracks based on popularity metrics
-- Business Logic: Extracting tracks that exceeded 100,000 plays for the "Global Hits" chart.
SELECT track_id, play_count
FROM Track_Stats
WHERE play_count > 100000;
-- 3. Filter artists by specific regions for localization
-- Business Logic: Selecting creators from USA or UK to curate regional playlists.
SELECT name, country
FROM Artist
WHERE country IN ('USA', 'UK');
-- 4. Retrieve album releases for a specific fiscal year
-- Business Logic: Auditing all content published during the year 2025.
SELECT title, release_date
FROM Album
WHERE release_date BETWEEN '2025-01-01' AND '2025-12-31';
-- 5. Audit private playlists for a specific user
-- Business Logic: Ensuring privacy settings are correctly applied for user with ID 1.
SELECT name, created_at
FROM Playlist
WHERE user_id = 1
  AND is_public = FALSE;