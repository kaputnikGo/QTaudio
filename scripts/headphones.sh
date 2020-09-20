#!/bin/bash

set -e

amixer -c 0 set 'Headphone' unmute

amixer -c 0 set 'Headphone' 85%

amixer -c 0 set 'Line Out' 10%

echo "Headphones on"
