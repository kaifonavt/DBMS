BEGIN;
-- Attempting to update data with an intentional error later
UPDATE "User" SET subscription_type = 'premium' WHERE user_id = 1;
-- Assume some business rule or error happens here
ROLLBACK;