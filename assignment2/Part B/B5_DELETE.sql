-- 1. Remove track from playlist
DELETE FROM Playlist_Track WHERE playlist_id = 1 AND track_id = 10;
-- INSERT INTO Playlist_Track (playlist_id, track_id, added_at) VALUES (1, 10, NOW());
-- 2. Delete user account
DELETE FROM "User" WHERE user_id = 30;
-- INSERT INTO "User" (user_id, username, email, password, subscription_type)
-- VALUES (30, 'user_30', 'user30@example.com', 'pass_30', 'free');
-- 3. Clear old history
DELETE FROM Listening_History WHERE played_at < '2025-01-01';
--INSERT INTO Listening_History (user_id, track_id, played_at) VALUES (1, 1, '2024-12-31 23:59:59');
-- 4. Remove playlist
DELETE FROM Playlist WHERE playlist_id = 5;
-- INSERT INTO Playlist (playlist_id, name, user_id, is_public) VALUES (5, 'My Playlist #5', 5, TRUE);
-- 5. Delete artist
DELETE FROM Artist WHERE artist_id = 15;
-- INSERT INTO Artist (artist_id, name, bio, country) VALUES (15, 'Artist Name 15', 'Bio 15', 'Germany');