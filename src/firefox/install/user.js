// Issue #2: Firefox tab crashes "Gah. Your tab just crashed."
// Mitigate the tab crashing problem by forcing the following preferences:
user_pref("browser.tabs.remote.autostart", false);
user_pref("browser.tabs.remote.autostart.2", false);

// Add the preferences you want to force here.
// The preferences will be forced for each session, but only in the profile containing this file.
// There is also a backup copy of this file (/headless/.mozilla/firefox/user.js.txt).
// The VNC user ('headles:headless' by default) has got permissions to modify or delete this file.
