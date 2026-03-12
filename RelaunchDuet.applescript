-- Fast User Switching In: Relaunch Duet if it was running before switch-out
--
-- Triggered by EventScripts on "User Did Become Active".
-- Only relaunches if the marker file exists (meaning Duet was quit by QuitDuet.applescript).

set markerFile to POSIX path of (path to home folder) & "Library/Caches/duet-switch/was_running"

-- Check for the marker file
set shouldRelaunch to false
try
	do shell script "test -f " & quoted form of markerFile
	set shouldRelaunch to true
end try

if not shouldRelaunch then return

-- Remove the marker and relaunch
do shell script "rm -f " & quoted form of markerFile

tell application "duet" to activate
