# QTaudio

QTaudio testing with UI

amixer volume and unmute for headphones and speakers is WORKING

Simple 2 button operation turns sets headphone or speaker volumes

ermagherd - plugin cpp has the stuff you need, do not touch main.cpp and its CMakelist

Needs to be built for Pinephone as (with optional ssh install):
$ clickable --arch arm64 --ssh [ip addr]

which generates an aarch64-linux-gnu folder in app/build

QTaudio has the working code now, with 2 buttons bash sh file calls to amixer, text change
QTtemplate is the back up version.

have QAudioDeviceInfo import but no QDebug log output visible, print something to screen.
Sort the layout to pin all the elements to the top.

Cannot install over ssh if app is already running on device, must exit it first.

Audio file (ogg) include but for some reason wont play at button click.

====================

headphone/speaker amixer script added and installed, was running with error:

Failed to vibrate with pattern: "An AppArmor policy prevents this sender from sending this message to this recipient; type=\"method_call\", sender=\":1.245\" (uid=32011 pid=17604 comm=\"QTaudio \") interface=\"com.lomiri.hfd.Vibrator\" member=\"vibrate\" error name=\"(unset)\" requested_reply=\"0\" destination=\"com.lomiri.hfd\" (uid=0 pid=1948 comm=\"hfd-service \")"

needed to get around this spurious, PITA error with:
QTaudio.apparmor { "template": "unconfined", ... }

=====================

to get .sh echo (and errors) use after install on device:
$ clickable --arch arm64 --ssh [ipaddr] log

use amixer set volume instead, on: 85% and off: 2%
possibly too high for headphones as not sure if vol control on device works for it.

code up a volume bar in app and do some GUI already

include mute/unmute, volume sliders and button/text updates with info

get volume info:
headphoneVolProcess.readAllStandardOutput(); // get stdout

add a mic control

also mute: $ amixer -c 0 set [audio i/o] mute

package naming and make proper for release


## License

Copyright (C) 2020  Kaputnik Go

This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License version 3, as published
by the Free Software Foundation.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranties of MERCHANTABILITY, SATISFACTORY QUALITY, or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.
