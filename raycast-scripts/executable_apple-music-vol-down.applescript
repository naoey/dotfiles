#!/usr/bin/osascript

# @raycast.schemaVersion 1
# @raycast.title Music volume down
# @raycast.mode silent

tell application "Music"
    set targetVolume to (get sound volume) - 5
    set currentVolume to sound volume

    if currentVolume < targetVolume then
        repeat while sound volume < targetVolume
            set sound volume to (sound volume + 2)
            delay 0.0001
        end repeat
    else
        repeat while sound volume > targetVolume
            set sound volume to (sound volume - 2)
            delay 0.0001
        end repeat
    end if
    set sound volume to targetVolume
end tell
