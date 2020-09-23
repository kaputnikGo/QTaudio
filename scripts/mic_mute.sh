#!/bin/bash

set -e

amixer -c 0 sset 'Line In' 0% nocap mute

amixer -c 0 sset 'Line In' playback 0% mute

amixer -c 0 sset 'Mic1' 0% nocap mute

amixer -c 0 sset 'Mic1' playback 0% mute

amixer -c 0 sset 'Mic1 Boost' 0% mute

amixer -c 0 sset 'Mic2' 0% nocap mute

amixer -c 0 sset 'Mic2' playback 0% mute

amixer -c 0 sset 'Mic2 Boost' 0% mute

echo "All mics muted"
