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
          { id: 'inventory', label: 'SKU Catalog & Stock', icon: Boxes },
          { id: 'collections', label: 'Collections & Payments', icon: WalletCards },
          { id: 'people', label: 'Staff Roster & Hierarchy', icon: Users },
          { id: 'org', label: 'Organization Structure', icon: Network },
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
          { id: 'people', label: 'Staff Roster & Hierarchy', icon: Users },
          { id: 'org', label: 'Organization Structure', icon: Network },
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
          { id: 'attendance', label: 'My Timesheet & GPS', icon: Clock },
          { id: 'leave', label: 'Leave Requests', icon: Calendar },
          { id: 'tasks', label: 'Assigned Tasks', icon: ClipboardCheck },
          { id: 'people', label: 'Staff Roster & Hierarchy', icon: Users },
          { id: 'org', label: 'Organization Structure', icon: Network },
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
                    if (isMobile) onCloseMobile?.();
                  }}
                  className={`w-full flex items-center justify-between px-3 py-2 rounded-xl text-xs font-semibold transition ${
                    isActive
                      ? 'bg-gradient-to-r from-orange-500 to-amber-500 text-white shadow-md shadow-orange-500/20'
                      : 'text-zinc-600 dark:text-zinc-400 hover:bg-zinc-100 dark:hover:bg-zinc-800/80 hover:text-zinc-900 dark:hover:text-zinc-100'
                  }`}
                >
                  <div className="flex items-center gap-2.5">
                    <Icon size={16} className={isActive ? 'text-white' : 'text-zinc-400'} />
                    <span>{item.label}</span>
                  </div>
                  {isActive && <ChevronRight size={14} className="text-white/80" />}
                </button>
              );
            })}
          </div>
        ))}
      </div>

      {/* Footer Identity Indicator */}
      <div className="p-3 border-t border-zinc-200 dark:border-zinc-800 bg-zinc-50/50 dark:bg-zinc-900/50">
        <div className="flex items-center gap-2 text-[11px] text-zinc-500 dark:text-zinc-400">
          <div className="w-2 h-2 rounded-full bg-emerald-500 animate-pulse" />
          <span className="font-semibold text-zinc-700 dark:text-zinc-300">Live Telemetry Active</span>
        </div>
        <div className="text-[10px] text-zinc-400 dark:text-zinc-500 mt-0.5 font-medium">
          (c) Nexfeild 2026 &bull; EdgeWForce OS
        </div>
      </div>
    </aside>

  );
}
