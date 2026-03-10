#!/usr/bin/osascript

# @raycast.schemaVersion 1
# @raycast.title Fade Music to 40%
# @raycast.mode silent

tell application "Music"
    set targetVolume to 40
    set currentVolume to sound volume

    if currentVolume < targetVolume then
        repeat while sound volume < targetVolume
            set sound volume to (sound volume + 2)
            delay 0.02
        end repeat
    else
        repeat while sound volume > targetVolume
            set sound volume to (sound volume - 2)
            delay 0.02
        end repeat
    end if
    set sound volume to targetVolume
end tell
