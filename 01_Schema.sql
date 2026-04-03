CREATE TABLE "User" (
                        user_id SERIAL PRIMARY KEY,
                        username VARCHAR(50) NOT NULL UNIQUE,
                        email VARCHAR(100) NOT NULL UNIQUE,
                        password VARCHAR(255) NOT NULL,
                        subscription_type VARCHAR(20) DEFAULT 'free',
                        created_at TIMESTAMP NOT NULL DEFAULT NOW()
);

CREATE TABLE Artist (
                        artist_id SERIAL PRIMARY KEY,
                        name VARCHAR(100) NOT NULL,
                        bio TEXT,
                        country VARCHAR(50)
);

CREATE TABLE Album (
                       album_id SERIAL PRIMARY KEY,
                       title VARCHAR(150) NOT NULL,
                       release_date DATE,
                       artist_id INT NOT NULL,
                       CONSTRAINT fk_artist FOREIGN KEY (artist_id) REFERENCES Artist(artist_id) ON DELETE CASCADE
);

CREATE TABLE Soundtrack (
                            track_id SERIAL PRIMARY KEY,
                            title VARCHAR(150) NOT NULL,
                            duration INTERVAL NOT NULL,
                            album_id INT,
                            artist_id INT NOT NULL,
                            file_url VARCHAR(255) NOT NULL,
                            upload_date TIMESTAMP NOT NULL DEFAULT NOW(),
                            CONSTRAINT fk_track_album FOREIGN KEY (album_id) REFERENCES Album(album_id) ON DELETE SET NULL,
                            CONSTRAINT fk_track_artist FOREIGN KEY (artist_id) REFERENCES Artist(artist_id) ON DELETE CASCADE
);

CREATE TABLE Playlist (
                          playlist_id SERIAL PRIMARY KEY,
                          name VARCHAR(100) NOT NULL,
                          user_id INT NOT NULL,
                          is_public BOOLEAN NOT NULL DEFAULT TRUE,
                          created_at TIMESTAMP NOT NULL DEFAULT NOW(),
                          CONSTRAINT fk_playlist_user FOREIGN KEY (user_id) REFERENCES "User"(user_id) ON DELETE CASCADE
);

CREATE TABLE Playlist_Track (
                                playlist_id INT NOT NULL,
                                track_id INT NOT NULL,
                                added_at TIMESTAMP NOT NULL DEFAULT NOW(),
                                PRIMARY KEY (playlist_id, track_id),
                                CONSTRAINT fk_pt_playlist FOREIGN KEY (playlist_id) REFERENCES Playlist(playlist_id) ON DELETE CASCADE,
                                CONSTRAINT fk_pt_track FOREIGN KEY (track_id) REFERENCES Soundtrack(track_id) ON DELETE CASCADE
);

CREATE TABLE Listening_History (
                                   history_id SERIAL PRIMARY KEY,
                                   user_id INT NOT NULL,
                                   track_id INT NOT NULL,
                                   played_at TIMESTAMP NOT NULL DEFAULT NOW(),
                                   CONSTRAINT fk_lh_user FOREIGN KEY (user_id) REFERENCES "User"(user_id),
                                   CONSTRAINT fk_lh_track FOREIGN KEY (track_id) REFERENCES Soundtrack(track_id)
);

CREATE TABLE Track_Stats (
                             track_id INT PRIMARY KEY,
                             play_count INT DEFAULT 0,
                             unique_listeners INT DEFAULT 0,
                             CONSTRAINT fk_stats_track FOREIGN KEY (track_id) REFERENCES Soundtrack(track_id) ON DELETE CASCADE
);