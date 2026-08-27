import React from 'react';
import {
  LayoutDashboard,
  ShoppingCart,
  Users,
  Package,
  WalletCards,
  Search,
  Sparkles,
  MapPin,
  Clock,
  ClipboardCheck,
  ShieldAlert,
  Calendar,
  FileText,
  Target,
  Activity,
  Network,
  Award,
  ChevronRight,
  Truck,
  AlertTriangle,
  Building2,
  Settings,
  Boxes
} from 'lucide-react';

export default function Sidebar({ user, currentTab, onSelectTab, isMobile, onCloseMobile }) {
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
      complianceItems.push({ id: 'org', label: 'Organization Chart', icon: Network });
    }

    complianceItems.push({ id: 'it_admin', label: 'Company Settings', icon: Settings });

    navSections = [
      {
        title: 'Core Operations',
        items: [
          { id: 'command_center', label: 'Executive Command Center', icon: LayoutDashboard },
          { id: 'supervisor_dashboard', label: 'Workforce 360 & Live Radar', icon: MapPin },
          { id: 'customers', label: 'Customer 360 Directory', icon: Building2 },
          { id: 'manifest', label: 'Field Routes & Geofencing', icon: CompassIcon }
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
  } else if (role === 'SALES_AGENT') {
    navSections = [
      {
        title: 'Commercial Field Sales',
        items: [
          { id: 'sales', label: 'Sales Orders & POS Cockpit', icon: ShoppingCart },
          { id: 'customers', label: 'Customer Outlets & 360', icon: Building2 },
          { id: 'manifest', label: 'Assigned Beat Route', icon: MapPin },
          { id: 'collections', label: 'Collections & Payments', icon: WalletCards },
          { id: 'reports', label: 'My Sales Performance', icon: FileText }
        ]
      }
    ];
  } else if (role === 'FIELD_AGENT') {
    navSections = [
      {
        title: 'Field Operations & Audits',
        items: [
          { id: 'manifest', label: 'Route Manifest & GPS', icon: MapPin },
          { id: 'customers', label: 'Assigned Stores & Audits', icon: Building2 },
          { id: 'delivery', label: 'Deliveries & POD Capture', icon: Truck },
          { id: 'safety', label: 'Emergency SOS', icon: ShieldAlert },
          { id: 'reports', label: 'My Attendance & Visits', icon: FileText }
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
          { id: 'payslip', label: 'Compensation & Payslips', icon: FileText }
        ]
      }
    ];
  }

  function CompassIcon(props) {
    return <MapPin {...props} />;
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
                    onSelectTab(item.id);
                    if (isMobile && onCloseMobile) onCloseMobile();
                  }}
                  className={`w-full flex items-center justify-between px-3 py-2 rounded-xl text-xs font-semibold transition group ${
                    isActive
                      ? 'bg-orange-500 text-white shadow-xs font-bold'
                      : 'text-zinc-600 dark:text-zinc-400 hover:bg-zinc-100 dark:hover:bg-zinc-800/60 hover:text-zinc-900 dark:hover:text-zinc-100'
                  }`}
                >
                  <div className="flex items-center gap-2.5">
                    <Icon size={16} className={`transition ${isActive ? 'text-white' : 'text-zinc-400 group-hover:text-zinc-700 dark:group-hover:text-zinc-300'}`} />
                    <span>{item.label}</span>
                  </div>
                  {isActive && <ChevronRight size={13} className="text-white/80" />}
                </button>
              );
            })}
          </div>
        ))}
      </div>

      <div className="p-3 border-t border-zinc-200 dark:border-zinc-800 text-[11px] text-zinc-400">
        <div className="flex items-center justify-between">
          <span className="font-semibold text-zinc-600 dark:text-zinc-300 truncate max-w-[150px]">{user?.full_name || 'Active User'}</span>
          <span className="text-[10px] uppercase font-bold px-1.5 py-0.5 rounded-md bg-zinc-100 dark:bg-zinc-800 text-zinc-500">{role || 'STAFF'}</span>
        </div>
      </div>
    </aside>
  );
}
