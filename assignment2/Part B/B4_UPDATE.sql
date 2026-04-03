-- 1. Upgrade user to premium
UPDATE "User" SET subscription_type = 'premium' WHERE user_id = 5;
-- UPDATE "User" SET subscription_type = 'free' WHERE user_id = 5;
-- 2. Modify artist biography
UPDATE Artist SET bio = bio || ' [UK Based Artist]' WHERE country = 'UK';
-- UPDATE Artist SET bio = REPLACE(bio, ' [UK Based Artist]', '') WHERE country = 'UK';
-- 3. Correct track title
UPDATE Soundtrack SET title = 'New Remix 2026' WHERE track_id = 10;
-- UPDATE Soundtrack SET title = 'Track 10' WHERE track_id = 10;
-- 4. Change playlist privacy
UPDATE Playlist SET is_public = TRUE WHERE playlist_id = 1;
-- UPDATE Playlist SET is_public = FALSE WHERE playlist_id = 1;
-- 5. Adjust release date
UPDATE Album SET release_date = '2026-01-01' WHERE album_id = 2;
-- UPDATE Album SET release_date = '2025-01-01' WHERE album_id = 2;