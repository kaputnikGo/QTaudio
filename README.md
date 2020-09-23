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

Audio device for Pinephone CE is : sun50i-a64-audio

apparently Line In is unused on Pinephone
https://xnux.eu/devices/feature/audio-pp.html

Mic1 daughterboard
Mic2 headphones
AIF1 is SoC
AIF2 is modem
AIF3 is bluetooth

so, Mic1 and AIF1 (should cause feedback with speakers on, depends on n%)::
160 == 83% == 0.00dB

//inputs
amixer sget 'Mic1' -> Capture Switch to [on]  
amixer sget 'ADC' -> Capture Volume to 50%
amixer sget 'AIF1 AD0 Mixer ADC' -> Capture Switch to [on]
amixer sget 'AIF1 AD0' -> Capture Volume to 50%
amixer sget 'AIF1 DA0' -> Playback Volume to 50%
amixer sget 'DAC Mixer ADC' -> Playback Switch to [on]
//outputs
amixer sget 'DAC' -> Playback Switch to [on]
amixer sget 'DAC Reversed' -> Playback Switch to [on]
amixer sget 'DAC' -> Playback Volume to 50%
amixer sget 'Mic1' -> Playback Switch to [on]
amixer sget 'Mic1' -> Playback Volume to 50%

OK, reboot device map the amixer settings for Mic1 -> AIF1 and then set from there.

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
defaults for pinephone:
  'Line In' (captures playback L/R off) off
  'Mic1' (captures playback L/R 43% off)
  'Mic2' (captures plaback L/R 43% off)
  'Mic1 Boost' (mono) 57%
  'Mic2 Boost' (mono) 57%

alsamixer defaults:
  'Line In' - playback 43 unmuted, capture [off, off]
  'Mic1' - capture L R, no volume bar at all, red
  'Mic1 Boost' - capture 64
  'Mic2' - capture [off, off]

changing via QProcess is read into amixer but alsamixer shows no change
amixer for unmute 'Line In' shows : "Playback 3 [43%][0.00dB][on] Capture [off]"

unmute turns Line In, Mic1, Mic2 capture to [on]
option cap turns on capture.
add volume % for unmute/mute commands

also mute: $ amixer -c 0 set [audio i/o] mute

amixer -c 0 set 'Line In' 75% cap unmute

speakers to 85% produce noticable line static hiss... no DSP?
no feedback with mics on and speaker on... is there DSP?
no audio at all with mics on and either speaker or headphones on

possible other device items for mic control:
'Mixer' capture [off]
'Mixer Reversed' capture [off]
'AIF1 AD0 Mixer ADC' capture [off]
'AIF1 AD0 Mixer AIF1 DA0' capture [off]
'AIF1 AD0 Mixer AIF2 DAC' capture [off]
'AIF1 AD0 Mixer AIF2 DAC Rev' capture [off]
'AIF2 ADC Mixer ADC' capture [off]
'AIF2 ADC Mixer AIF1 DA0' capture [off]
'AIF2 ADC Mixer AIF2 DAC Rev' capture [off]

for playback:
'DAC Mixer ADC' playback [off]
'DAC Mixer AIF2 Dac' playback [off]
'DAC Reversed' playback [off]

also:
'Earpiece' mono, playback [off]
'DAC' has volume set to 43, can be boosted for AudioOutput
alsamixer Line In, Mic1, Mic2 have no volume bars and are red names
mute Playback in case alsa has got a feedback check and block
possibly another parent 'capture' device item is controlling the mic capture

mute playback and capture stops all static from speakers.
unmute for some reason keeps turning playback on again... and static returns.

package naming and make proper for release


## License

Copyright (C) 2020  Kaputnik Go

This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License version 3, as published
by the Free Software Foundation.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranties of MERCHANTABILITY, SATISFACTORY QUALITY, or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.
