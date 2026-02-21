-- Supabase Self-Hosted: Logging / Analytics setup
-- Mounted as docker-entrypoint-initdb.d/05-logs.sql
CREATE SCHEMA IF NOT EXISTS _analytics;
ALTER SCHEMA _analytics OWNER TO supabase_admin;
GRANT USAGE ON SCHEMA _analytics TO supabase_admin;
GRANT ALL ON ALL TABLES IN SCHEMA _analytics TO supabase_admin;
GRANT ALL ON ALL SEQUENCES IN SCHEMA _analytics TO supabase_admin;
