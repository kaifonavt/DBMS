    -- Audit table
    CREATE TABLE audit_log (
        log_id SERIAL PRIMARY KEY,
        operation_type TEXT,
        table_name TEXT,
        changed_at TIMESTAMP DEFAULT NOW(),
        old_data JSONB
    );

    -- Audit function
    CREATE OR REPLACE FUNCTION log_user_changes() RETURNS TRIGGER AS $$
    BEGIN
        INSERT INTO audit_log (operation_type, table_name, old_data)
        VALUES (TG_OP, TG_TABLE_NAME, to_jsonb(OLD));
        RETURN NEW;
    END;
    $$ LANGUAGE plpgsql;

    -- Trigger for the User table
    CREATE TRIGGER user_audit_trg
    AFTER UPDATE OR DELETE ON "User"
    FOR EACH ROW EXECUTE FUNCTION log_user_changes();