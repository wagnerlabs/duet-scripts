#!/bin/bash
set -euo pipefail

REPO="$(cd "$(dirname "$0")" && pwd)"
DEST="$HOME/Library/Application Scripts/net.mousedown.EventScripts"

if [ ! -d "$DEST" ]; then
    echo "Error: EventScripts directory not found at:"
    echo "  $DEST"
    echo "Is EventScripts installed?"
    exit 1
fi

for script in QuitDuet.applescript RelaunchDuet.applescript; do
    target="$DEST/$script"
    if [ -e "$target" ]; then
        echo "Already exists, skipping: $target"
    else
        ln "$REPO/$script" "$target"
        echo "Hard-linked: $script"
    fi
done

echo ""
echo "Done. Now open EventScripts preferences and assign:"
echo "  Fast user switched out  -> QuitDuet.applescript"
echo "  Fast user switched in   -> RelaunchDuet.applescript"
