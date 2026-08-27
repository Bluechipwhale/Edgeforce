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
    return saved ? saved === 'dark' : false;
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
    if (role === 'FIELD_AGENT') return 'dashboard';
    if (role === 'SALES_AGENT' || role === 'BRAND_AMBASSADOR' || role === 'PROMOTER') return 'dashboard';
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
    const isFieldAgent = role === 'FIELD_AGENT';
    const isSalesAgent = role === 'SALES_AGENT' || role === 'BRAND_AMBASSADOR' || role === 'PROMOTER';
    const isAgent = isFieldAgent || isSalesAgent;

    // Strict confinement: Guard Agents from accessing admin, hr, settings, executive, or inventory workspaces
    if (isAgent && ['inventory', 'it_admin', 'executive', 'financials', 'payroll', 'overview', 'people', 'idle', 'org', 'command_center', 'supervisor_dashboard'].includes(currentTab)) {
      if (isFieldAgent) return <FieldDashboard user={user} />;
      return <SalesDashboard user={user} />;
    }

    // Guard Field Agents from accessing sales cockpit
    if (isFieldAgent && ['sales', 'orders', 'catalog', 'intel', 'settlement'].includes(currentTab)) {
      return <FieldDashboard user={user} />;
    }

    // Profile Tab
    if (currentTab === 'profile') {
      return <EmployeeProfileView user={user} />;
    }

    // Safety / Emergency SOS Tab
    if (currentTab === 'safety' || currentTab === 'sos') {
      if (isAgent) {
        return <AgentSOSView user={user} />;
      }
      return <HRDashboard user={user} initialTab="safety" />;
    }

    // Attendance Tab for Field & Sales Agents
    if (currentTab === 'attendance') {
      if (isFieldAgent) return <FieldDashboard user={user} initialTab="shift" />;
      if (isSalesAgent) return <SalesDashboard user={user} initialTab="attendance" />;
      return <EmployeeDashboard user={user} initialTab="attendance" />;
    }

    // Tasks Tab
    if (currentTab === 'tasks') {
      return <EmployeeDashboard user={user} initialTab="tasks" />;
    }

    switch (currentTab) {
      case 'command_center':
        return <CommandCenterDashboard user={user} onNavigate={setCurrentTab} />;
      case 'customers':
        return <CustomerDirectoryDashboard user={user} />;
      case 'inventory':
        return <InventoryDashboard user={user} />;
      case 'delivery':
        return <DeliveryDashboard user={user} />;
      case 'alerts':
        return <AlertCenterDashboard user={user} />;
      case 'reports':
        return <ReportsCenterDashboard user={user} />;
      case 'supervisor_dashboard':
        return <SupervisorDashboard user={user} />;
      case 'sales':
      case 'orders':
      case 'catalog':
      case 'intel':
      case 'settlement':
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
        return <ExecutiveDashboard user={user} />;
      case 'it_admin':
        return <ITAdminDashboard user={user} onSelectTab={setCurrentTab} />;
      case 'overview':
      case 'people':
      case 'leave':
      case 'idle':
      case 'org':
        return <HRDashboard user={user} initialTab={currentTab} />;
      default:
        if (isFieldAgent) return <FieldDashboard user={user} />;
        if (isSalesAgent) return <SalesDashboard user={user} />;
        return <EmployeeDashboard user={user} />;
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
