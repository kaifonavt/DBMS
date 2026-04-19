-- 1. Single-column index for fast title search
CREATE INDEX idx_track_title ON Soundtrack(title);

-- 2. Composite index for history filtering by user and time
CREATE INDEX idx_user_played_at ON Listening_History(user_id, played_at);

-- 3. Partial index for targeting premium users' emails
CREATE INDEX idx_premium_emails ON "User"(email)
WHERE subscription_type = 'premium';