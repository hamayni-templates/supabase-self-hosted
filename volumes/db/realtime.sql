-- Supabase Self-Hosted: Realtime setup
-- Mounted as docker-entrypoint-initdb.d/03-realtime.sql
CREATE SCHEMA IF NOT EXISTS _realtime;
ALTER SCHEMA _realtime OWNER TO postgres;
GRANT USAGE ON SCHEMA _realtime TO supabase_admin;
GRANT ALL ON ALL TABLES IN SCHEMA _realtime TO supabase_admin;
GRANT ALL ON ALL SEQUENCES IN SCHEMA _realtime TO supabase_admin;
DO $$ BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_publication WHERE pubname = 'supabase_realtime') THEN
    CREATE PUBLICATION supabase_realtime;
  END IF;
END $$;
