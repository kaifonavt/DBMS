-- 1. Format user welcome message
-- Functions: CONCAT (or || operator)
-- Transformation: Combines static text with the 'username' field.
-- Business Info: Create a personalized greeting for the mobile app UI.
SELECT CONCAT('Hello, ', username, '! Welcome back.') AS personalized_greeting
FROM "User"
WHERE user_id = 1;

-- 2. Standardize artist names for search
-- Function: UPPER()
-- Transformation: Converts all artist names to uppercase letters.
-- Business Info: Ensures consistent display in the "Featured Artists" list and avoids case-sensitivity issues during searches.
SELECT UPPER(name) AS artist_name_styled
FROM Artist;

-- 3. Create short track previews
-- Function: SUBSTRING()
-- Transformation: Extracts only the first 10 characters of a track title.
-- Business Info: Useful for limited-space UI components, like notification pop-ups or small widgets on the lock screen.
SELECT SUBSTRING(title FROM 1 FOR 10) || '...' AS truncated_title
FROM Soundtrack;

-- 4. Normalize email domains for analysis
-- Function: LOWER() and LIKE
-- Transformation: Forces emails to lowercase to check for specific providers.
-- Business Info: Helps identify users with professional or student emails (@edu) for targeted subscription discounts.
SELECT username, LOWER(email) AS cleaned_email
FROM "User"
WHERE email LIKE LOWER('%@GMAIL.COM');

-- 5. Calculate name length for UI validation
-- Function: LENGTH()
-- Transformation: Returns the number of characters in a playlist name.
-- Business Info: Identify "empty" or overly long playlist names to prompt the user to edit them for better library organization.
SELECT name, LENGTH(name) AS character_count
FROM Playlist
WHERE LENGTH(name) < 5 OR LENGTH(name) > 50;