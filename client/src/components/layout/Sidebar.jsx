import React from 'react';
import {
  LayoutDashboard,
  ShoppingCart,
  Users,
  Package,
  WalletCards,
  MapPin,
  Clock,
  ClipboardCheck,
  ShieldAlert,
  Calendar,
  FileText,
  ChevronRight,
  Truck,
  AlertTriangle,
  Building2,
  Settings,
  Boxes,
  Bell,
  User,
  LogOut
} from 'lucide-react';

export default function Sidebar({ user, currentTab, onSelectTab, onLogout, isMobile, onCloseMobile }) {
  const role = user?.role_code;
  const rank = user?.rank?.code;

  const isManagement = ['SUPER_ADMIN', 'ADMIN', 'IT_ADMIN', 'CEO', 'CTO', 'HR_MANAGER', 'HR', 'MANAGER', 'SUPERVISOR', 'AGENT_ADMIN'].includes(role) ||
    ['IT_ADMIN', 'CEO', 'CTO', 'HR', 'MANAGER'].includes(rank) ||
    user?.email === 'admin@edgewforce.com';

  const isHROrIT = ['SUPER_ADMIN', 'ADMIN', 'IT_ADMIN', 'HR_MANAGER', 'HR'].includes(role) ||
    ['IT_ADMIN', 'HR'].includes(rank) ||
    user?.email === 'admin@edgewforce.com' ||
    user?.email === 'it@edgewforce.com' ||
    user?.email === 'hr@edgewforce.com';

  let navSections = [];

  if (isManagement) {
    const complianceItems = [
      { id: 'alerts', label: 'Alerts & Red Flag Center', icon: AlertTriangle },
      { id: 'reports', label: '15 Operational Reports', icon: FileText },
      { id: 'safety', label: 'Emergency SOS Queue', icon: ShieldAlert },
      { id: 'people', label: 'Staff Roster & Hierarchy', icon: Users }
    ];

    if (isHROrIT) {
      complianceItems.push({ id: 'org', label: 'Organization Chart', icon: Building2 });
    }

    complianceItems.push({ id: 'it_admin', label: 'Company Settings', icon: Settings });

    navSections = [
      {
        title: 'Core Operations',
        items: [
          { id: 'command_center', label: 'Executive Command Center', icon: LayoutDashboard },
          { id: 'supervisor_dashboard', label: 'Workforce 360 & Live Radar', icon: MapPin },
          { id: 'customers', label: 'Customer 360 Directory', icon: Building2 },
          { id: 'manifest', label: 'Field Routes & Geofencing', icon: MapPin }
        ]
      },
      {
        title: 'Commerce & Logistics',
        items: [
          { id: 'sales', label: 'Sales Cockpit & POS', icon: ShoppingCart },
          { id: 'inventory', label: 'Inventory & Warehouses', icon: Boxes },
          { id: 'delivery', label: 'Fleet & Proof of Delivery', icon: Truck },
          { id: 'financials', label: 'Collections & Ledger', icon: WalletCards }
        ]
      },
      {
        title: 'Compliance & Intelligence',
        items: complianceItems
      }
    ];
  } else if (role === 'SALES_AGENT' || role === 'BRAND_AMBASSADOR' || role === 'PROMOTER') {
    // Strict Least-Privilege Sales Agent Menu: 11 approved items only
    navSections = [
      {
        title: 'Sales Operations',
        items: [
          { id: 'dashboard', label: 'Dashboard', icon: LayoutDashboard },
          { id: 'attendance', label: 'Attendance', icon: Clock },
          { id: 'tasks', label: 'Tasks', icon: ClipboardCheck },
          { id: 'manifest', label: 'Visits / Routes', icon: MapPin },
          { id: 'customers', label: 'Customers / Stores', icon: Building2 },
          { id: 'sales', label: 'Sales', icon: ShoppingCart },
          { id: 'notifications', label: 'Notifications', icon: Bell },
          { id: 'safety', label: 'SOS / Emergency', icon: ShieldAlert },
          { id: 'profile', label: 'My Profile', icon: User },
          { id: 'logout', label: 'Logout', icon: LogOut, action: 'logout' }
        ]
      }
    ];
  } else if (role === 'FIELD_AGENT') {
    // Strict Least-Privilege Field Agent Menu: 11 approved items only
    navSections = [
      {
        title: 'Field Operations',
        items: [
          { id: 'dashboard', label: 'Dashboard', icon: LayoutDashboard },
          { id: 'attendance', label: 'Attendance', icon: Clock },
          { id: 'tasks', label: 'Tasks', icon: ClipboardCheck },
          { id: 'manifest', label: 'Visits / Routes', icon: MapPin },
          { id: 'customers', label: 'Customers / Stores', icon: Building2 },
          { id: 'audits', label: 'Field Audit', icon: ClipboardCheck },
          { id: 'notifications', label: 'Notifications', icon: Bell },
          { id: 'safety', label: 'SOS / Emergency', icon: ShieldAlert },
          { id: 'profile', label: 'My Profile', icon: User },
          { id: 'logout', label: 'Logout', icon: LogOut, action: 'logout' }
        ]
      }
    ];
  } else {
    // Default Corporate Staff
    navSections = [
      {
        title: 'Employee Workspace',
        items: [
          { id: 'dashboard', label: 'Workspace Dashboard', icon: LayoutDashboard },
          { id: 'inventory', label: 'Inventory & Stock Records', icon: Boxes },
          { id: 'attendance', label: 'My Timesheet & GPS', icon: Clock },
          { id: 'leave', label: 'Leave Requests', icon: Calendar },
          { id: 'tasks', label: 'Assigned Tasks', icon: ClipboardCheck },
          { id: 'payslip', label: 'Compensation & Payslips', icon: FileText },
          { id: 'profile', label: 'My Profile', icon: User },
          { id: 'logout', label: 'Logout', icon: LogOut, action: 'logout' }
        ]
      }
    ];
  }

  return (
    <aside className={`w-64 border-r border-zinc-200 dark:border-zinc-800 flex flex-col justify-between surface-card select-none ${
      isMobile ? 'h-full' : 'h-[calc(100vh-53px)] sticky top-[53px]'
    }`}>
      <div className="p-3 overflow-y-auto flex-1 space-y-5">
        {navSections.map((sec, idx) => (
          <div key={idx} className="space-y-1">
            <div className="px-3 text-[10px] font-bold uppercase tracking-wider text-zinc-400 dark:text-zinc-500 mb-1.5">
              {sec.title}
            </div>
            {sec.items.map((item) => {
              const Icon = item.icon;
              const isActive = currentTab === item.id;
              return (
                <button
                  key={item.id}
                  onClick={() => {
                    if (item.action === 'logout') {
                      onLogout?.();
                    } else {
                      onSelectTab(item.id);
                    }
                    if (isMobile && onCloseMobile) onCloseMobile();
                  }}
                  className={`w-full flex items-center justify-between px-3 py-2 rounded-xl text-xs font-semibold transition group ${
                    item.id === 'safety' && role?.includes('AGENT')
                      ? 'text-rose-600 dark:text-rose-400 hover:bg-rose-500/10'
                      : isActive
                      ? 'bg-orange-500 text-white shadow-xs font-bold'
                      : 'text-zinc-600 dark:text-zinc-400 hover:bg-zinc-100 dark:hover:bg-zinc-800/60 hover:text-zinc-900 dark:hover:text-zinc-100'
                  }`}
                >
                  <div className="flex items-center gap-2.5">
                    <Icon size={16} className={`transition ${
                      isActive
                        ? 'text-white'
                        : item.id === 'safety'
                        ? 'text-rose-500'
                        : 'text-zinc-400 group-hover:text-zinc-700 dark:group-hover:text-zinc-300'
                    }`} />
                    <span>{item.label}</span>
                  </div>
                  {isActive && <ChevronRight size={13} className="text-white/80" />}
                </button>
              );
            })}
          </div>
        ))}
      </div>

      <div className="p-3 border-t border-zinc-200 dark:border-zinc-800 text-[11px] text-zinc-400 space-y-1.5">
        <div className="flex items-center justify-between">
          <span className="font-semibold text-zinc-600 dark:text-zinc-300 truncate max-w-[140px]">{user?.full_name || 'Active User'}</span>
          <span className="text-[9px] uppercase font-bold px-1.5 py-0.5 rounded-md bg-zinc-100 dark:bg-zinc-800 text-zinc-500">{role || 'STAFF'}</span>
        </div>
        <div className="text-[10px] text-zinc-400 dark:text-zinc-500 font-medium">
          &copy; Nexfeild. edgewforce.com
        </div>
      </div>
    </aside>
  );
}
