-- SAFE COMPATIBILITY MIGRATION for the EXISTING employee-attendance Supabase project.
-- This script only adds missing columns; it does not drop tables or delete existing rows.
-- Run only if the listed tables already exist as in the earlier app.

alter table if exists public.employees
  add column if not exists face_descriptor double precision[],
  add column if not exists face_photo text,
  add column if not exists signature_data text,
  add column if not exists auth_user_id uuid;

alter table if exists public.attendance_events
  add column if not exists method text default 'face',
  add column if not exists evidence_photo text,
  add column if not exists note text;

-- Existing attendance_settings schema is expected to contain:
-- id, work_start, work_end, grace_minutes.
-- Keep its existing row and values. Do not recreate this table.
