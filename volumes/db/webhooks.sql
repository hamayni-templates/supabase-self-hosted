-- Supabase Self-Hosted: Webhooks (pg_net) setup
-- Mounted as docker-entrypoint-initdb.d/04-webhooks.sql
CREATE EXTENSION IF NOT EXISTS pg_net;
CREATE SCHEMA IF NOT EXISTS supabase_functions;
ALTER SCHEMA supabase_functions OWNER TO supabase_admin;
GRANT USAGE ON SCHEMA supabase_functions TO postgres, anon, authenticated, service_role;
GRANT ALL ON ALL TABLES IN SCHEMA supabase_functions TO postgres, anon, authenticated, service_role;
GRANT ALL ON ALL ROUTINES IN SCHEMA supabase_functions TO postgres, anon, authenticated, service_role;
GRANT ALL ON ALL SEQUENCES IN SCHEMA supabase_functions TO postgres, anon, authenticated, service_role;
ALTER DEFAULT PRIVILEGES IN SCHEMA supabase_functions GRANT ALL ON TABLES TO postgres, anon, authenticated, service_role;
ALTER DEFAULT PRIVILEGES IN SCHEMA supabase_functions GRANT ALL ON ROUTINES TO postgres, anon, authenticated, service_role;
ALTER DEFAULT PRIVILEGES IN SCHEMA supabase_functions GRANT ALL ON SEQUENCES TO postgres, anon, authenticated, service_role;
