import React, { useState } from 'react';
import { ArrowRight, ShieldCheck, Sparkles, AlertCircle, KeyRound, CheckCircle2, X, Lock, Mail } from 'lucide-react';
import { api } from '../lib/api';

export default function LoginPage({ onLogin, onNavigatePublic }) {
  const [identifier, setIdentifier] = useState('');
  const [password, setPassword] = useState('');
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState('');
  const [successMsg, setSuccessMsg] = useState('');

  // Forgot Password Modal State
  const [forgotModalOpen, setForgotModalOpen] = useState(false);
  const [forgotIdentifier, setForgotIdentifier] = useState('');
  const [forgotStep, setForgotStep] = useState(1); // 1 = request token, 2 = enter token & new password
  const [resetToken, setResetToken] = useState('');
  const [newPassword, setNewPassword] = useState('');
  const [confirmPassword, setConfirmPassword] = useState('');
  const [forgotLoading, setForgotLoading] = useState(false);
  const [forgotError, setForgotError] = useState('');
  const [forgotSuccess, setForgotSuccess] = useState('');

  const handleSignIn = async (e) => {
    e?.preventDefault();
    if (!identifier || !password) {
      setError('Please provide your email address or phone number, and your password.');
      return;
    }

    setLoading(true);
    setError('');
    setSuccessMsg('');
    try {
      const res = await api.post('/auth/login', { identifier, password });
      localStorage.setItem('ewf_token', res.token);
      onLogin?.(res.user);
    } catch (err) {
      setError(err.message || 'Invalid login credentials. Please verify your email/phone and password.');
    } finally {
      setLoading(false);
    }
  };

  const handleRequestResetToken = async (e) => {
    e?.preventDefault();
    if (!forgotIdentifier) {
      setForgotError('Please enter your registered email address or phone number.');
      return;
    }

    setForgotLoading(true);
    setForgotError('');
    setForgotSuccess('');
    try {
      const res = await api.post('/auth/forgot-password', { identifier: forgotIdentifier });
      setForgotSuccess(res.message || 'Verification code generated.');
      if (res.reset_token) {
        setResetToken(res.reset_token);
      }
      setForgotStep(2);
    } catch (err) {
      setForgotError(err.message || 'Failed to process password reset request.');
    } finally {
      setForgotLoading(false);
    }
  };

  const handleConfirmResetPassword = async (e) => {
    e?.preventDefault();
    if (!resetToken || !newPassword) {
      setForgotError('Please enter the verification code and your new password.');
      return;
    }
    if (newPassword !== confirmPassword) {
      setForgotError('Passwords do not match. Please re-enter.');
      return;
    }
    if (newPassword.length < 8) {
      setForgotError('New password must be at least 8 characters long.');
      return;
    }

    setForgotLoading(true);
    setForgotError('');
    try {
      const res = await api.post('/auth/reset-password', {
        identifier: forgotIdentifier,
        token: resetToken,
        new_password: newPassword
      });
      setSuccessMsg(res.message || 'Password reset successfully. Please sign in.');
      setIdentifier(forgotIdentifier);
      setPassword(newPassword);
      setForgotModalOpen(false);
      setForgotStep(1);
      setForgotIdentifier('');
      setResetToken('');
      setNewPassword('');
      setConfirmPassword('');
    } catch (err) {
      setForgotError(err.message || 'Password reset failed. Please check the verification code.');
    } finally {
      setForgotLoading(false);
    }
  };

  return (
    <div className="min-h-screen bg-zinc-950 text-zinc-100 grid lg:grid-cols-12 select-none">
      {/* Left Branding Showcase */}
      <div className="hidden lg:flex lg:col-span-7 p-12 flex-col justify-between relative overflow-hidden bg-gradient-to-br from-zinc-950 via-zinc-900 to-zinc-950 border-r border-zinc-900 sunburst-bg">
        {/* Top Branding */}
        <div className="flex items-center gap-3">
          <img src="/favicon.svg" alt="Logo" className="w-9 h-9" />
          <div>
            <div className="text-sm font-black tracking-tight text-white flex items-center gap-1.5">
              EDGE<span className="text-orange-500">W</span>FORCE
            </div>
            <div className="text-[10px] text-zinc-400 font-bold uppercase tracking-wider">
              Powered by Experiential Edge
            </div>
          </div>
        </div>

        {/* Hero Narrative */}
        <div className="max-w-xl space-y-5 my-auto">
          <div className="inline-flex items-center gap-2 px-3 py-1 rounded-full bg-orange-500/10 border border-orange-500/30 text-orange-400 text-xs font-bold">
            <Sparkles size={13} />
            <span>Enterprise Workforce Operating System</span>
          </div>

          <h1 className="text-4xl xl:text-5xl font-black tracking-tight text-white leading-tight">
            Make every sales and field action <span className="text-transparent bg-clip-text bg-gradient-to-r from-orange-400 via-amber-400 to-orange-500">visible, verified and valuable</span>.
          </h1>

          <p className="text-sm text-zinc-400 leading-relaxed max-w-lg">
            Commercial sales force automation, 150m strict GPS geofencing, employee self-service, non-invasive idle telemetry, and AI sales intelligence in one unified operating system.
          </p>

          <div className="flex items-center gap-6 text-xs text-zinc-400 pt-3">
            <div className="flex items-center gap-2">
              <ShieldCheck size={16} className="text-orange-500" />
              <span>Nigerian Localization (₦, 7.5% VAT)</span>
            </div>
            <div className="flex items-center gap-2">
              <ShieldCheck size={16} className="text-orange-500" />
              <span>150m Strict Geofencing</span>
            </div>
          </div>
        </div>

        {/* Public Navigation Links */}
        <div className="flex items-center gap-5 text-xs text-zinc-500">
          <button onClick={() => onNavigatePublic?.('about')} className="hover:text-zinc-300 transition">About</button>
          <button onClick={() => onNavigatePublic?.('features')} className="hover:text-zinc-300 transition">Features</button>
          <button onClick={() => onNavigatePublic?.('privacy')} className="hover:text-zinc-300 transition">Privacy & Ethics</button>
          <button onClick={() => onNavigatePublic?.('terms')} className="hover:text-zinc-300 transition">Terms of Service</button>
        </div>
      </div>

      {/* Right Login Form */}
      <div className="lg:col-span-5 flex items-center justify-center p-6 sm:p-10">
        <div className="w-full max-w-md space-y-6">
          <div className="space-y-1">
            <h2 className="text-2xl font-black text-white">Sign In to EdgeWForce</h2>
            <p className="text-xs text-zinc-400">
              Enter your official email address or registered phone number to access your workspace.
            </p>
          </div>

          {error && (
            <div className="p-3 rounded-lg bg-red-500/10 border border-red-500/30 text-red-400 text-xs font-semibold flex items-center gap-2">
              <AlertCircle size={15} />
              <span>{error}</span>
            </div>
          )}

          {successMsg && (
            <div className="p-3 rounded-lg bg-emerald-500/10 border border-emerald-500/30 text-emerald-400 text-xs font-semibold flex items-center gap-2">
              <CheckCircle2 size={15} />
              <span>{successMsg}</span>
            </div>
          )}

          <form onSubmit={handleSignIn} className="space-y-4">
            <div>
              <label className="block text-xs font-bold text-zinc-300 mb-1">Email address or phone number</label>
              <div className="relative">
                <input
                  type="text"
                  required
                  className="form-input bg-zinc-900 border-zinc-800 text-white text-xs py-2.5 pl-9"
                  placeholder="name@company.com or 08012345678"
                  value={identifier}
                  onChange={(e) => setIdentifier(e.target.value)}
                />
                <Mail size={15} className="absolute left-3 top-3 text-zinc-500" />
              </div>
            </div>

            <div>
              <div className="flex items-center justify-between mb-1">
                <label className="block text-xs font-bold text-zinc-300">Password</label>
                <button
                  type="button"
                  onClick={() => {
                    setForgotIdentifier(identifier || '');
                    setForgotError('');
                    setForgotSuccess('');
                    setForgotStep(1);
                    setForgotModalOpen(true);
                  }}
                  className="text-xs font-semibold text-orange-400 hover:text-orange-300 transition"
                >
                  Forgot Password?
                </button>
              </div>
              <div className="relative">
                <input
                  type="password"
                  required
                  className="form-input bg-zinc-900 border-zinc-800 text-white text-xs py-2.5 pl-9"
                  placeholder="••••••••••••"
                  value={password}
                  onChange={(e) => setPassword(e.target.value)}
                />
                <Lock size={15} className="absolute left-3 top-3 text-zinc-500" />
              </div>
            </div>

            <button
              type="submit"
              disabled={loading}
              className="btn-primary w-full py-3 text-xs font-bold shadow-lg shadow-orange-500/20 flex items-center justify-center gap-2"
            >
              <span>{loading ? 'Authenticating…' : 'Enter Workspace'}</span>
              <ArrowRight size={15} />
            </button>
          </form>

          {/* 1-Click Fast Demo Login Switcher */}
          <div className="pt-4 border-t border-zinc-900 space-y-2.5">
            <div className="flex items-center justify-between">
              <span className="text-[10px] font-bold uppercase tracking-wider text-orange-400 flex items-center gap-1">
                <Sparkles size={12} />
                <span>1-Click Fast Access / Demo Roles</span>
              </span>
              <span className="text-[9px] text-zinc-500 font-mono">Password: ChangeMe123!</span>
            </div>

            <div className="grid grid-cols-2 gap-2 text-left">
              {[
                { label: '👑 CEO & Executive', email: 'ceo@edgewforce.com', desc: 'Strategic Governance' },
                { label: '⚡ IT Super Admin', email: 'it@edgewforce.com', desc: 'System & Credentials' },
                { label: '👔 HR Manager', email: 'hr@edgewforce.com', desc: 'People & Rosters' },
                { label: '🎯 Sales Lead', email: 'sales@edgewforce.com', desc: 'Commercial & POS' },
                { label: '📍 Field Agent', email: 'field@edgewforce.com', desc: 'Routes & Geofencing' },
                { label: '🛡️ Supervisor', email: 'supervisor@edgewforce.com', desc: 'Radar & 360 Team' },
                { label: '💳 Accountant', email: 'accountant@edgewforce.com', desc: 'Collections & Ledger' },
                { label: '🏢 Ops Staff', email: 'staff@edgewforce.com', desc: 'Self-Service & Schedule' },
              ].map((role) => (
                <button
                  key={role.email}
                  type="button"
                  onClick={async () => {
                    setIdentifier(role.email);
                    setPassword('ChangeMe123!');
                    setError('');
                    setSuccessMsg('');
                    setLoading(true);
                    try {
                      const res = await api.post('/auth/login', { identifier: role.email, password: 'ChangeMe123!' });
                      localStorage.setItem('ewf_token', res.token);
                      onLogin?.(res.user);
                    } catch (err) {
                      setError(err.message || 'Login failed.');
                    } finally {
                      setLoading(false);
                    }
                  }}
                  className="p-2 rounded-xl bg-zinc-900/90 hover:bg-orange-500/10 border border-zinc-800 hover:border-orange-500/40 text-zinc-300 hover:text-white transition group flex flex-col justify-between"
                >
                  <span className="text-xs font-bold text-zinc-200 group-hover:text-orange-400 transition truncate block">
                    {role.label}
                  </span>
                  <span className="text-[9px] text-zinc-500 truncate block">
                    {role.desc}
                  </span>
                </button>
              ))}
            </div>
          </div>

          <div className="pt-3 border-t border-zinc-900 flex flex-col sm:flex-row items-center justify-between text-xs text-zinc-500 gap-2">
            <span>Corporate Access Only</span>
            <span className="text-[11px] text-zinc-400 font-semibold">&copy; Nexfeild. edgewforce.com</span>
          </div>
        </div>
      </div>

      {/* Forgot Password Modal */}
      {forgotModalOpen && (
        <div className="fixed inset-0 z-50 bg-black/80 backdrop-blur-sm flex items-center justify-center p-4">
          <div className="w-full max-w-md surface-card rounded-2xl p-6 border border-zinc-800 shadow-2xl space-y-5 animate-fade-in text-zinc-100">
            <div className="flex items-center justify-between">
              <div className="flex items-center gap-2.5">
                <div className="p-2 rounded-xl bg-orange-500/10 text-orange-500">
                  <KeyRound size={18} />
                </div>
                <div>
                  <h3 className="text-base font-extrabold text-white">Reset Account Password</h3>
                  <p className="text-[11px] text-zinc-400">
                    {forgotStep === 1 ? 'Step 1: Enter your registered corporate email' : 'Step 2: Enter verification code & new password'}
                  </p>
                </div>
              </div>
              <button
                onClick={() => setForgotModalOpen(false)}
                className="p-1 text-zinc-400 hover:text-white rounded-lg hover:bg-zinc-800 transition"
              >
                <X size={18} />
              </button>
            </div>

            {forgotError && (
              <div className="p-3 rounded-lg bg-red-500/10 border border-red-500/30 text-red-400 text-xs font-semibold flex items-center gap-2">
                <AlertCircle size={15} />
                <span>{forgotError}</span>
              </div>
            )}

            {forgotSuccess && (
              <div className="p-3 rounded-lg bg-emerald-500/10 border border-emerald-500/30 text-emerald-400 text-xs font-semibold flex items-center gap-2">
                <CheckCircle2 size={15} />
                <span>{forgotSuccess}</span>
              </div>
            )}

            {forgotStep === 1 ? (
              <form onSubmit={handleRequestResetToken} className="space-y-4">
                <div>
                  <label className="block text-xs font-bold text-zinc-300 mb-1">Email address or phone number</label>
                  <input
                    type="text"
                    required
                    className="form-input bg-zinc-900 border-zinc-800 text-white text-xs py-2.5"
                    placeholder="e.g. name@company.com or 08012345678"
                    value={forgotIdentifier}
                    onChange={(e) => setForgotIdentifier(e.target.value)}
                  />
                </div>
                <div className="flex gap-2 justify-end pt-2">
                  <button
                    type="button"
                    onClick={() => setForgotModalOpen(false)}
                    className="btn-secondary text-xs py-2 px-4"
                  >
                    Cancel
                  </button>
                  <button
                    type="submit"
                    disabled={forgotLoading}
                    className="btn-primary text-xs py-2 px-4 font-bold"
                  >
                    {forgotLoading ? 'Generating…' : 'Generate Reset Code'}
                  </button>
                </div>
              </form>
            ) : (
              <form onSubmit={handleConfirmResetPassword} className="space-y-3.5">
                <div>
                  <label className="block text-xs font-bold text-zinc-300 mb-1">6-Digit Verification Code</label>
                  <input
                    type="text"
                    required
                    maxLength={6}
                    className="form-input bg-zinc-900 border-zinc-800 text-white text-sm font-mono tracking-widest text-center py-2.5"
                    placeholder="123456"
                    value={resetToken}
                    onChange={(e) => setResetToken(e.target.value)}
                  />
                </div>

                <div>
                  <label className="block text-xs font-bold text-zinc-300 mb-1">New Password (min 8 characters)</label>
                  <input
                    type="password"
                    required
                    minLength={8}
                    className="form-input bg-zinc-900 border-zinc-800 text-white text-xs py-2.5"
                    placeholder="••••••••••••"
                    value={newPassword}
                    onChange={(e) => setNewPassword(e.target.value)}
                  />
                </div>

                <div>
                  <label className="block text-xs font-bold text-zinc-300 mb-1">Confirm New Password</label>
                  <input
                    type="password"
                    required
                    minLength={8}
                    className="form-input bg-zinc-900 border-zinc-800 text-white text-xs py-2.5"
                    placeholder="••••••••••••"
                    value={confirmPassword}
                    onChange={(e) => setConfirmPassword(e.target.value)}
                  />
                </div>

                <div className="flex gap-2 justify-between pt-2">
                  <button
                    type="button"
                    onClick={() => setForgotStep(1)}
                    className="text-xs text-zinc-400 hover:text-white"
                  >
                    ← Back to Step 1
                  </button>
                  <div className="flex gap-2">
                    <button
                      type="button"
                      onClick={() => setForgotModalOpen(false)}
                      className="btn-secondary text-xs py-2 px-4"
                    >
                      Cancel
                    </button>
                    <button
                      type="submit"
                      disabled={forgotLoading}
                      className="btn-primary text-xs py-2 px-4 font-bold"
                    >
                      {forgotLoading ? 'Updating…' : 'Set New Password'}
                    </button>
                  </div>
                </div>
              </form>
            )}
          </div>
        </div>
      )}
    </div>
  );
}

