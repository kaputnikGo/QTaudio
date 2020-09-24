# QTaudio


**RELEASE INFO**

QTaudio testing with UI

Version: 0.1.0

amixer volume and unmute for headphones and speakers is WORKING
amixer onboard mic mute/unmute and pipe to headphones or speakers is WORKING

n.b. see Example Case below in Notes section

Simple 4 button operation to switch with info text:
- either headphone or speakers on with default volume set
- mute or unmute the handset microphone

built for Pinephone Community Edition (PostmarketOS) hardware with UBports installed on eMMC.
OS: Ubuntu Touch Version 8
https://wiki.pine64.org/index.php/PinePhone_v1.2 (1.2a)

using clickable:
$ clickable --arch arm64 --ssh [ipaddr]

app will print qDebug info:
$ clickable --arch arm64 --ssh [ipaddr] log


**TODO**

Audio file (ogg) included but for some reason wont play at button click.

volume bars in app and do some GUI already.

different routing buttons for phone calls etc.


**NOTES**
Audio device for Pinephone CE is : sun50i-a64-audio

apparently Line In is unused on Pinephone
https://xnux.eu/devices/feature/audio-pp.html

Audio in mic is clear and loud - no phone DSP, picks up ALL case vibrations.
there seems to be a hotplug headphone beep too.

Example Case: Headphone on with Mic unmute and no apparent audio other than hiss/static:
Tapping the phone on the screen side at the top left corner over the headphone socket MAY fix it

====================

**APPARMOR POLICY**

headphone/speaker amixer script added and installed, was running with error:

Failed to vibrate with pattern: "An AppArmor policy prevents this sender from sending this message to this recipient; type=\"method_call\", sender=\":1.245\" (uid=32011 pid=17604 comm=\"QTaudio \") interface=\"com.lomiri.hfd.Vibrator\" member=\"vibrate\" error name=\"(unset)\" requested_reply=\"0\" destination=\"com.lomiri.hfd\" (uid=0 pid=1948 comm=\"hfd-service \")"

assumed this is due to volume control via amixer is connected to vibrate similar to Android phones that vibrate when volume is reduced past the zero value into vibrate then complete silence.

needed to get around this spurious error by adding:

QTaudio.apparmor { "template": "unconfined", ... }

=====================


## License

Copyright (C) 2020  Kaputnik Go

This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License version 3, as published
by the Free Software Foundation.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranties of MERCHANTABILITY, SATISFACTORY QUALITY, or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.
