-- Fast User Switching Out: Quit Duet and mark it for relaunch
--
-- Triggered by EventScripts on "User Did Resign Active".
-- Only marks for relaunch if Duet was actually running.

set markerDir to POSIX path of (path to home folder) & "Library/Caches/duet-switch/"
set markerFile to markerDir & "was_running"

-- Check if Duet is running before we try to quit it
tell application "System Events"
	set duetRunning to (exists process "duet")
end tell

if not duetRunning then return

-- Duet is running — drop a marker so we know to relaunch on switch-in
do shell script "mkdir -p " & quoted form of markerDir
do shell script "touch " & quoted form of markerFile

-- Quit Duet and confirm the dialog
tell application "duet" to quit

delay 1

tell application "System Events"
	tell process "duet"
		if exists (window 1) then
			click button "Quit" of window 1
		end if
	end tell
end tell
