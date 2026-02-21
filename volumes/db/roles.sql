-- Supabase Self-Hosted: Idempotent Role Initialization
-- Mounted as docker-entrypoint-initdb.d/01-roles.sql
DO $$
DECLARE
  _pw TEXT := current_setting('app.settings.db_password', true);
BEGIN
  IF _pw IS NULL OR _pw = '' THEN
    _pw := 'hamayni_placeholder_will_be_overridden_by_agent';
  END IF;
  IF NOT EXISTS (SELECT 1 FROM pg_roles WHERE rolname = 'authenticator') THEN
    EXECUTE format('CREATE ROLE authenticator NOINHERIT LOGIN PASSWORD %L', _pw);
  END IF;
  IF NOT EXISTS (SELECT 1 FROM pg_roles WHERE rolname = 'supabase_auth_admin') THEN
    EXECUTE format('CREATE ROLE supabase_auth_admin NOINHERIT CREATEROLE LOGIN PASSWORD %L', _pw);
  END IF;
  IF NOT EXISTS (SELECT 1 FROM pg_roles WHERE rolname = 'supabase_storage_admin') THEN
    EXECUTE format('CREATE ROLE supabase_storage_admin NOINHERIT CREATEROLE LOGIN PASSWORD %L', _pw);
  END IF;
  IF NOT EXISTS (SELECT 1 FROM pg_roles WHERE rolname = 'supabase_admin') THEN
    EXECUTE format('CREATE ROLE supabase_admin NOINHERIT CREATEROLE LOGIN PASSWORD %L', _pw);
  END IF;
  IF NOT EXISTS (SELECT 1 FROM pg_roles WHERE rolname = 'anon') THEN
    CREATE ROLE anon NOLOGIN NOINHERIT;
  END IF;
  IF NOT EXISTS (SELECT 1 FROM pg_roles WHERE rolname = 'authenticated') THEN
    CREATE ROLE authenticated NOLOGIN NOINHERIT;
  END IF;
  IF NOT EXISTS (SELECT 1 FROM pg_roles WHERE rolname = 'service_role') THEN
    CREATE ROLE service_role NOLOGIN NOINHERIT BYPASSRLS;
  END IF;
  IF NOT EXISTS (SELECT 1 FROM pg_roles WHERE rolname = 'supabase_replication_admin') THEN
    EXECUTE format('CREATE ROLE supabase_replication_admin LOGIN REPLICATION PASSWORD %L', _pw);
  END IF;
  IF NOT EXISTS (SELECT 1 FROM pg_roles WHERE rolname = 'supabase_read_only_user') THEN
    CREATE ROLE supabase_read_only_user NOLOGIN NOINHERIT;
  END IF;
  GRANT anon TO authenticator;
  GRANT authenticated TO authenticator;
  GRANT service_role TO authenticator;
  GRANT supabase_admin TO authenticator;
END $$;
DO $$
DECLARE
  _pw TEXT;
BEGIN
  BEGIN
    SELECT current_setting('app.settings.db_password', true) INTO _pw;
  EXCEPTION WHEN OTHERS THEN
    _pw := NULL;
  END;
  IF _pw IS NOT NULL AND _pw != '' AND _pw != 'hamayni_placeholder_will_be_overridden_by_agent' THEN
    EXECUTE format('ALTER ROLE authenticator PASSWORD %L', _pw);
    EXECUTE format('ALTER ROLE supabase_auth_admin PASSWORD %L', _pw);
    EXECUTE format('ALTER ROLE supabase_storage_admin PASSWORD %L', _pw);
    EXECUTE format('ALTER ROLE supabase_admin PASSWORD %L', _pw);
    EXECUTE format('ALTER ROLE supabase_replication_admin PASSWORD %L', _pw);
  END IF;
END $$;
