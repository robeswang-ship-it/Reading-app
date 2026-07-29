import { FormEvent, useState } from 'react';
import { hasSupabaseConfig, supabase } from '../services/supabaseClient';

type AuthMode = 'login' | 'signup' | 'forgot-password';

function AuthPage() {
  const [mode, setMode] = useState<AuthMode>('login');
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [message, setMessage] = useState('');
  const [error, setError] = useState('');
  const [isSubmitting, setIsSubmitting] = useState(false);

  const handleSubmit = async (event: FormEvent<HTMLFormElement>) => {
    event.preventDefault();
    setMessage('');
    setError('');

    if (!email.trim()) {
      setError('Please enter your email.');
      return;
    }

    setIsSubmitting(true);

    if (mode === 'forgot-password') {
      const { error: resetError } = await supabase.auth.resetPasswordForEmail(
        email.trim(),
        {
          redirectTo: window.location.origin,
        },
      );

      setIsSubmitting(false);

      if (resetError) {
        setError(resetError.message);
        return;
      }

      setMessage(
        'If this email exists, a password reset link has been sent. Open it in the browser where you want to set the new password.',
      );
      return;
    }

    if (!password) {
      setIsSubmitting(false);
      setError('Please enter your password.');
      return;
    }

    const result =
      mode === 'login'
        ? await supabase.auth.signInWithPassword({
            email: email.trim(),
            password,
          })
        : await supabase.auth.signUp({
            email: email.trim(),
            password,
          });

    setIsSubmitting(false);

    if (result.error) {
      setError(result.error.message);
      return;
    }

    if (mode === 'signup') {
      setMessage('Sign up successful. Check your email if confirmation is enabled.');
    }
  };

  return (
    <main className="min-h-screen bg-slate-50 text-slate-950">
      <div className="mx-auto flex min-h-screen w-full max-w-md flex-col justify-center px-4 py-10 sm:px-6">
        <div className="mb-8">
          <p className="text-sm font-medium text-cyan-700">
            AI Intensive Reading
          </p>
          <h1 className="mt-3 text-4xl font-semibold text-slate-950">
            {mode === 'login'
              ? 'Log in'
              : mode === 'signup'
                ? 'Create account'
                : 'Reset password'}
          </h1>
          <p className="mt-3 text-sm leading-6 text-slate-600">
            {mode === 'forgot-password'
              ? 'Enter your account email and we will send a secure recovery link.'
              : 'Sign in to access your cloud reading library.'}
          </p>
        </div>

        <form
          onSubmit={handleSubmit}
          className="rounded-lg border border-slate-200 bg-white p-5 shadow-sm"
        >
          {!hasSupabaseConfig ? (
            <div className="mb-4 border-l-4 border-amber-500 bg-amber-50 p-3 text-sm leading-6 text-amber-900">
              Supabase environment variables are missing. Add
              VITE_SUPABASE_URL and VITE_SUPABASE_ANON_KEY.
            </div>
          ) : null}

          <label
            htmlFor="auth-email"
            className="text-sm font-semibold text-slate-800"
          >
            Email
          </label>
          <input
            id="auth-email"
            type="email"
            value={email}
            onChange={(event) => setEmail(event.target.value)}
            className="mt-2 h-11 w-full rounded-md border border-slate-300 bg-white px-3 text-sm outline-none transition focus:border-cyan-500 focus:ring-4 focus:ring-cyan-100"
            placeholder="you@example.com"
            autoComplete="email"
          />

          {mode !== 'forgot-password' ? (
            <>
              <label
                htmlFor="auth-password"
                className="mt-4 block text-sm font-semibold text-slate-800"
              >
                Password
              </label>
              <input
                id="auth-password"
                type="password"
                value={password}
                onChange={(event) => setPassword(event.target.value)}
                className="mt-2 h-11 w-full rounded-md border border-slate-300 bg-white px-3 text-sm outline-none transition focus:border-cyan-500 focus:ring-4 focus:ring-cyan-100"
                placeholder="At least 8 characters"
                autoComplete={
                  mode === 'login' ? 'current-password' : 'new-password'
                }
              />
            </>
          ) : null}

          {error ? (
            <p className="mt-4 text-sm font-medium text-rose-700" role="alert">
              {error}
            </p>
          ) : null}
          {message ? (
            <p className="mt-4 text-sm font-medium text-emerald-700">
              {message}
            </p>
          ) : null}

          <button
            type="submit"
            disabled={isSubmitting || !hasSupabaseConfig}
            className="mt-5 inline-flex h-11 w-full items-center justify-center rounded-md bg-cyan-700 px-4 text-sm font-semibold text-white shadow-sm transition hover:bg-cyan-800 disabled:cursor-not-allowed disabled:opacity-50 focus:outline-none focus:ring-2 focus:ring-cyan-500 focus:ring-offset-2"
          >
            {isSubmitting
              ? 'Please wait...'
              : mode === 'login'
                ? 'Log in'
                : mode === 'signup'
                  ? 'Sign up'
                  : 'Send Reset Link'}
          </button>

          {mode === 'login' ? (
            <button
              type="button"
              onClick={() => {
                setMode('forgot-password');
                setError('');
                setMessage('');
              }}
              className="mt-3 inline-flex h-10 w-full items-center justify-center rounded-md px-4 text-sm font-semibold text-cyan-700 transition hover:bg-cyan-50 focus:outline-none focus:ring-2 focus:ring-cyan-500 focus:ring-offset-2"
            >
              Forgot password?
            </button>
          ) : null}

          <button
            type="button"
            onClick={() => {
              setMode(mode === 'login' ? 'signup' : 'login');
              setError('');
              setMessage('');
            }}
            className="mt-3 inline-flex h-10 w-full items-center justify-center rounded-md border border-slate-300 bg-white px-4 text-sm font-semibold text-slate-700 shadow-sm transition hover:bg-slate-100 focus:outline-none focus:ring-2 focus:ring-cyan-500 focus:ring-offset-2"
          >
            {mode === 'login'
              ? 'Need an account? Sign up'
              : mode === 'signup'
                ? 'Already have an account? Log in'
                : 'Back to Log In'}
          </button>
        </form>
      </div>
    </main>
  );
}

export default AuthPage;
