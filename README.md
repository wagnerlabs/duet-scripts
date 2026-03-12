# duet-scripts

Automatically quit and relaunch [Duet](https://www.duetdisplay.com) during macOS Fast User Switching.

## Problem

When using Duet to drive a connected iPad as an external monitor, Fast User Switching to another macOS account causes the iPad display to flicker repeatedly. The flickering continues until you switch back and quit Duet manually.

## Solution

Two AppleScripts, triggered by [EventScripts](https://www.mousedown.net/software/EventScripts.html), that:

1. **Quit Duet** when you switch away from your account
2. **Relaunch Duet** when you switch back

A marker file (`~/Library/Caches/duet-switch/was_running`) tracks whether Duet was running at the time of the switch, so it only relaunches if it was actually in use.

## Setup

### Prerequisites

- [EventScripts](https://www.mousedown.net/software/EventScripts.html) installed and running
- Accessibility permissions granted to EventScripts (System Settings > Privacy & Security > Accessibility) — required for the quit confirmation dialog

### 1. Hard-link scripts into EventScripts

EventScripts requires scripts in `~/Library/Application Scripts/net.mousedown.EventScripts/`. Hard links allow the scripts to remain in this repository while being accessible to EventScripts.

> **Note:** Hard links are used instead of symlinks because EventScripts detects and rejects symlinks.

```bash
REPO=~/Projects/wagnerlabs/duet-scripts
DEST=~/Library/Application\ Scripts/net.mousedown.EventScripts

ln "$REPO/QuitDuet.applescript" "$DEST/"
ln "$REPO/RelaunchDuet.applescript" "$DEST/"
```

### 2. Assign events in EventScripts

Open EventScripts preferences and assign:

| Event                      | Script                    |
|----------------------------|---------------------------|
| **User Did Resign Active** | `QuitDuet.applescript`    |
| **User Did Become Active** | `RelaunchDuet.applescript`|

### 3. Test

1. Open Duet and connect your iPad
2. Fast User Switch to another account (or use the login window)
3. Switch back — Duet should relaunch automatically

## Files

- `QuitDuet.applescript` — Quits Duet on switch-out, confirms the quit dialog, drops a marker file
- `RelaunchDuet.applescript` — Relaunches Duet on switch-in if the marker file is present
