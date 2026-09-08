import React, { useState, useEffect } from 'react';
import Shell from './components/layout/Shell';
import LoginPage from './pages/LoginPage';
import FirstLoginPasswordModal from './components/employee/FirstLoginPasswordModal';
import GlobalAlertBanner from './components/layout/GlobalAlertBanner';

// Role & Feature Dashboards
import CommandCenterDashboard from './dashboards/CommandCenterDashboard';
import CustomerDirectoryDashboard from './dashboards/CustomerDirectoryDashboard';
import InventoryDashboard from './dashboards/InventoryDashboard';
import DeliveryDashboard from './dashboards/DeliveryDashboard';
import AlertCenterDashboard from './dashboards/AlertCenterDashboard';
import ReportsCenterDashboard from './dashboards/ReportsCenterDashboard';
import SupervisorDashboard from './dashboards/SupervisorDashboard';
import SalesDashboard from './dashboards/SalesDashboard';
import FieldDashboard from './dashboards/FieldDashboard';
import AccountingDashboard from './dashboards/AccountingDashboard';
import ExecutiveDashboard from './dashboards/ExecutiveDashboard';
import ITAdminDashboard from './dashboards/ITAdminDashboard';
import HRDashboard from './dashboards/HRDashboard';
import EmployeeDashboard from './dashboards/EmployeeDashboard';
import EmployeeProfileView from './components/employee/EmployeeProfileView';
import AgentSOSView from './components/field/AgentSOSView';

import { api } from './lib/api';

export default function App() {
  const [user, setUser] = useState(null);
  const [loading, setLoading] = useState(true);
  const [currentTab, setCurrentTab] = useState('dashboard');
  const [dark, setDark] = useState(() => {
    const saved = localStorage.getItem('ewf_theme');
    return saved ? saved === 'dark' : true;
  });

  // Check first-time login password change requirement
  const [mustChangePassword, setMustChangePassword] = useState(false);

  const handleToggleTheme = () => {
    const next = !dark;
    setDark(next);
    localStorage.setItem('ewf_theme', next ? 'dark' : 'light');
    if (next) {
      document.documentElement.classList.add('dark');
    } else {
      document.documentElement.classList.remove('dark');
    }
  };

  useEffect(() => {
    if (dark) {
      document.documentElement.classList.add('dark');
    } else {
      document.documentElement.classList.remove('dark');
    }
  }, [dark]);

  const getDefaultTabForUser = (u) => {
    if (!u) return 'dashboard';
    const role = u.role_code;
    const rank = u.rank?.code;
    if (role === 'SUPER_ADMIN' || role === 'ADMIN' || role === 'IT_ADMIN' || rank === 'IT_ADMIN' || u.email === 'admin@edgewforce.com') {
      return 'command_center';
    }
    if (role === 'SUPERVISOR') return 'supervisor_dashboard';
    if (['FIELD_AGENT', 'SALES_AGENT', 'BRAND_AMBASSADOR', 'PROMOTER'].includes(role)) {
      return 'manifest'; // Defaults directly to Field Routes & Geofencing
    }
    if (['CEO', 'CTO'].includes(role) || ['CEO', 'CTO'].includes(rank)) return 'command_center';
    if (['ACCOUNTANT', 'SENIOR_ACCOUNTANT'].includes(role)) return 'financials';
    if (role === 'HR' || role === 'HR_MANAGER' || rank === 'HR') return 'people';
    return 'dashboard';
  };

  // Load user session on mount
  useEffect(() => {
    const token = localStorage.getItem('ewf_token');
    if (token) {
      api.get('/auth/me')
        .then((res) => {
          setUser(res.user);
          setCurrentTab(getDefaultTabForUser(res.user));
        })
        .catch(() => {
          localStorage.removeItem('ewf_token');
          setUser(null);
        })
        .finally(() => setLoading(false));
    } else {
      setLoading(false);
    }
  }, []);

  const handleLoginSuccess = (userData) => {
    setUser(userData);
    setCurrentTab(getDefaultTabForUser(userData));
    if (userData.requires_password_change) {
      setMustChangePassword(true);
    }
  };

  const handleLogout = () => {
    localStorage.removeItem('ewf_token');
    setUser(null);
  };

  if (loading) {
    return (
      <div className="min-h-screen flex items-center justify-center surface-bg">
        <div className="flex flex-col items-center gap-3">
          <div className="w-8 h-8 border-3 border-orange-500 border-t-transparent rounded-full animate-spin" />
          <span className="text-xs font-semibold text-zinc-500">Initializing EdgeWForce Enterprise...</span>
        </div>
      </div>
    );
  }

  // Public/Auth Flows
  if (!user) {
    return <LoginPage onLogin={handleLoginSuccess} />;
  }

  // Render Role & Feature Dashboards with Strict Least-Privilege Routing Guards
  const renderDashboard = () => {
    const role = user?.role_code;
    const isAgent = ['FIELD_AGENT', 'SALES_AGENT', 'BRAND_AMBASSADOR', 'PROMOTER'].includes(role);

    // Field Agent: Full access to the brand new 8-module Field Force Interface
    if (role === 'FIELD_AGENT') {
      return <FieldDashboard user={user} initialTab={currentTab} onSelectTab={setCurrentTab} />;
    }

    // Other Operational Agents (Sales Agents, Promoters, Brand Ambassadors)
    if (isAgent) {
      const allowedAgentTabs = [
        'schedule',
        'manifest',
        'customer_360',
        'customers',
        'directory',
        'delivery',
        'fleet',
        'payments',
        'settlement',
        'collections',
        'alerts',
        'safety',
        'sos',
        'tasks',
        'queue'
      ];

      if (!allowedAgentTabs.includes(currentTab)) {
        return <FieldDashboard user={user} initialTab="manifest" onSelectTab={setCurrentTab} />;
      }

      switch (currentTab) {
        case 'schedule':
          return <EmployeeDashboard user={user} initialTab="schedule" />;
        case 'manifest':
          return <FieldDashboard user={user} initialTab="manifest" onSelectTab={setCurrentTab} />;
        case 'customer_360':
        case 'customers':
        case 'directory':
          return <CustomerDirectoryDashboard user={user} />;
        case 'delivery':
        case 'fleet':
          return <DeliveryDashboard user={user} />;
        case 'payments':
        case 'settlement':
        case 'collections':
          return <SalesDashboard user={user} initialTab="settlement" />;
        case 'alerts':
          return <AlertCenterDashboard user={user} />;
        case 'safety':
          case 'sos':
          return <AgentSOSView user={user} />;
        case 'tasks':
        case 'queue':
          return <EmployeeDashboard user={user} initialTab="tasks" />;
        default:
          return <FieldDashboard user={user} initialTab="manifest" onSelectTab={setCurrentTab} />;
      }
    }

    // Standard Non-Agent Workspaces (Management, HR, Staff, Supervisor)
    switch (currentTab) {
      case 'command_center':
        return <CommandCenterDashboard user={user} onNavigate={setCurrentTab} />;
      case 'customers':
      case 'directory':
        return <CustomerDirectoryDashboard user={user} />;
      case 'inventory':
        return <InventoryDashboard user={user} />;
      case 'delivery':
      case 'fleet':
        return <DeliveryDashboard user={user} />;
      case 'alerts':
        return <AlertCenterDashboard user={user} />;
      case 'reports':
        return <ReportsCenterDashboard user={user} />;
      case 'supervisor_dashboard':
        return <SupervisorDashboard user={user} />;
      case 'team_schedules':
        return <SupervisorDashboard user={user} initialTab="schedules" />;
      case 'sales':
      case 'orders':
      case 'catalog':
      case 'intel':
      case 'settlement':
      case 'payments':
        return <SalesDashboard user={user} />;
      case 'manifest':
      case 'shift':
      case 'audits':
        return <FieldDashboard user={user} />;
      case 'financials':
      case 'collections':
      case 'payroll':
        return <AccountingDashboard user={user} />;
      case 'executive':
        return <ExecutiveDashboard user={user} onNavigate={setCurrentTab} />;
      case 'it_admin':
        return <ITAdminDashboard user={user} onSelectTab={setCurrentTab} />;
      case 'overview':
      case 'people':
      case 'staff':
      case 'leave':
      case 'idle':
      case 'org':
      case 'organization':
      case 'announcements':
      case 'birthdays':
      case 'locations':
        return <HRDashboard user={user} initialTab={currentTab === 'staff' ? 'people' : currentTab === 'org' ? 'organization' : currentTab} />;
      case 'hr_schedules':
        return <HRDashboard user={user} initialTab="schedules" />;
      case 'schedule':
      case 'schedules':
        return <EmployeeDashboard user={user} initialTab="schedule" />;
      case 'staff_directory':
        return <EmployeeDashboard user={user} initialTab="directory" />;
      case 'profile':
        return <EmployeeProfileView user={user} />;
      case 'safety':
      case 'sos':
        return <HRDashboard user={user} initialTab="safety" />;
      default:
        return <EmployeeDashboard user={user} initialTab={currentTab} />;
    }
  };

  return (
    <>
      <Shell
        user={user}
        dark={dark}
        onToggleTheme={handleToggleTheme}
        onLogout={handleLogout}
        currentTab={currentTab}
        onSelectTab={setCurrentTab}
      >
        <GlobalAlertBanner />
        {renderDashboard()}
      </Shell>

      {/* Force Password Change on First-Time Access */}
      {mustChangePassword && (
        <FirstLoginPasswordModal
          user={user}
          onSuccess={() => {
            setMustChangePassword(false);
            setUser(prev => ({ ...prev, requires_password_change: false }));
          }}
        />
      )}
    </>
  );
}
