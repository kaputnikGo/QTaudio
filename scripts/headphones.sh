#!/bin/bash

set -e

amixer -c 0 set 'Headphone' unmute

amixer -c 0 set 'Headphone' 80%

amixer -c 0 set 'Line Out' 2%

echo "Headphones on"
