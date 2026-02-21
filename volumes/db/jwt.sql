-- Supabase Self-Hosted: JWT / pgjwt setup
-- Mounted as docker-entrypoint-initdb.d/02-jwt.sql
CREATE EXTENSION IF NOT EXISTS pgcrypto;
CREATE EXTENSION IF NOT EXISTS pgjwt;
