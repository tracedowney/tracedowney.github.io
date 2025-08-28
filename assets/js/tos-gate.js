(function(){
  const KEY = 'tosAcceptance';
  const LogEndpoint = ''; // e.g. https://script.google.com/macros/s/AKfyc.../exec (optional)

  function read(){
    try { return JSON.parse(localStorage.getItem(KEY) || 'null'); } catch { return null; }
  }
  function isAccepted(){
    const r = read();
    return !!(r && r.accepted === true);
  }
  async function post(event){
    if (!LogEndpoint) return;
    try { await fetch(LogEndpoint, { method:'POST', headers:{'Content-Type':'application/json'}, body: JSON.stringify(event) }); }
    catch (e){ console.warn('TOS log failed', e); }
  }

  // Expose a minimal API
  window.TOSGate = { isAccepted, read, post };
})();
