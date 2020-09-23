#!/bin/bash

set -e

# Line In not used on Pinephone
amixer -c 0 sset 'Line In' playback 50% unmute

amixer -c 0 sset 'Line In' 75% cap unmute

# Mic1 is pinephone daughterboard mic
amixer -c 0 sset 'Mic1' playback 50% unmute

amixer -c 0 sset 'Mic1' 75% cap unmute

amixer -c 0 sset 'Mic1 Boost' 55% unmute

# Mic2 is Headphones mic
amixer -c 0 sset 'Mic2' playback 50% unmute

amixer -c 0 sset 'Mic2' 75% cap unmute

amixer -c 0 sset 'Mic2 Boost' 55% unmute

# extra settings for mixer paths
# capabilities pswitch use on, off
# capabilities cvolume use number, percent or dB
#amixer -c 0 sset 'ADC' 83% cap # already set
amixer -c 0 sset 'AIF1 AD0 Mixer ADC' cap
#amixer -c 0 sset 'AIF1 AD0' 83% cap # already set
#amixer -c 0 sset 'AIF1 DA0' playback 83% # already set
amixer -c 0 sset 'DAC Mixer ADC' on

amixer -c 0 sset 'DAC Reversed' on

echo "All mics unmuted, set to cap"
