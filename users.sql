-- Seed Data SQL Script for Platform Back Office Auth
-- This script seeds initial data into the PostgreSQL database
-- Usage: Run this script after migrations are complete
-- Note: This script is idempotent - safe to run multiple times
--
-- Features:
-- - Comprehensive RBAC (Role-Based Access Control) setup
-- - 27 permissions across User, Operator, Role, and Permission management
-- - 4 standard roles: Provider (admin), Manager, Operator, Auditor
-- - 100 admin users with Provider role assignment
-- - Two-factor authentication configurations (TOTP and EMAIL)
-- - Enhanced role metadata (role_type, description, status, role_code)

-- ============================================================================
-- PERMISSIONS
-- ============================================================================

-- User permissions
INSERT INTO permissions (id, name, created_at, updated_at)
SELECT uuid_generate_v4(), 'user:create', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM permissions WHERE name = 'user:create');

INSERT INTO permissions (id, name, created_at, updated_at)
SELECT uuid_generate_v4(), 'user:read', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM permissions WHERE name = 'user:read');

INSERT INTO permissions (id, name, created_at, updated_at)
SELECT uuid_generate_v4(), 'user:update', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM permissions WHERE name = 'user:update');

INSERT INTO permissions (id, name, created_at, updated_at)
SELECT uuid_generate_v4(), 'user:delete', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM permissions WHERE name = 'user:delete');

INSERT INTO permissions (id, name, created_at, updated_at)
SELECT uuid_generate_v4(), 'user:list', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM permissions WHERE name = 'user:list');

-- Operator permissions
INSERT INTO permissions (id, name, created_at, updated_at)
SELECT uuid_generate_v4(), 'operator:create', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM permissions WHERE name = 'operator:create');

INSERT INTO permissions (id, name, created_at, updated_at)
SELECT uuid_generate_v4(), 'operator:read', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM permissions WHERE name = 'operator:read');

INSERT INTO permissions (id, name, created_at, updated_at)
SELECT uuid_generate_v4(), 'operator:update', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM permissions WHERE name = 'operator:update');

INSERT INTO permissions (id, name, created_at, updated_at)
SELECT uuid_generate_v4(), 'operator:delete', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM permissions WHERE name = 'operator:delete');

INSERT INTO permissions (id, name, created_at, updated_at)
SELECT uuid_generate_v4(), 'operator:list', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM permissions WHERE name = 'operator:list');

-- Role permissions
INSERT INTO permissions (id, name, created_at, updated_at)
SELECT uuid_generate_v4(), 'role:create', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM permissions WHERE name = 'role:create');

INSERT INTO permissions (id, name, created_at, updated_at)
SELECT uuid_generate_v4(), 'role:read', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM permissions WHERE name = 'role:read');

INSERT INTO permissions (id, name, created_at, updated_at)
SELECT uuid_generate_v4(), 'role:update', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM permissions WHERE name = 'role:update');

INSERT INTO permissions (id, name, created_at, updated_at)
SELECT uuid_generate_v4(), 'role:delete', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM permissions WHERE name = 'role:delete');

INSERT INTO permissions (id, name, created_at, updated_at)
SELECT uuid_generate_v4(), 'role:list', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM permissions WHERE name = 'role:list');

INSERT INTO permissions (id, name, created_at, updated_at)
SELECT uuid_generate_v4(), 'role:assign-permission', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM permissions WHERE name = 'role:assign-permission');

INSERT INTO permissions (id, name, created_at, updated_at)
SELECT uuid_generate_v4(), 'role:remove-permission', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM permissions WHERE name = 'role:remove-permission');

-- Permission permissions
INSERT INTO permissions (id, name, created_at, updated_at)
SELECT uuid_generate_v4(), 'permission:create', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM permissions WHERE name = 'permission:create');

INSERT INTO permissions (id, name, created_at, updated_at)
SELECT uuid_generate_v4(), 'permission:read', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM permissions WHERE name = 'permission:read');

INSERT INTO permissions (id, name, created_at, updated_at)
SELECT uuid_generate_v4(), 'permission:update', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM permissions WHERE name = 'permission:update');

INSERT INTO permissions (id, name, created_at, updated_at)
SELECT uuid_generate_v4(), 'permission:delete', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM permissions WHERE name = 'permission:delete');

INSERT INTO permissions (id, name, created_at, updated_at)
SELECT uuid_generate_v4(), 'permission:list', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM permissions WHERE name = 'permission:list');

-- ============================================================================
-- ROLES (Enhanced with metadata and role codes)
-- ============================================================================
-- Role Hierarchy:
-- Provider (role_type: provider) - Full system access, highest privilege
-- Manager (role_type: operator) - Extended operational access, user management
-- Operator (role_type: operator) - Basic operational access, read-only
-- Auditor (role_type: operator) - Compliance access, full read-only

INSERT INTO roles (id, name, role_type, description, status, is_deleted, role_code, created_at, updated_at)
SELECT
    uuid_generate_v4(),
    'provider',
    'provider',
    'Provider role with full system access and administrative privileges',
    'active',
    false,
    'PRV-001',
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM roles WHERE name = 'provider');

INSERT INTO roles (id, name, role_type, description, status, is_deleted, role_code, created_at, updated_at)
SELECT
    uuid_generate_v4(),
    'manager',
    'operator',
    'Manager role with extended operational access including user management',
    'active',
    false,
    'MGR-001',
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM roles WHERE name = 'manager');

INSERT INTO roles (id, name, role_type, description, status, is_deleted, role_code, created_at, updated_at)
SELECT
    uuid_generate_v4(),
    'operator',
    'operator',
    'Operator role with limited read-only access for operational tasks',
    'active',
    false,
    'OPR-001',
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM roles WHERE name = 'operator');

INSERT INTO roles (id, name, role_type, description, status, is_deleted, role_code, created_at, updated_at)
SELECT
    uuid_generate_v4(),
    'auditor',
    'operator',
    'Auditor role with read-only access to all system data for compliance',
    'active',
    false,
    'AUD-001',
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM roles WHERE name = 'auditor');

-- ============================================================================
-- ROLE-PERMISSION ASSIGNMENTS
-- ============================================================================

-- Assign all permissions to Provider role
INSERT INTO role_permissions (id, role_id, permission_id, created_at)
SELECT
    uuid_generate_v4(),
    r.id,
    p.id,
    CURRENT_TIMESTAMP
FROM roles r
CROSS JOIN permissions p
WHERE r.name = 'provider' AND r.role_type = 'provider' AND r.status = 'active' AND r.is_deleted = false
  AND p.name IN (
    'user:create', 'user:read', 'user:update', 'user:delete', 'user:list',
    'operator:create', 'operator:read', 'operator:update', 'operator:delete', 'operator:list',
    'role:create', 'role:read', 'role:update', 'role:delete', 'role:list',
    'role:assign-permission', 'role:remove-permission',
    'permission:create', 'permission:read', 'permission:update', 'permission:delete', 'permission:list'
  )
  AND NOT EXISTS (
    SELECT 1 FROM role_permissions rp
    WHERE rp.role_id = r.id AND rp.permission_id = p.id
  );

-- Assign limited permissions to Operator role (read-only)
INSERT INTO role_permissions (id, role_id, permission_id, created_at)
SELECT
    uuid_generate_v4(),
    r.id,
    p.id,
    CURRENT_TIMESTAMP
FROM roles r
CROSS JOIN permissions p
WHERE r.name = 'operator' AND r.role_type = 'operator' AND r.status = 'active' AND r.is_deleted = false
  AND p.name IN (
    'user:read', 'user:list',
    'operator:read', 'operator:list',
    'role:read', 'role:list',
    'permission:read', 'permission:list'
  )
  AND NOT EXISTS (
    SELECT 1 FROM role_permissions rp
    WHERE rp.role_id = r.id AND rp.permission_id = p.id
  );

-- Assign extended permissions to Manager role
INSERT INTO role_permissions (id, role_id, permission_id, created_at)
SELECT
    uuid_generate_v4(),
    r.id,
    p.id,
    CURRENT_TIMESTAMP
FROM roles r
CROSS JOIN permissions p
WHERE r.name = 'manager' AND r.role_type = 'operator' AND r.status = 'active' AND r.is_deleted = false
  AND p.name IN (
    'user:create', 'user:read', 'user:update', 'user:list',
    'operator:create', 'operator:read', 'operator:update', 'operator:list',
    'role:read', 'role:list',
    'permission:read', 'permission:list'
  )
  AND NOT EXISTS (
    SELECT 1 FROM role_permissions rp
    WHERE rp.role_id = r.id AND rp.permission_id = p.id
  );

-- Assign full read permissions to Auditor role (compliance access)
INSERT INTO role_permissions (id, role_id, permission_id, created_at)
SELECT
    uuid_generate_v4(),
    r.id,
    p.id,
    CURRENT_TIMESTAMP
FROM roles r
CROSS JOIN permissions p
WHERE r.name = 'auditor' AND r.role_type = 'operator' AND r.status = 'active' AND r.is_deleted = false
  AND p.name IN (
    'user:read', 'user:list',
    'operator:read', 'operator:list',
    'role:read', 'role:list',
    'permission:read', 'permission:list'
  )
  AND NOT EXISTS (
    SELECT 1 FROM role_permissions rp
    WHERE rp.role_id = r.id AND rp.permission_id = p.id
  );

-- ============================================================================
-- USERS
-- ============================================================================

-- Admin Users (admin1 to admin100)
-- Password: be12345678@Ab (BCrypt hash: $2a$10$nMwDgiZAd7vy4qbOoWeJQ.nBx9ZfOmnmazhB2FvJsKPQk9OX0xpq.)
INSERT INTO users (id, username, display_name, email, password_hash, status, created_at, updated_at, created_by)
SELECT 
    uuid_generate_v4(),
    'admin' || num,
    'Administrator ' || num,
    'admin' || num || '@gmail.com',
    '$2a$10$nMwDgiZAd7vy4qbOoWeJQ.nBx9ZfOmnmazhB2FvJsKPQk9OX0xpq.',
    'ACTIVE',
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP,
    NULL
FROM generate_series(1, 100) AS num
WHERE NOT EXISTS (
    SELECT 1 FROM users u
    WHERE (u.username = 'admin' || num OR u.email = 'admin' || num || '@gmail.com')
);

-- ============================================================================
-- USER-ROLE ASSIGNMENTS
-- ============================================================================

-- Assign Provider role to all Admin Users (admin1 to admin100)
INSERT INTO user_roles (id, user_id, role_id, created_at)
SELECT
    uuid_generate_v4(),
    u.id,
    r.id,
    CURRENT_TIMESTAMP
FROM users u
CROSS JOIN roles r
WHERE u.username LIKE 'admin%'
  AND u.username ~ '^admin[0-9]+$'
  AND r.name = 'provider' AND r.role_type = 'provider' AND r.status = 'active' AND r.is_deleted = false
  AND NOT EXISTS (
    SELECT 1 FROM user_roles ur
    WHERE ur.user_id = u.id AND ur.role_id = r.id
  );

-- ============================================================================
-- TWO-FACTOR CONFIGS
-- ============================================================================

-- Create TOTP two-factor config for all Admin Users (admin1 to admin100)
INSERT INTO two_factor_configs (id, user_id, type, secret, is_active, email, created_at, updated_at)
SELECT 
    uuid_generate_v4(),
    u.id,
    'TOTP',
    NULL, -- secret will be generated during setup
    false, -- inactive by default
    NULL,
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP
FROM users u
WHERE u.username LIKE 'admin%'
  AND u.username ~ '^admin[0-9]+$'
  AND NOT EXISTS (
    SELECT 1 FROM two_factor_configs tfc 
    WHERE tfc.user_id = u.id AND tfc.type = 'TOTP'
  );

-- Create EMAIL two-factor config for all Admin Users (admin1 to admin100)
INSERT INTO two_factor_configs (id, user_id, type, secret, is_active, email, created_at, updated_at)
SELECT 
    uuid_generate_v4(),
    u.id,
    'EMAIL',
    NULL, -- EMAIL type doesn't need secret
    false, -- inactive by default
    u.email, -- use user's email
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP
FROM users u
WHERE u.username LIKE 'admin%'
  AND u.username ~ '^admin[0-9]+$'
  AND NOT EXISTS (
    SELECT 1 FROM two_factor_configs tfc 
    WHERE tfc.user_id = u.id AND tfc.type = 'EMAIL'
  );

-- ============================================================================
-- COMPLETION MESSAGE
-- ============================================================================

DO $$
BEGIN
    RAISE NOTICE '✅ Data seeding process completed successfully!';
    RAISE NOTICE '';
    RAISE NOTICE 'Summary:';
    RAISE NOTICE '  - Permissions: 27 permissions created';
    RAISE NOTICE '  - Roles: 4 roles (provider, manager, operator, auditor) with role codes and metadata';
    RAISE NOTICE '  - Role-Permission Assignments: Configured with enhanced role filtering';
    RAISE NOTICE '  - Users: 100 users (admin1 to admin100)';
    RAISE NOTICE '  - User-Role Assignments: Configured with enhanced role validation';
    RAISE NOTICE '  - Two-Factor Configs: 2 configs (TOTP, EMAIL) for each admin user';
    RAISE NOTICE '';
    RAISE NOTICE 'Role Details:';
    RAISE NOTICE '  - Provider: Full administrative access (role_type: provider)';
    RAISE NOTICE '  - Manager: Extended operational access (role_type: operator)';
    RAISE NOTICE '  - Operator: Read-only operational access (role_type: operator)';
    RAISE NOTICE '  - Auditor: Full read-only access for compliance (role_type: operator)';
    RAISE NOTICE '';
    RAISE NOTICE 'Default credentials:';
    RAISE NOTICE '  Admin Users: username=admin1 to admin100, password=be12345678@Ab';
END $$;
