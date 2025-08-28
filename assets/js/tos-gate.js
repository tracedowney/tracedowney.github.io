// Simple “TOS gate”: enables Sign Up button only if the box is checked.
document.addEventListener('DOMContentLoaded', () => {
  const agree = document.getElementById('agreeBox');
  const btn = document.getElementById('signupBtn');
  if (!agree || !btn) return;
  const set = () => { btn.disabled = !agree.checked; };
  agree.addEventListener('change', set);
  set();
});
