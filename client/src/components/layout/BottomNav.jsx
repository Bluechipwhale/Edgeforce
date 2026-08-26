import React from 'react';
import {
  LayoutDashboard,
  ShoppingCart,
  MapPin,
  Clock,
  ClipboardCheck,
  Calendar,
  Users,
  ShieldAlert,
  Sparkles
} from 'lucide-react';

export default function BottomNav({ user, currentTab, onSelectTab }) {
  const role = user?.role_code;

  let items = [];

  if (role === 'SALES_AGENT') {
    items = [
      { id: 'overview', label: 'Cockpit', icon: LayoutDashboard },
      { id: 'orders', label: 'POS', icon: ShoppingCart },
      { id: 'customers', label: 'Merchants', icon: Users },
      { id: 'copilot', label: 'Copilot', icon: Sparkles }
    ];
  } else if (role === 'FIELD_AGENT') {
    items = [
      { id: 'manifest', label: 'Routes', icon: MapPin },
      { id: 'shift', label: 'Shift', icon: Clock },
      { id: 'audits', label: 'Audits', icon: ClipboardCheck },
      { id: 'sos', label: 'SOS', icon: ShieldAlert, danger: true }
    ];
  } else if (['HR', 'CEO', 'CTO', 'MANAGER'].includes(role) || ['CEO', 'CTO', 'HR'].includes(user?.rank?.code)) {
    items = [
      { id: 'overview', label: 'Overview', icon: LayoutDashboard },
      { id: 'attendance', label: 'Attendance', icon: Clock },
      { id: 'leave', label: 'Leave', icon: Calendar },
      { id: 'people', label: 'Staff', icon: Users }
    ];
  } else {
    items = [
      { id: 'home', label: 'Home', icon: LayoutDashboard },
      { id: 'attendance', label: 'Clock', icon: Clock },
      { id: 'leave', label: 'Leave', icon: Calendar },
      { id: 'tasks', label: 'Tasks', icon: ClipboardCheck }
    ];
  }

  return (
    <nav className="lg:hidden fixed bottom-0 left-0 right-0 z-40 topbar-surface backdrop-blur-lg border-t border-zinc-200 dark:border-zinc-800 px-2 py-1.5 flex items-center justify-around">
      {items.map((item) => {
        const Icon = item.icon;
        const isActive = currentTab === item.id;
        return (
          <button
            key={item.id}
            onClick={() => onSelectTab(item.id)}
            className={`flex flex-col items-center justify-center py-1 px-3 rounded-lg text-[10px] font-bold transition ${
              item.danger
                ? 'text-rose-500'
                : isActive
                ? 'text-orange-600 dark:text-orange-400'
                : 'text-zinc-500 dark:text-zinc-400 hover:text-zinc-900 dark:hover:text-zinc-100'
            }`}
          >
            <Icon size={18} className={isActive ? 'scale-110 transition-transform' : ''} />
            <span className="mt-0.5">{item.label}</span>
          </button>
        );
      })}
    </nav>
  );
}
