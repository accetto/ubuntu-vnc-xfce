#!/usr/bin/env bash
### every exit != 0 fails the script
set -e
set -u

echo "Install Firefox"
apt-get update 
#apt-get install -y firefox=45*
#apt-mark hold firefox
apt-get install -y firefox
apt-get clean -y

# Issue #2: Firefox tab crashes "Gah. Your tab just crashed."
# Mitigate the tab crashing problem by forcing the following preferences:
# user_pref("browser.tabs.remote.autostart", false);
# user_pref("browser.tabs.remote.autostart.2", false);
cp $INST_SCRIPTS/all-accetto.js /usr/lib/firefox/browser/defaults/preferences/
