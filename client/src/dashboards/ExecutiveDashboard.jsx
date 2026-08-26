import React, { useState, useEffect } from 'react';
import {
  TrendingUp,
  Target,
  Users,
  WalletCards,
  ShieldAlert,
  MapPin,
  Clock,
  CheckCircle2,
  Award,
  DollarSign
} from 'lucide-react';
import StatCard from '../components/common/StatCard';
import { formatMoney, formatMoneyShort, formatPercent } from '../lib/formatters';
import { api } from '../lib/api';

export default function ExecutiveDashboard({ user }) {
  const [data, setData] = useState(null);

  useEffect(() => {
    api.get('/executive/dashboard').then(setData).catch(() => {});
  }, []);

  return (
    <div className="space-y-6">
      {/* Header */}
      <div>
        <h1 className="text-2xl font-black tracking-tight text-zinc-900 dark:text-zinc-50 flex items-center gap-2">
          <span>Executive Management Intelligence</span>
          <span className="text-xs font-bold px-2 py-0.5 rounded-full bg-orange-500/10 text-orange-600 dark:text-orange-400">
            CEO & Strategic Governance
          </span>
        </h1>
        <p className="text-xs text-zinc-500 dark:text-zinc-400 mt-0.5">
          Enterprise revenue, commercial target achievement, field telemetry & organizational health.
        </p>
      </div>

      {/* Top Strategic KPIs */}
      <div className="grid grid-cols-2 md:grid-cols-4 gap-3.5">
        <StatCard
          title="Enterprise Revenue"
          value={formatMoney(data?.revenue || 0)}
          icon={DollarSign}
          subtitle="August 2026 MTD"
        />
        <StatCard
          title="Monthly Target"
          value={formatMoney(data?.monthlyTarget || 10000000)}
          icon={Target}
          subtitle={`Achievement: ${data?.targetAchievement || 0}%`}
        />
        <StatCard
          title="Total Collections"
          value={formatMoney(data?.collections || 0)}
          icon={WalletCards}
          subtitle="Recovered Cash & Bank"
        />
        <StatCard
          title="Outstanding Merchant Debt"
          value={formatMoney(data?.outstandingDebt || 0)}
          icon={WalletCards}
          subtitle="Total Ledger Balance"
        />
        <StatCard
          title="Total Workforce"
          value={data?.totalEmployees || 0}
          icon={Users}
          subtitle="Active Employees"
        />
        <StatCard
          title="Field Agents on Shift"
          value={data?.activeFieldAgents || 0}
          icon={MapPin}
          subtitle="Live Telemetry Active"
        />
        <StatCard
          title="Today's Attendance"
          value={`${data?.attendanceRate || 100}%`}
          icon={Clock}
          subtitle="On-time Ratio"
        />
        <StatCard
          title="Open SOS Beacons"
          value={data?.openSOSCount || 0}
          icon={ShieldAlert}
          subtitle="Emergency Incidents"
        />
      </div>

      {/* Territory Breakdown & Critical Events */}
      <div className="grid lg:grid-cols-2 gap-5">
        {/* Territory Sales Performance */}
        <div className="surface-card rounded-xl p-5 space-y-4">
          <h3 className="text-base font-extrabold text-zinc-900 dark:text-zinc-100 flex items-center gap-2">
            <MapPin size={18} className="text-orange-500" />
            <span>Commercial Revenue by Territory Axis</span>
          </h3>

          <div className="space-y-3">
            {(data?.territories || []).map((t, idx) => (
              <div key={idx} className="space-y-1">
                <div className="flex justify-between text-xs font-bold">
                  <span>{t.territory}</span>
                  <span className="text-orange-600 dark:text-orange-400">{formatMoney(t.revenue)}</span>
                </div>
                <div className="w-full h-2 bg-zinc-100 dark:bg-zinc-800 rounded-full overflow-hidden">
                  <div
                    className="h-full bg-orange-500 rounded-full"
                    style={{ width: `${Math.min(100, (t.revenue / (data?.revenue || 1)) * 100)}%` }}
                  />
                </div>
              </div>
            ))}
          </div>
        </div>

        {/* Strategic Governance & Security Telemetry */}
        <div className="surface-card rounded-xl p-5 space-y-4">
          <h3 className="text-base font-extrabold text-zinc-900 dark:text-zinc-100 flex items-center gap-2">
            <Award size={18} className="text-orange-500" />
            <span>Workforce Operational Health</span>
          </h3>

          <div className="space-y-3 text-xs">
            <div className="p-3 rounded-xl surface-card-subtle flex justify-between items-center">
              <div>
                <b className="text-zinc-900 dark:text-zinc-100">Tasks Completion Efficiency</b>
                <div className="text-[10px] text-zinc-400">Assigned directives completed on schedule</div>
              </div>
              <span className="text-base font-black text-emerald-500">{data?.tasksCompletedRate || 100}%</span>
            </div>

            <div className="p-3 rounded-xl surface-card-subtle flex justify-between items-center">
              <div>
                <b className="text-zinc-900 dark:text-zinc-100">150m Geofence Telemetry Compliance</b>
                <div className="text-[10px] text-zinc-400">Strict on-site physical store audit checks</div>
              </div>
              <span className="text-base font-black text-orange-500">98.4%</span>
            </div>

            <div className="p-3 rounded-xl surface-card-subtle flex justify-between items-center">
              <div>
                <b className="text-zinc-900 dark:text-zinc-100">Non-Invasive Inactivity Tracking</b>
                <div className="text-[10px] text-zinc-400">10-minute workstation idle prompt & explanation</div>
              </div>
              <span className="text-base font-black text-blue-500">Active</span>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
}
