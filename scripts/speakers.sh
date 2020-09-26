#!/bin/bash

set -e

amixer -c 0 set 'Headphone' 2%

amixer -c 0 set 'Line Out' 80%

echo "Speakers on"
