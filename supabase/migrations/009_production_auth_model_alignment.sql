-- ==============================================================================
-- EDGEWFORCE - PRODUCTION AUTHENTICATION & DATABASE MODEL ALIGNMENT (009)
-- Compatibility-safe for the existing bigint-based public identity model.
-- Supabase Auth identity is represented by auth_user_id UUID.
-- Existing employees.id, employees.user_id, and users.id remain bigint.
-- ==============================================================================

-- 1. Ensure extensions
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
CREATE EXTENSION IF NOT EXISTS "pgcrypto";

-- 2. Ensure public.employees columns match all application needs
ALTER TABLE IF EXISTS public.employees ADD COLUMN IF NOT EXISTS auth_user_id UUID REFERENCES auth.users(id) ON DELETE SET NULL;
-- Do not redefine user_id: it remains the bigint FK to public.users(id).
ALTER TABLE IF EXISTS public.employees ADD COLUMN IF NOT EXISTS email TEXT;
ALTER TABLE IF EXISTS public.employees ADD COLUMN IF NOT EXISTS work_email TEXT;
ALTER TABLE IF EXISTS public.employees ADD COLUMN IF NOT EXISTS personal_email TEXT;
ALTER TABLE IF EXISTS public.employees ADD COLUMN IF NOT EXISTS phone TEXT;
ALTER TABLE IF EXISTS public.employees ADD COLUMN IF NOT EXISTS full_name TEXT;
ALTER TABLE IF EXISTS public.employees ADD COLUMN IF NOT EXISTS position TEXT;
ALTER TABLE IF EXISTS public.employees ADD COLUMN IF NOT EXISTS rank_code TEXT;
ALTER TABLE IF EXISTS public.employees ADD COLUMN IF NOT EXISTS base_salary NUMERIC(15,2) DEFAULT 0;
ALTER TABLE IF EXISTS public.employees ADD COLUMN IF NOT EXISTS housing_allowance NUMERIC(15,2) DEFAULT 0;
ALTER TABLE IF EXISTS public.employees ADD COLUMN IF NOT EXISTS transport_allowance NUMERIC(15,2) DEFAULT 0;
ALTER TABLE IF EXISTS public.employees ADD COLUMN IF NOT EXISTS other_allowance NUMERIC(15,2) DEFAULT 0;
ALTER TABLE IF EXISTS public.employees ADD COLUMN IF NOT EXISTS work_location TEXT;
ALTER TABLE IF EXISTS public.employees ADD COLUMN IF NOT EXISTS state TEXT;
ALTER TABLE IF EXISTS public.employees ADD COLUMN IF NOT EXISTS lga TEXT;
ALTER TABLE IF EXISTS public.employees ADD COLUMN IF NOT EXISTS city TEXT;
ALTER TABLE IF EXISTS public.employees ADD COLUMN IF NOT EXISTS date_of_birth TEXT;
ALTER TABLE IF EXISTS public.employees ADD COLUMN IF NOT EXISTS marital_status TEXT;
ALTER TABLE IF EXISTS public.employees ADD COLUMN IF NOT EXISTS emergency_contact_name TEXT;
ALTER TABLE IF EXISTS public.employees ADD COLUMN IF NOT EXISTS emergency_contact_phone TEXT;
ALTER TABLE IF EXISTS public.employees ADD COLUMN IF NOT EXISTS emergency_contact_relationship TEXT;
ALTER TABLE IF EXISTS public.employees ADD COLUMN IF NOT EXISTS bank_name TEXT;
ALTER TABLE IF EXISTS public.employees ADD COLUMN IF NOT EXISTS account_number TEXT;
ALTER TABLE IF EXISTS public.employees ADD COLUMN IF NOT EXISTS onboarding_status TEXT DEFAULT 'Active';
ALTER TABLE IF EXISTS public.employees ADD COLUMN IF NOT EXISTS requires_password_change BOOLEAN DEFAULT FALSE;

-- 3. Ensure public.users columns match application identity needs
ALTER TABLE IF EXISTS public.users ADD COLUMN IF NOT EXISTS auth_user_id UUID REFERENCES auth.users(id) ON DELETE SET NULL;
ALTER TABLE IF EXISTS public.users ADD COLUMN IF NOT EXISTS uuid UUID DEFAULT gen_random_uuid();
ALTER TABLE IF EXISTS public.users ADD COLUMN IF NOT EXISTS full_name TEXT;
ALTER TABLE IF EXISTS public.users ADD COLUMN IF NOT EXISTS email TEXT;
ALTER TABLE IF EXISTS public.users ADD COLUMN IF NOT EXISTS phone TEXT;
ALTER TABLE IF EXISTS public.users ADD COLUMN IF NOT EXISTS role_code TEXT NOT NULL DEFAULT 'EMPLOYEE';
ALTER TABLE IF EXISTS public.users ADD COLUMN IF NOT EXISTS status TEXT NOT NULL DEFAULT 'active';
ALTER TABLE IF EXISTS public.users ADD COLUMN IF NOT EXISTS requires_password_change BOOLEAN DEFAULT FALSE;

-- 4. Backfill Auth UUID mappings from the existing bigint relationship.
UPDATE public.employees AS e
SET auth_user_id = u.auth_user_id
FROM public.users AS u
WHERE e.user_id = u.id
    AND e.auth_user_id IS NULL
    AND u.auth_user_id IS NOT NULL;

-- 5. High-performance indexes
CREATE INDEX IF NOT EXISTS idx_employees_id ON public.employees(id);
CREATE INDEX IF NOT EXISTS idx_employees_auth_user_id ON public.employees(auth_user_id);
CREATE INDEX IF NOT EXISTS idx_employees_user_id ON public.employees(user_id);
CREATE INDEX IF NOT EXISTS idx_employees_code ON public.employees(employee_code);
CREATE INDEX IF NOT EXISTS idx_employees_email_lower ON public.employees(LOWER(email));
CREATE INDEX IF NOT EXISTS idx_employees_work_email_lower ON public.employees(LOWER(work_email));
CREATE INDEX IF NOT EXISTS idx_employees_phone ON public.employees(phone);

CREATE INDEX IF NOT EXISTS idx_users_auth_user_id ON public.users(auth_user_id);
CREATE INDEX IF NOT EXISTS idx_users_uuid ON public.users(uuid);
CREATE INDEX IF NOT EXISTS idx_users_email_lower ON public.users(LOWER(email));
CREATE INDEX IF NOT EXISTS idx_users_phone ON public.users(phone);

-- 6. Trusted database-backed authorization helper
CREATE SCHEMA IF NOT EXISTS private;

CREATE OR REPLACE FUNCTION private.current_role_code()
RETURNS TEXT
LANGUAGE SQL
STABLE
SECURITY DEFINER
SET search_path = ''
AS $$
    SELECT u.role_code
    FROM public.users AS u
    WHERE u.auth_user_id = (SELECT auth.uid())
    LIMIT 1;
$$;

REVOKE ALL ON FUNCTION private.current_role_code() FROM PUBLIC;
GRANT USAGE ON SCHEMA private TO authenticated;
GRANT EXECUTE ON FUNCTION private.current_role_code() TO authenticated;

-- 7. Row Level Security Configuration
ALTER TABLE public.employees ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.users ENABLE ROW LEVEL SECURITY;

-- Service role policies (unrestricted for serverless backend API)
DROP POLICY IF EXISTS "Service role full access on employees" ON public.employees;
CREATE POLICY "Service role full access on employees" ON public.employees
FOR ALL TO service_role USING (true) WITH CHECK (true);

DROP POLICY IF EXISTS "Service role full access on users" ON public.users;
CREATE POLICY "Service role full access on users" ON public.users
FOR ALL TO service_role USING (true) WITH CHECK (true);

-- Authenticated user policies
DROP POLICY IF EXISTS "Employees can view own record" ON public.employees;
CREATE POLICY "Employees can view own record" ON public.employees
FOR SELECT TO authenticated
USING (
        auth_user_id = auth.uid() OR
        EXISTS (
                SELECT 1
                FROM public.users AS u
                WHERE u.id = public.employees.user_id
                    AND u.auth_user_id = auth.uid()
        ) OR
    (SELECT private.current_role_code()) IN ('SUPER_ADMIN', 'ADMIN', 'HR', 'HR_MANAGER', 'CEO', 'CTO')
);

DROP POLICY IF EXISTS "Employees can update own record" ON public.employees;
CREATE POLICY "Employees can update own record" ON public.employees
FOR UPDATE TO authenticated
USING (
        auth_user_id = auth.uid() OR
        EXISTS (
                SELECT 1
                FROM public.users AS u
                WHERE u.id = public.employees.user_id
                    AND u.auth_user_id = auth.uid()
        ) OR
    (SELECT private.current_role_code()) IN ('SUPER_ADMIN', 'ADMIN', 'HR', 'HR_MANAGER')
)
WITH CHECK (
    auth_user_id = auth.uid() OR
    EXISTS (
        SELECT 1
        FROM public.users AS u
        WHERE u.id = public.employees.user_id
          AND u.auth_user_id = auth.uid()
    ) OR
    (SELECT private.current_role_code()) IN ('SUPER_ADMIN', 'ADMIN', 'HR', 'HR_MANAGER')
);

DROP POLICY IF EXISTS "Users can read own record" ON public.users;
CREATE POLICY "Users can read own record" ON public.users
FOR SELECT TO authenticated
USING (
    auth_user_id = auth.uid() OR
    uuid = auth.uid() OR
    (SELECT private.current_role_code()) IN ('SUPER_ADMIN', 'ADMIN', 'HR_MANAGER', 'CEO')
);

-- Grants
GRANT USAGE ON SCHEMA public TO anon, authenticated, service_role;
GRANT ALL ON TABLE public.employees, public.users TO service_role;
GRANT SELECT ON TABLE public.employees, public.users TO authenticated;
GRANT UPDATE ON TABLE public.employees, public.users TO authenticated;
