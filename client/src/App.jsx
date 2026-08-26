import React, { useState, useEffect } from 'react';
import Shell from './components/layout/Shell';
import CommandCenterDashboard from './dashboards/CommandCenterDashboard';
import CustomerDirectoryDashboard from './dashboards/CustomerDirectoryDashboard';
import InventoryDashboard from './dashboards/InventoryDashboard';
import DeliveryDashboard from './dashboards/DeliveryDashboard';
import AlertCenterDashboard from './dashboards/AlertCenterDashboard';
import ReportsCenterDashboard from './dashboards/ReportsCenterDashboard';
import SalesDashboard from './dashboards/SalesDashboard';
import FieldDashboard from './dashboards/FieldDashboard';
import SupervisorDashboard from './dashboards/SupervisorDashboard';
import EmployeeDashboard from './dashboards/EmployeeDashboard';
import HRDashboard from './dashboards/HRDashboard';
import ExecutiveDashboard from './dashboards/ExecutiveDashboard';
import AccountingDashboard from './dashboards/AccountingDashboard';
import ITAdminDashboard from './dashboards/ITAdminDashboard';
import LoginPage from './pages/LoginPage';
import FirstLoginPasswordModal from './components/employee/FirstLoginPasswordModal';
import {
  LandingPage,
  AboutPage,
  FeaturesPage,
  PrivacyPage,
  TermsPage
} from './pages/PublicPages';
import { api } from './lib/api';

export default function App() {
  const [user, setUser] = useState(null);
  const [loading, setLoading] = useState(true);
  const [dark, setDark] = useState(() => {
    return localStorage.getItem('ewf_theme') === 'dark' ||
      (!('ewf_theme' in localStorage) && window.matchMedia('(prefers-color-scheme: dark)').matches);
  });
  const [publicPage, setPublicPage] = useState('landing');
  const [currentTab, setCurrentTab] = useState('command_center');

  // Handle Theme Toggle
  const handleToggleTheme = () => {
    setDark(prev => {
      const next = !prev;
      localStorage.setItem('ewf_theme', next ? 'dark' : 'light');
      if (next) {
        document.documentElement.classList.add('dark');
      } else {
        document.documentElement.classList.remove('dark');
      }
      return next;
    });
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
    if (role === 'FIELD_AGENT') return 'manifest';
    if (role === 'SALES_AGENT' || role === 'BRAND_AMBASSADOR' || role === 'PROMOTER') return 'sales';
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

  const handleLoginSuccess = (loggedInUser) => {
    setUser(loggedInUser);
    setCurrentTab(getDefaultTabForUser(loggedInUser));
  };

  const handleLogout = () => {
    localStorage.removeItem('ewf_token');
    setUser(null);
    setPublicPage('landing');
  };

  if (loading) {
    return (
      <div className="min-h-screen bg-zinc-950 flex flex-col items-center justify-center text-white space-y-4">
        <div className="w-10 h-10 border-3 border-orange-500 border-t-transparent rounded-full animate-spin" />
        <div className="text-xs font-bold uppercase tracking-wider text-zinc-400">
          Loading EdgeWForce OS…
        </div>
      </div>
    );
  }

  // Not authenticated -> Public Landing / Marketing / Auth Pages
  if (!user) {
    if (publicPage === 'login') {
      return (
        <LoginPage
          onLogin={handleLoginSuccess}
          onNavigatePublic={(p) => setPublicPage(p)}
        />
      );
    }
    if (publicPage === 'about') {
      return <AboutPage onNavigate={(p) => setPublicPage(p)} />;
    }
    if (publicPage === 'features') {
      return <FeaturesPage onNavigate={(p) => setPublicPage(p)} />;
    }
    if (publicPage === 'privacy') {
      return <PrivacyPage onNavigate={(p) => setPublicPage(p)} />;
    }
    if (publicPage === 'terms') {
      return <TermsPage onNavigate={(p) => setPublicPage(p)} />;
    }
    return <LandingPage onNavigate={(p) => setPublicPage(p)} />;
  }

  // Render Role & Feature Dashboards
  const renderDashboard = () => {
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
      case 'sos':
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
      case 'attendance':
      case 'idle':
      case 'leave':
      case 'tasks':
      case 'safety':
      case 'org':
        return <HRDashboard user={user} initialTab={currentTab} />;
      default:
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
        {renderDashboard()}
      </Shell>

      {/* First-Login Mandatory Password Change Enforcement Modal */}
      <FirstLoginPasswordModal
        user={user}
        isOpen={Boolean(user?.requires_password_change)}
        onPasswordChanged={(updatedUser) => {
          setUser(updatedUser);
        }}
      />
    </>
  );
}
