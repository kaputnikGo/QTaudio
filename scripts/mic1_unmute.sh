#!/bin/bash

set -e
# Mic1 is pinephone daughterboard mic
amixer -c 0 sset 'Mic1' playback 50% unmute

amixer -c 0 sset 'Mic1' 75% cap unmute

amixer -c 0 sset 'Mic1 Boost' 55% unmute
# extra settings for mixer paths

#amixer -c 0 sset 'ADC' 83% cap # already set
amixer -c 0 sset 'AIF1 AD0 Mixer ADC' cap
#amixer -c 0 sset 'AIF1 AD0' 83% cap # already set
#amixer -c 0 sset 'AIF1 DA0' playback 83% # already set
amixer -c 0 sset 'DAC Mixer ADC' on

amixer -c 0 sset 'DAC Reversed' on

echo "Mic1 unmuted, set to cap"
