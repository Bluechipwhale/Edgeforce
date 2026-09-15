import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const storePath = path.resolve(__dirname, '../data/store.json');
const outputPath = path.resolve(__dirname, '../../supabase/migrations/006_authoritative_staff_seed.sql');

const store = JSON.parse(fs.readFileSync(storePath, 'utf-8'));
const users = store.users || [];
const employees = store.employees || [];

let lines = [];
lines.push('-- ==============================================================================');
lines.push('-- EDGEWFORCE - AUTHORITATIVE PRODUCTION DATABASE SEED & SCHEMA MIGRATION');
lines.push('-- Migration: 006_authoritative_staff_seed.sql');
lines.push('-- Contains complete tables DDL, columns extension, and full 66 staff seed records.');
lines.push('-- ==============================================================================');
lines.push('');
lines.push('-- 1. EXTEND TABLES COLUMNS SAFELY');
lines.push('ALTER TABLE IF EXISTS public.users ADD COLUMN IF NOT EXISTS full_name TEXT;');
lines.push('ALTER TABLE IF EXISTS public.users ADD COLUMN IF NOT EXISTS requires_password_change BOOLEAN DEFAULT TRUE;');
lines.push('ALTER TABLE IF EXISTS public.users ADD COLUMN IF NOT EXISTS password_changed_at TIMESTAMPTZ;');
lines.push('ALTER TABLE IF EXISTS public.users ADD COLUMN IF NOT EXISTS first_login_at TIMESTAMPTZ;');
lines.push("ALTER TABLE IF EXISTS public.users ADD COLUMN IF NOT EXISTS onboarding_status TEXT DEFAULT 'Account Created';");
lines.push('ALTER TABLE IF EXISTS public.users ADD COLUMN IF NOT EXISTS raw_phone TEXT;');
lines.push('');
lines.push('ALTER TABLE IF EXISTS public.employees ADD COLUMN IF NOT EXISTS full_name TEXT;');
lines.push('ALTER TABLE IF EXISTS public.employees ADD COLUMN IF NOT EXISTS staff_id TEXT;');
lines.push('ALTER TABLE IF EXISTS public.employees ADD COLUMN IF NOT EXISTS personal_email TEXT;');
lines.push('ALTER TABLE IF EXISTS public.employees ADD COLUMN IF NOT EXISTS work_email TEXT;');
lines.push('ALTER TABLE IF EXISTS public.employees ADD COLUMN IF NOT EXISTS date_of_birth TEXT;');
lines.push('ALTER TABLE IF EXISTS public.employees ADD COLUMN IF NOT EXISTS marital_status TEXT;');
lines.push("ALTER TABLE IF EXISTS public.employees ADD COLUMN IF NOT EXISTS nationality TEXT DEFAULT 'Nigerian';");
lines.push('ALTER TABLE IF EXISTS public.employees ADD COLUMN IF NOT EXISTS address TEXT;');
lines.push('ALTER TABLE IF EXISTS public.employees ADD COLUMN IF NOT EXISTS home_address TEXT;');
lines.push('ALTER TABLE IF EXISTS public.employees ADD COLUMN IF NOT EXISTS city_lga TEXT;');
lines.push('ALTER TABLE IF EXISTS public.employees ADD COLUMN IF NOT EXISTS state_of_origin TEXT;');
lines.push('ALTER TABLE IF EXISTS public.employees ADD COLUMN IF NOT EXISTS state_of_residence TEXT;');
lines.push('ALTER TABLE IF EXISTS public.employees ADD COLUMN IF NOT EXISTS landmark TEXT;');
lines.push('ALTER TABLE IF EXISTS public.employees ADD COLUMN IF NOT EXISTS department_raw TEXT;');
lines.push('ALTER TABLE IF EXISTS public.employees ADD COLUMN IF NOT EXISTS date_of_joining TEXT;');
lines.push('ALTER TABLE IF EXISTS public.employees ADD COLUMN IF NOT EXISTS work_location TEXT;');
lines.push('ALTER TABLE IF EXISTS public.employees ADD COLUMN IF NOT EXISTS supervisor_name TEXT;');
lines.push('ALTER TABLE IF EXISTS public.employees ADD COLUMN IF NOT EXISTS emergency_contact_name TEXT;');
lines.push('ALTER TABLE IF EXISTS public.employees ADD COLUMN IF NOT EXISTS emergency_contact_relationship TEXT;');
lines.push('ALTER TABLE IF EXISTS public.employees ADD COLUMN IF NOT EXISTS emergency_contact_phone TEXT;');
lines.push('ALTER TABLE IF EXISTS public.employees ADD COLUMN IF NOT EXISTS blood_group TEXT;');
lines.push('ALTER TABLE IF EXISTS public.employees ADD COLUMN IF NOT EXISTS bank_name TEXT;');
lines.push('ALTER TABLE IF EXISTS public.employees ADD COLUMN IF NOT EXISTS account_number TEXT;');
lines.push('ALTER TABLE IF EXISTS public.employees ADD COLUMN IF NOT EXISTS hobbies_interests TEXT;');
lines.push('ALTER TABLE IF EXISTS public.employees ADD COLUMN IF NOT EXISTS flagged_for_review BOOLEAN DEFAULT FALSE;');
lines.push('ALTER TABLE IF EXISTS public.employees ADD COLUMN IF NOT EXISTS review_reason TEXT;');
lines.push("ALTER TABLE IF EXISTS public.employees ADD COLUMN IF NOT EXISTS onboarding_status TEXT DEFAULT 'Account Created';");
lines.push('');
lines.push('-- 2. SEED AUTHORITATIVE USERS');

const escapeSql = (val) => {
  if (val === null || val === undefined) return 'NULL';
  if (typeof val === 'boolean') return val ? 'TRUE' : 'FALSE';
  if (typeof val === 'number') return String(val);
  return "'" + String(val).replace(/'/g, "''") + "'";
};

users.forEach((u) => {
  lines.push('INSERT INTO public.users (');
  lines.push('  id, company_id, full_name, email, password_hash, phone, raw_phone, role_code, status, requires_password_change, onboarding_status, created_at');
  lines.push(') VALUES (');
  lines.push('  ' + [
    escapeSql(u.id),
    escapeSql(u.company_id || 1),
    escapeSql(u.full_name),
    escapeSql(u.email),
    escapeSql(u.password_hash || '$2b$10$qybAj1yqxk2TY1/K8oKzM.4XGMwZrYgMpA/EASlpc24fgDDxmJq2u'),
    escapeSql(u.phone),
    escapeSql(u.raw_phone || u.phone),
    escapeSql(u.role_code || 'STAFF_MEMBER'),
    escapeSql(u.status || 'active'),
    escapeSql(u.requires_password_change !== undefined ? u.requires_password_change : true),
    escapeSql(u.onboarding_status || 'Account Created'),
    escapeSql(u.created_at || new Date().toISOString())
  ].join(', '));
  lines.push(')');
  lines.push('ON CONFLICT (id) DO UPDATE SET');
  lines.push('  full_name = EXCLUDED.full_name,');
  lines.push('  email = EXCLUDED.email,');
  lines.push('  phone = EXCLUDED.phone,');
  lines.push('  raw_phone = EXCLUDED.raw_phone,');
  lines.push('  role_code = EXCLUDED.role_code,');
  lines.push('  status = EXCLUDED.status,');
  lines.push('  requires_password_change = EXCLUDED.requires_password_change,');
  lines.push('  onboarding_status = EXCLUDED.onboarding_status;');
  lines.push('');
});

lines.push('-- 3. SEED AUTHORITATIVE EMPLOYEES');

employees.forEach((e) => {
  lines.push('INSERT INTO public.employees (');
  lines.push('  id, company_id, user_id, employee_code, staff_id, first_name, last_name, full_name, personal_email, work_email,');
  lines.push('  phone, date_of_birth, marital_status, nationality, address, home_address, city_lga, state_of_origin, state_of_residence,');
  lines.push('  landmark, department_id, department, position, date_of_joining, work_location, supervisor_name,');
  lines.push('  emergency_contact_name, emergency_contact_relationship, emergency_contact_phone, blood_group, bank_name,');
  lines.push('  account_number, hobbies_interests, rank_code, flagged_for_review, review_reason, onboarding_status, status, created_at');
  lines.push(') VALUES (');
  lines.push('  ' + [
    escapeSql(e.id),
    escapeSql(e.company_id || 1),
    escapeSql(e.user_id),
    escapeSql(e.employee_code),
    escapeSql(e.staff_id),
    escapeSql(e.first_name),
    escapeSql(e.last_name),
    escapeSql(e.full_name || ((e.first_name || '') + ' ' + (e.last_name || '')).trim()),
    escapeSql(e.personal_email || e.email),
    escapeSql(e.work_email),
    escapeSql(e.phone),
    escapeSql(e.date_of_birth),
    escapeSql(e.marital_status),
    escapeSql(e.nationality || 'Nigerian'),
    escapeSql(e.address),
    escapeSql(e.home_address),
    escapeSql(e.city_lga),
    escapeSql(e.state_of_origin),
    escapeSql(e.state_of_residence),
    escapeSql(e.landmark),
    escapeSql(e.department_id || null),
    escapeSql(e.department),
    escapeSql(e.position),
    escapeSql(e.date_of_joining || e.hire_date),
    escapeSql(e.work_location),
    escapeSql(e.supervisor_name),
    escapeSql(e.emergency_contact_name),
    escapeSql(e.emergency_contact_relationship),
    escapeSql(e.emergency_contact_phone),
    escapeSql(e.blood_group),
    escapeSql(e.bank_name),
    escapeSql(e.account_number),
    escapeSql(e.hobbies_interests),
    escapeSql(e.rank_code || 'STAFF_MEMBER'),
    escapeSql(e.flagged_for_review || false),
    escapeSql(e.review_reason),
    escapeSql(e.onboarding_status || 'Account Created'),
    escapeSql(e.status || 'active'),
    escapeSql(e.created_at || new Date().toISOString())
  ].join(', '));
  lines.push(')');
  lines.push('ON CONFLICT (id) DO UPDATE SET');
  lines.push('  full_name = EXCLUDED.full_name,');
  lines.push('  personal_email = EXCLUDED.personal_email,');
  lines.push('  work_email = EXCLUDED.work_email,');
  lines.push('  phone = EXCLUDED.phone,');
  lines.push('  date_of_birth = EXCLUDED.date_of_birth,');
  lines.push('  marital_status = EXCLUDED.marital_status,');
  lines.push('  nationality = EXCLUDED.nationality,');
  lines.push('  address = EXCLUDED.address,');
  lines.push('  home_address = EXCLUDED.home_address,');
  lines.push('  city_lga = EXCLUDED.city_lga,');
  lines.push('  state_of_origin = EXCLUDED.state_of_origin,');
  lines.push('  state_of_residence = EXCLUDED.state_of_residence,');
  lines.push('  landmark = EXCLUDED.landmark,');
  lines.push('  department = EXCLUDED.department,');
  lines.push('  position = EXCLUDED.position,');
  lines.push('  date_of_joining = EXCLUDED.date_of_joining,');
  lines.push('  work_location = EXCLUDED.work_location,');
  lines.push('  supervisor_name = EXCLUDED.supervisor_name,');
  lines.push('  emergency_contact_name = EXCLUDED.emergency_contact_name,');
  lines.push('  emergency_contact_relationship = EXCLUDED.emergency_contact_relationship,');
  lines.push('  emergency_contact_phone = EXCLUDED.emergency_contact_phone,');
  lines.push('  blood_group = EXCLUDED.blood_group,');
  lines.push('  bank_name = EXCLUDED.bank_name,');
  lines.push('  account_number = EXCLUDED.account_number,');
  lines.push('  status = EXCLUDED.status,');
  lines.push('  onboarding_status = EXCLUDED.onboarding_status;');
  lines.push('');
});

lines.push('-- 4. RESET SEQUENCE COUNTERS');
lines.push("SELECT setval(pg_get_serial_sequence('public.users', 'id'), COALESCE((SELECT MAX(id) FROM public.users), 1));");
lines.push("SELECT setval(pg_get_serial_sequence('public.employees', 'id'), COALESCE((SELECT MAX(id) FROM public.employees), 1));");
lines.push('');

fs.writeFileSync(outputPath, lines.join('\n'), 'utf-8');
console.log('SUCCESS: Generated ' + outputPath);
console.log('Users in SQL: ' + users.length);
console.log('Employees in SQL: ' + employees.length);

