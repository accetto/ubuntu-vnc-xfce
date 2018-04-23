#!/bin/bash
### every exit != 0 fails the script
set -e
set -u

echo "Installing Firefox"
apt-get update 
apt-get install -y firefox
apt-get clean -y

### Issue #2: Firefox tab crashes "Gah. Your tab just crashed."
### Mitigate the tab crashing problem by setting the following preferences:
### user_pref("browser.tabs.remote.autostart", false);
### user_pref("browser.tabs.remote.autostart.2", false);

### Put all the user preferences you want to force administratively into the file 'all-accetto.js'.
### The preferences will be forced for each session in all profiles.
### The VNC user ('headles:headless' by default) will get permissions to modify the file.
### The file is currently empty. The fix for issue #2 has been moved to 'user.js'.
cp $INST_SCRIPTS/all-accetto.js /usr/lib/firefox/browser/defaults/preferences/

### Create the default profile folder and put the file with default preferences there.
### The preferences will be forced for each session, but only in the profile containing the file.
### The VNC user ('headles:headless' by default) will get permissions to modify or delete the file.
### There will be also a backup copy of the proto-profile.
echo "Preparing Firefox proto-profile"
mkdir $HOME/.mozilla/firefox
mkdir $HOME/.mozilla/firefox/profile0.default
cp $INST_SCRIPTS/profiles.ini $HOME/.mozilla/firefox
cp $INST_SCRIPTS/user.js $HOME/.mozilla/firefox/profile0.default
cp -r $HOME/.mozilla/firefox $HOME/firefox.backup
