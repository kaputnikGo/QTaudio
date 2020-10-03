# QTaudio


**RELEASE INFO**

QTaudio testing with UI - work in progress

Do not drive the handset speaker too loud.<br />
Not sure of peak volume yet, nor of frequency response.<br/>
Possible problematic frequency ~600 Hz at amplitude. <br />
Currently assuming that 80% is a safe peak for most frequencies.<br />
Device now has S4 Mini (GT-I9195) speaker installed, so freq response no longer based on original PinePhone (1.2a).

Version: 0.1.3

amixer volume and unmute for headphones and speakers WORKING<br />
amixer onboard mic1 and mic2 mute/unmute and pipe to headphones or speakers WORKING

n.b. see Example Case below in Notes section

n.b. apparmor policy "unconfined" does not seem to work for pulseaudio microphone access<br />
it does work for QTaudio to vibrator via amixer.

Simple 10 button operation to switch with info text:
- does NOT in any way behave like a standard media player.
- either headphone or speakers on with hardcoded volume set (80%)
- unmute the handset or headset microphones
- mute all microphones
- QAudio device list debug print
- load 10 min ogg file for playback
- AudioGen for continous tone testing
- Volume rocker also controls volume for Headphones (UI says Speakers)
- init state output read and set GUI

built for Pinephone Community Edition (PostmarketOS) hardware with UBports installed on eMMC.<br />
OS: Ubuntu Touch Version 8

https://wiki.pine64.org/index.php/PinePhone_v1.2 (1.2a)

using clickable:<br />
$ clickable --arch arm64 --ssh [ipaddr]

app will print qDebug info:<br />
$ clickable --arch arm64 --ssh [ipaddr] log

<br />

**CHANGES**

- added CHANGELOG, so look there.


<br />

**TODO**

- volume sliders in app and do some GUI already.<br />
- different routing option buttons for phone calls etc.<br />
- need to get current state at app start
- need to update GUI at changes
- ogg playback currently cannot resume, nor play again after stop or end
- add record audio and some fft display ie frequency spectrum

<br />

**NOTES**

Audio device for Pinephone CE is : sun50i-a64-audio

apparently Line In is unused on Pinephone
https://xnux.eu/devices/feature/audio-pp.html

Audio in mic is loud and clear - no phone DSP, picks up ALL case vibrations.<br />
There seems to be a hotplug headphone beep too.

USB-C charging cable connected can produce ground hum and circuit noise.

Example Case:<br />
Headphone on with Mic unmute and no apparent audio other than hiss/static:<br />
Tapping the phone on the screen side at the top left corner over the headphone socket MAY fix it<br />
This seems to mean its hardware related and is possibly limited to the device I use.

====================

**APPARMOR POLICY**

headphone/speaker amixer script added and installed, was running with error:

Failed to vibrate with pattern: "An AppArmor policy prevents this sender from sending this message to this recipient; type=\"method_call\", sender=\":1.245\" (uid=32011 pid=17604 comm=\"QTaudio \") interface=\"com.lomiri.hfd.Vibrator\" member=\"vibrate\" error name=\"(unset)\" requested_reply=\"0\" destination=\"com.lomiri.hfd\" (uid=0 pid=1948 comm=\"hfd-service \")"

assumed this is due to volume control via amixer is connected to vibrate similar to Android phones that vibrate when volume is reduced past the zero value into vibrate then complete silence.

needed to get around this spurious error by adding:<br />
QTaudio.apparmor { "template": "unconfined", ... }

=====================


## License

Copyright (C) 2020  Kaputnik Go

This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License version 3, as published
by the Free Software Foundation.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranties of MERCHANTABILITY, SATISFACTORY QUALITY, or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.
