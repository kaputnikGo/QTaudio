#!/bin/bash

set -e

amixer -c 0 set 'Headphone' 2%

amixer -c 0 set 'Line Out' 85%

echo "Speakers on"
