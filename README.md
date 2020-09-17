# QTaudio

QTaudio testing with UI

ermagherd - plugin cpp has the stuff you need, do not touch main.cpp and its CMakelist

Messy, and has only got QAudioDeviceInfo compiled. Need to check QDebug output on device.
Needs to be built for Pinephone as:
$ clickable --arch amd64
which generates an aarch64-linux-gnu folder in app/build

## License

Copyright (C) 2020  Kaputnik Go

This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License version 3, as published
by the Free Software Foundation.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranties of MERCHANTABILITY, SATISFACTORY QUALITY, or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.
