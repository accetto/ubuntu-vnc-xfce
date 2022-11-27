// Add the preferences you want to force here.
// They will be forced for each session, but only in profiles containing this file.

// Disable WebRTC leaks as explained in https://ipleak.net/#webrtcleak
// Be aware that this has impact on some applications, e.g. some messengers.
// user_pref("media.peerconnection.enabled", false);

// Fixing "Gah. Your tab just crashed."
// Disabling Firefox multi-process through preferences doesn't work since version 68.0.
// user_pref("browser.tabs.remote.autostart", false);
// user_pref("browser.tabs.remote.autostart.2", false);
// Disabling the Firefox multi-process must be done by setting the environment variable
// MOZ_FORCE_DISABLE_E10S. Note that any value means 'yes'. Both following settings
// will disable the multi-process feature:
//      MOZ_FORCE_DISABLE_E10S=1
//      MOZ_FORCE_DISABLE_E10S=0
