#!/bin/bash
# get on/off state for audio outputs via Left output (headphone/speaker)

set -e

SPEAKER_STATE=`amixer get 'Line Out' | egrep 'Front Left.*?\[o' | egrep -o '\[o.+\]' | grep -o -E '[a-z]+'`

HEADPHONE_STATE=`amixer get 'Headphone' | egrep 'Front Left.*?\[o' | egrep -o '\[o.+\]'| grep -o -E '[a-z]+'`

# combine values with sentinel, ie. on+off

echo "$SPEAKER_STATE"+"$HEADPHONE_STATE"
