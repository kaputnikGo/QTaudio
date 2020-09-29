#!/bin/bash

set -e

amixer -c 0 set 'Headphone' 2% off

amixer -c 0 set 'Line Out' 80% on

echo "Speakers on"
