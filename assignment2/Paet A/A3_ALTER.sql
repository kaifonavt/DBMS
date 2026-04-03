-- 1. TABLE ARTIST: Adding new column for vertification
ALTER TABLE Artist ADD COLUMN is_verified BOOLEAN DEFAULT FALSE;
--ALTER TABLE Artist DROP COLUMN is_verified;--rollback
-- 2. TABLE "User": Changing datatype for subscribtion info
ALTER TABLE "User" ALTER COLUMN subscription_type TYPE VARCHAR(100);
--ALTER TABLE "User" ALTER COLUMN subscription_type TYPE VARCHAR(20);--rollback
-- 3. TABLE PLAYLIST: Adding NOT NULL and UNIQUE requirements
ALTER TABLE Playlist ALTER COLUMN name SET NOT NULL;
ALTER TABLE Playlist ADD CONSTRAINT unique_user_playlist_name UNIQUE (user_id, name);
--ALTER TABLE Playlist ALTER COLUMN name DROP NOT NULL;--rollback
-- TABLE Playlist DROP CONSTRAINT unique_user_playlist_name;--rollback

