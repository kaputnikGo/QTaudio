/*
 * Copyright (C) 2020  Kaputnik Go
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; version 3.
 *
 * QTaudio is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

#include <QDebug>
//#include <QAudioDeviceInfo>
//#include <QtMultimedia>

#include "example.h"

Example::Example() {

}

void Example::speak() {
    qDebug() << "hello world!";
}

/*
void Example::device() {
  qDebug() << "check audio output devices:";
  // testing
  //const auto deviceInfos = QAudioDeviceInfo::availableDevices(QAudio::AudioOutput);
/*
  for (const QAudioDeviceInfo &deviceInfo : deviceInfos) {
    qDebug() << "Device name: " << deviceInfo.deviceName();
    //char device[] = deviceInfo.deviceName();
  }
  */
    // QML logging only, not C++
    // console.log("Device name: " + deviceInfo.deviceName());
    /*
}
*/
