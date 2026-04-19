-- Prevent deleting a track if it has more than 1 million plays
CREATE OR REPLACE FUNCTION prevent_hit_deletion() RETURNS TRIGGER AS $$
BEGIN
    IF (SELECT play_count FROM Track_Stats WHERE track_id = OLD.track_id) > 1000000 THEN
        RAISE EXCEPTION 'Cannot delete a legendary track with over 1M plays!';
    END IF;
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER block_delete_hits
    BEFORE DELETE ON Soundtrack
    FOR EACH ROW EXECUTE FUNCTION prevent_hit_deletion();