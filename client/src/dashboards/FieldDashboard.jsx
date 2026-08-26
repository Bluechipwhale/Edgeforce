import React, { useState, useEffect } from 'react';
import {
  MapPin, Clock, Navigation, ShieldAlert, CheckCircle2, AlertTriangle,
  ClipboardCheck, Phone, MessageCircle, Play, Square, ChevronRight,
  Store, Camera, Plus, RefreshCw, Layers, Compass, ExternalLink, Globe, Sparkles
} from 'lucide-react';
import FieldMap from '../components/maps/FieldMap';
import VisitAuditModal from '../components/field/VisitAuditModal';
import StoreRequestModal from '../components/field/StoreRequestModal';
import StoreVisitModal from '../components/field/StoreVisitModal';
import SOSModal from '../components/field/SOSModal';
import SenriVisitWorkflow from '../components/field/SenriVisitWorkflow';
import GeoLocationReportView from '../components/field/GeoLocationReportView';
import { getCurrentGPSLocation, calculateClientDistance } from '../lib/geo';
import { getWhatsAppDeepLink, getGoogleMapsDirLink, formatTime } from '../lib/formatters';
import { apiRequest } from '../utils/api';

export default function FieldDashboard({ user }) {
  const [activeView, setActiveView] = useState('field_cockpit'); // 'field_cockpit', 'manifest', 'geolocation'
  const [route, setRoute] = useState([]);
  const [shift, setShift] = useState(null);
  const [windowStatus, setWindowStatus] = useState(null);
  const [stores, setStores] = useState([]);

  const [agentLocation, setAgentLocation] = useState(null);
  const [activeAuditVisit, setActiveAuditVisit] = useState(null);
  const [sosModalOpen, setSOSModalOpen] = useState(false);
  const [isStoreRequestModalOpen, setIsStoreRequestModalOpen] = useState(false);
  const [isStoreVisitModalOpen, setIsStoreVisitModalOpen] = useState(false);
  const [selectedStoreForVisit, setSelectedStoreForVisit] = useState(null);


  const [shiftLoading, setShiftLoading] = useState(false);
  const [statusMsg, setStatusMsg] = useState('');
  const [errorMsg, setErrorMsg] = useState('');
  const [elapsedWorkingSeconds, setElapsedWorkingSeconds] = useState(0);

  const loadData = async () => {
    try {
      const [manifestRes, curShiftRes, storesRes, windowRes] = await Promise.all([
        apiRequest('/field/route-manifest').catch(() => ({ data: [] })),
        apiRequest('/field/shifts/current').catch(() => ({ data: null })),
        apiRequest('/field/stores').catch(() => ({ data: [] })),
        apiRequest('/field/shifts/window-status').catch(() => ({ data: null }))
      ]);

      setRoute(manifestRes.data || manifestRes.manifest || []);
      setShift(curShiftRes.data || curShiftRes.shift || null);
      setStores(storesRes.data || storesRes.stores || []);
      setWindowStatus(windowRes.data || windowRes || null);
    } catch (err) {
      console.error('Failed to load field data:', err);
    }
  };


  useEffect(() => {
    loadData();

    // Watch live GPS location
    let watchId = null;
    if (navigator.geolocation) {
      watchId = navigator.geolocation.watchPosition(
        (pos) => {
          setAgentLocation({
            latitude: pos.coords.latitude,
            longitude: pos.coords.longitude,
            accuracy: pos.coords.accuracy
          });
        },
        () => {},
        { enableHighAccuracy: true }
      );
    }
    return () => {
      if (watchId) navigator.geolocation.clearWatch(watchId);
    };
  }, []);

  // Periodic Telemetry Ping during active shift
  useEffect(() => {
    if (!shift?.clock_in_time || shift?.clock_out_time) return;

    const sendPing = async () => {
      if (!agentLocation) return;
      try {
        await apiRequest('/field/location-ping', 'POST', {
          latitude: agentLocation.latitude,
          longitude: agentLocation.longitude,
          accuracy: agentLocation.accuracy,
          current_activity: 'Store Route Patrol'
        });
      } catch (err) {
        console.warn('Location telemetry ping:', err.message);
      }
    };

    const interval = setInterval(sendPing, 45000); // 45 seconds ping
    return () => clearInterval(interval);
  }, [shift, agentLocation]);

  // Working Duration Timer
  useEffect(() => {
    const clockInVal = shift?.clock_in || shift?.clock_in_time;
    const clockOutVal = shift?.clock_out || shift?.clock_out_time;
    if (!clockInVal || clockOutVal) {
      setElapsedWorkingSeconds(0);
      return;
    }

    const inTime = new Date(clockInVal).getTime();
    const updateElapsed = () => {
      const now = Date.now();
      setElapsedWorkingSeconds(Math.max(0, Math.floor((now - inTime) / 1000)));
    };

    updateElapsed();
    const timer = setInterval(updateElapsed, 1000);
    return () => clearInterval(timer);
  }, [shift]);

  const formatElapsed = (seconds) => {
    const h = Math.floor(seconds / 3600);
    const m = Math.floor((seconds % 3600) / 60);
    const s = seconds % 60;
    return `${h}h ${String(m).padStart(2, '0')}m ${String(s).padStart(2, '0')}s`;
  };

  const handleToggleShift = async () => {
    setShiftLoading(true);
    setStatusMsg('');
    setErrorMsg('');
    try {
      let lat = agentLocation?.latitude;
      let lng = agentLocation?.longitude;

      if (!lat || !lng) {
        const p = await getCurrentGPSLocation();
        lat = p.latitude;
        lng = p.longitude;
        setAgentLocation(p);
      }

      const res = await apiRequest('/field/shifts/toggle', 'POST', {
        latitude: lat,
        longitude: lng,
        device: navigator.userAgent
      });

      setShift(res.data || res);
      setStatusMsg(res.clock_out_time || res.data?.clock_out_time ? `✓ Shift concluded. Total working time logged.` : '✓ Shift started. 150m Geofence and GPS Telemetry active.');
      loadData();
    } catch (err) {
      setErrorMsg(err.message || 'Shift action failed');
    } finally {
      setShiftLoading(false);
    }
  };

  const handleCheckIn = async (visit) => {
    setStatusMsg('');
    setErrorMsg('');
    try {
      let loc = agentLocation;
      if (!loc) {
        loc = await getCurrentGPSLocation();
        setAgentLocation(loc);
      }

      const res = await apiRequest('/field/visits/check-in', 'POST', {
        visit_id: visit.id,
        latitude: loc.latitude,
        longitude: loc.longitude
      });

      setStatusMsg(`Checked in successfully! (${res.geofence?.distanceMeters?.toFixed(1) || '0'}m from outlet)`);
      setActiveAuditVisit(res.data || res);
      loadData();
    } catch (err) {
      setErrorMsg(err.message || 'Geofence check-in failed');
    }
  };

  const isShiftActive = shift?.clock_in_time && !shift?.clock_out_time;

  return (
    <div className="space-y-5">
      {/* Mobile Header with SOS Beacon & Store Request Button */}
      <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-3">
        <div>
          <h1 className="text-xl sm:text-2xl font-black tracking-tight text-zinc-900 dark:text-zinc-50">
            Field Operations Cockpit
          </h1>
          <p className="text-xs text-zinc-500 dark:text-zinc-400">
            GPS shift telemetry, 150m geofencing, route manifest & store audits
          </p>
        </div>

        <div className="flex items-center gap-2">
          <button
            type="button"
            onClick={() => setIsStoreRequestModalOpen(true)}
            className="px-3.5 py-2 bg-white dark:bg-zinc-800 hover:bg-zinc-100 dark:hover:bg-zinc-700 text-zinc-800 dark:text-zinc-200 border border-zinc-300 dark:border-zinc-700 rounded-xl text-xs font-bold shadow-xs transition-all flex items-center gap-1.5"
          >
            <Plus className="w-3.5 h-3.5 text-primary" />
            Register Store
          </button>

          <button
            onClick={() => setSOSModalOpen(true)}
            className="btn-sos text-xs py-2 px-3 shadow-lg"
          >
            <ShieldAlert size={16} />
            <span>SOS BEACON</span>
          </button>
        </div>
      </div>

      {/* GPS Shift Banner with Live Duration Timer */}
      <div className={`p-4.5 rounded-2xl border transition-all ${
        isShiftActive
          ? 'bg-gradient-to-r from-emerald-600/15 via-emerald-500/10 to-teal-500/15 border-emerald-500/30'
          : 'surface-card border-zinc-200 dark:border-zinc-800'
      }`}>
        <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-4">
          <div className="flex items-center gap-3">
            <div className={`w-12 h-12 rounded-2xl flex items-center justify-center font-bold text-white shadow-xs ${
              windowStatus?.window_info?.allowed ? 'bg-emerald-600' : 'bg-zinc-700'
            }`}>
              <Clock size={24} />
            </div>
            <div>
              <div className="flex items-center gap-2">
                <span className="text-[10px] font-extrabold uppercase tracking-wider text-zinc-400">
                  Smart Shift Attendance
                </span>
                <span className={`px-2 py-0.5 rounded-full text-[10px] font-bold ${
                  windowStatus?.window_info?.allowed
                    ? 'bg-emerald-500 text-white'
                    : 'bg-amber-500/20 text-amber-600 dark:text-amber-400 border border-amber-500/30'
                }`}>
                  {windowStatus?.window_info?.label || (isShiftActive ? 'SHIFT ACTIVE' : 'ATTENDANCE STANDBY')}
                </span>
                {windowStatus?.lagos_time && (
                  <span className="text-[10px] text-zinc-500 dark:text-zinc-400 font-mono">
                    Lagos: {windowStatus.lagos_time.formatted12h}
                  </span>
                )}
              </div>
              <div className="text-sm font-black text-zinc-900 dark:text-zinc-100 mt-0.5 flex items-center gap-2">
                {windowStatus?.window_info?.allowed ? (
                  <span className="text-emerald-600 dark:text-emerald-400 font-bold">
                    ✓ {windowStatus.window_info.message}
                  </span>
                ) : (
                  <span className="text-zinc-500 dark:text-zinc-400">
                    {windowStatus?.window_info?.message || 'Attendance window closed.'}
                  </span>
                )}
              </div>
              {agentLocation && (
                <div className="text-[10px] text-zinc-500 font-mono mt-0.5">
                  GPS: {agentLocation.latitude.toFixed(5)}, {agentLocation.longitude.toFixed(5)} (±{Math.round(agentLocation.accuracy)}m)
                </div>
              )}
            </div>
          </div>

          <button
            onClick={handleToggleShift}
            disabled={shiftLoading || (!isShiftActive && !windowStatus?.window_info?.allowed)}
            className={`btn-primary font-bold text-xs py-2.5 px-5 whitespace-nowrap shadow-md transition ${
              !isShiftActive && !windowStatus?.window_info?.allowed
                ? 'opacity-60 bg-zinc-700 cursor-not-allowed text-zinc-300'
                : (isShiftActive || windowStatus?.window_info?.action_type === 'CLOCK_OUT'
                  ? 'bg-purple-600 hover:bg-purple-500 text-white shadow-purple-500/20 ring-2 ring-purple-400'
                  : 'bg-emerald-600 hover:bg-emerald-500 text-white shadow-emerald-500/20')
            }`}
          >
            {isShiftActive || windowStatus?.window_info?.action_type === 'CLOCK_OUT' ? <Square size={14} /> : <Play size={14} />}
            <span>{isShiftActive ? 'CLOCK OUT / CONCLUDE SHIFT' : (windowStatus?.window_info?.button_label || 'START SHIFT')}</span>
          </button>
        </div>

        {statusMsg && (
          <div className="mt-3 p-2.5 rounded-xl bg-emerald-500/15 border border-emerald-500/30 text-emerald-600 dark:text-emerald-400 text-xs font-bold flex items-center gap-2">
            <CheckCircle2 size={15} />
            <span>{statusMsg}</span>
          </div>
        )}

        {errorMsg && (
          <div className="mt-3 p-2.5 rounded-xl bg-rose-500/15 border border-rose-500/30 text-rose-600 dark:text-rose-400 text-xs font-bold flex items-center gap-2">
            <AlertTriangle size={15} />
            <span>{errorMsg}</span>
          </div>
        )}
      </div>

      {/* Mode View Switcher: Field Operations Cockpit vs Beat Route Manifest vs Geo-Location Report */}
      <div className="flex items-center gap-2 border-b border-zinc-200 dark:border-zinc-800 pb-2 text-xs font-bold overflow-x-auto">
        <button
          type="button"
          onClick={() => setActiveView('field_cockpit')}
          className={`px-4 py-2 rounded-xl transition flex items-center gap-2 whitespace-nowrap ${
            activeView === 'field_cockpit'
              ? 'bg-orange-500 text-white shadow-xs'
              : 'bg-zinc-100 dark:bg-zinc-800 text-zinc-600 dark:text-zinc-400 hover:bg-zinc-200'
          }`}
        >
          <Store size={15} />
          <span>Field Operations Cockpit & GPS</span>
        </button>

        <button
          type="button"
          onClick={() => setActiveView('manifest')}
          className={`px-4 py-2 rounded-xl transition flex items-center gap-2 whitespace-nowrap ${
            activeView === 'manifest'
              ? 'bg-orange-500 text-white shadow-xs'
              : 'bg-zinc-100 dark:bg-zinc-800 text-zinc-600 dark:text-zinc-400 hover:bg-zinc-200'
          }`}
        >
          <MapPin size={15} />
          <span>Beat Route Manifest & GPS Map ({route.length})</span>
        </button>

        <button
          type="button"
          onClick={() => setActiveView('geolocation')}
          className={`px-4 py-2 rounded-xl transition flex items-center gap-2 whitespace-nowrap ${
            activeView === 'geolocation'
              ? 'bg-orange-500 text-white shadow-xs'
              : 'bg-zinc-100 dark:bg-zinc-800 text-zinc-600 dark:text-zinc-400 hover:bg-zinc-200'
          }`}
        >
          <Globe size={15} />
          <span>Geo-Location & Shift Report</span>
        </button>
      </div>

      {/* View 1: Field Operations Cockpit & Location Intelligence */}
      {activeView === 'field_cockpit' && (
        <SenriVisitWorkflow user={user} onVisitCompleted={loadData} />
      )}

      {/* View 3: Geo-Location Telemetry & Shift Report */}
      {activeView === 'geolocation' && (
        <GeoLocationReportView user={user} defaultRoleFilter="FIELD_AGENT" />
      )}


      {/* View 2: Interactive Map & Route Overview */}
      {activeView === 'manifest' && (
        <>
          <div className="grid lg:grid-cols-3 gap-5">
            <div className="lg:col-span-2">
              <FieldMap
                route={route}
                agentLocation={agentLocation}
                height="380px"
              />
            </div>


        {/* Operational Guidelines & Route Metrics */}
        <div className="surface-card rounded-2xl p-5 space-y-3.5 flex flex-col justify-between border border-zinc-200 dark:border-zinc-800">
          <div>
            <h3 className="text-sm font-extrabold text-zinc-900 dark:text-zinc-100 flex items-center gap-2">
              <ClipboardCheck size={16} className="text-primary" />
              <span>150m Geofence Compliance</span>
            </h3>
            <ul className="mt-3 space-y-2 text-xs text-zinc-600 dark:text-zinc-400">
              <li className="flex items-start gap-2">
                <div className="w-1.5 h-1.5 rounded-full bg-primary mt-1.5 shrink-0" />
                <span><b>Strict 150m Radius:</b> Check-in is validated against verified store coordinates.</span>
              </li>
              <li className="flex items-start gap-2">
                <div className="w-1.5 h-1.5 rounded-full bg-primary mt-1.5 shrink-0" />
                <span><b>Mandatory Photo Evidence:</b> Upload shelf / store photo to complete audit.</span>
              </li>
              <li className="flex items-start gap-2">
                <div className="w-1.5 h-1.5 rounded-full bg-primary mt-1.5 shrink-0" />
                <span><b>Digital Sign-off:</b> Customer signature verified on HTML5 canvas.</span>
              </li>
            </ul>
          </div>

          <div className="p-3 rounded-xl surface-card-subtle flex justify-around text-center text-xs border border-zinc-200 dark:border-zinc-800">
            <div>
              <div className="text-lg font-black text-zinc-900 dark:text-zinc-100">{route.length}</div>
              <div className="text-[10px] text-zinc-400">Total Stops</div>
            </div>
            <div>
              <div className="text-lg font-black text-emerald-500">
                {route.filter(r => r.status === 'completed').length}
              </div>
              <div className="text-[10px] text-zinc-400">Completed</div>
            </div>
            <div>
              <div className="text-lg font-black text-amber-500">
                {route.filter(r => r.status !== 'completed').length}
              </div>
              <div className="text-[10px] text-zinc-400">Pending</div>
            </div>
          </div>
        </div>
      </div>

      {/* Daily Route Manifest Stops */}
      <div className="surface-card rounded-2xl p-5 space-y-4 border border-zinc-200 dark:border-zinc-800">
        <div className="flex items-center justify-between">
          <h3 className="text-base font-extrabold text-zinc-900 dark:text-zinc-100 flex items-center gap-2">
            <MapPin size={18} className="text-primary" />
            <span>Daily Assigned Route Manifest & Store Audits</span>
          </h3>
          <span className="text-xs text-zinc-500">{route.length} Assigned Stops</span>
        </div>

        <div className="space-y-3">
          {route.map((stop, idx) => {
            const isCompleted = stop.status === 'completed';
            const isInProgress = stop.status === 'in_progress';

            const distMeters = (agentLocation && stop.customer?.latitude)
              ? calculateClientDistance(agentLocation.latitude, agentLocation.longitude, stop.customer.latitude, stop.customer.longitude)
              : null;

            const isWithin150m = distMeters !== null && distMeters <= (stop.customer?.geofence_radius || 150);

            return (
              <div
                key={stop.id}
                className={`p-4 rounded-xl border transition flex flex-col md:flex-row md:items-center justify-between gap-4 ${
                  isCompleted
                    ? 'surface-card opacity-80 border-zinc-200 dark:border-zinc-800'
                    : isInProgress
                    ? 'surface-card border-primary shadow-md ring-1 ring-primary/20'
                    : 'surface-card-subtle border-zinc-200 dark:border-zinc-800'
                }`}
              >
                <div className="flex items-start gap-3">
                  <div className={`w-8 h-8 rounded-full flex items-center justify-center font-black text-xs text-white shrink-0 ${
                    isCompleted ? 'bg-emerald-500' : (stop.priority === 'URGENT' ? 'bg-red-500' : 'bg-primary')
                  }`}>
                    {idx + 1}
                  </div>

                  <div>
                    <div className="flex items-center gap-2">
                      <h4 className="font-bold text-sm text-zinc-900 dark:text-zinc-100">
                        {stop.customer?.name || `Outlet #${stop.id}`}
                      </h4>
                      <span className={`text-[10px] font-bold px-1.5 py-0.5 rounded ${
                        stop.priority === 'URGENT' ? 'bg-red-500/10 text-red-500' : 'bg-orange-500/10 text-primary'
                      }`}>
                        {stop.priority || 'NORMAL'}
                      </span>
                      {isCompleted && (
                        <span className="text-[10px] font-bold px-1.5 py-0.5 rounded bg-emerald-500/10 text-emerald-500">
                          AUDIT COMPLETED
                        </span>
                      )}
                    </div>

                    <div className="text-xs text-zinc-500 dark:text-zinc-400 mt-0.5">
                      {stop.customer?.address || 'Lagos territory stop'}
                    </div>

                    {distMeters !== null && (
                      <div className={`text-[11px] font-bold mt-1 flex items-center gap-1.5 ${
                        isWithin150m ? 'text-emerald-500' : 'text-zinc-400'
                      }`}>
                        <MapPin size={13} />
                        <span>Distance: ~{Math.round(distMeters)}m {isWithin150m ? '(Inside 150m Geofence)' : `(Outside ${stop.customer?.geofence_radius || 150}m Radius)`}</span>
                      </div>
                    )}
                  </div>
                </div>

                {/* Stop Actions */}
                <div className="flex flex-wrap items-center gap-2">
                  {stop.customer?.latitude && (
                    <a
                      href={getGoogleMapsDirLink(stop.customer.latitude, stop.customer.longitude)}
                      target="_blank"
                      rel="noreferrer"
                      className="btn-secondary text-xs py-1.5 px-3"
                    >
                      <Navigation size={13} />
                      <span>Directions</span>
                    </a>
                  )}

                  {stop.customer?.phone && (
                    <a
                      href={getWhatsAppDeepLink(stop.customer.phone, 'Good day from EdgeWForce field team.')}
                      target="_blank"
                      rel="noreferrer"
                      className="btn-secondary text-xs py-1.5 px-3 text-emerald-500"
                    >
                      <MessageCircle size={13} />
                      <span>WhatsApp</span>
                    </a>
                  )}

                  {stop.status === 'scheduled' ? (
                    <button
                      onClick={() => handleCheckIn(stop)}
                      className="btn-primary text-xs py-1.5 px-3.5 font-bold"
                    >
                      Check In (150m)
                    </button>
                  ) : (
                    <button
                      onClick={() => {
                        setSelectedStoreForVisit(stop.customer || stop.store);
                        setIsStoreVisitModalOpen(true);
                      }}
                      className={`btn-secondary text-xs py-1.5 px-3.5 font-bold ${
                        isInProgress ? 'border-primary text-primary bg-primary/10' : ''
                      }`}
                    >
                      {isCompleted ? 'View Audit Evidence' : 'Continue Store Audit'}
                    </button>
                  )}
                </div>
              </div>
            );
          })}

          {route.length === 0 && (
            <div className="p-8 text-center text-zinc-400 text-xs">
              No route stops assigned for today. Contact operations supervisor.
            </div>
          )}
        </div>
      </div>
      </>
      )}

      {/* Modals */}

      <VisitAuditModal
        visit={activeAuditVisit}
        isOpen={Boolean(activeAuditVisit)}
        onClose={() => setActiveAuditVisit(null)}
        onCompleted={loadData}
      />

      <StoreRequestModal
        isOpen={isStoreRequestModalOpen}
        onClose={() => setIsStoreRequestModalOpen(false)}
        onSuccess={loadData}
      />

      <StoreVisitModal
        isOpen={isStoreVisitModalOpen}
        onClose={() => {
          setIsStoreVisitModalOpen(false);
          setSelectedStoreForVisit(null);
        }}
        store={selectedStoreForVisit}
        visit={activeAuditVisit}
        agentCoords={agentLocation}
        onSuccess={loadData}
      />

      <SOSModal
        isOpen={sosModalOpen}
        onClose={() => setSOSModalOpen(false)}
        onDispatched={loadData}
      />
    </div>
  );
}

