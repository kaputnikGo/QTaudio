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
#include <QCoreApplication>
#include <QDebug>
#include <QAudio>
#include <QAudioDeviceInfo>

#include "example.h"

using namespace std;

Example::Example() :
  headphoneProcess(),
  speakerProcess()
{
    // maybe
    connect(&headphoneProcess, SIGNAL(finished(int, QProcess::ExitStatus)), this, SLOT(onHeadphoneFinished(int, QProcess::ExitStatus)));
    connect(&speakerProcess, SIGNAL(finished(int, QProcess::ExitStatus)), this, SLOT(onSpeakerFinished(int, QProcess::ExitStatus)));
}

void Example::speakers() {
    // called from BUTTON2: mute headphones, unmute speakers.
    qDebug() << "speakers on";
    // hardcoded location bad ...
    speakerProcess.start("bash /opt/click.ubuntu.com/qtaudio.kaputnikgo/current/scripts/speakers.sh");
    /*
    const auto deviceInfos = QAudioDeviceInfo::availableDevices(QAudio::AudioOutput);

    for (const QAudioDeviceInfo &deviceInfo : deviceInfos) {
      qDebug() << "Device name: " << deviceInfo.deviceName();
    }
    */
}

void Example::headphones() {
    // called from BUTTON1: unmute headphones, mute speakers.
    qDebug() << "headphones on";
    // hardcode location bad...
    headphoneProcess.start("bash /opt/click.ubuntu.com/qtaudio.kaputnikgo/current/scripts/headphones.sh");
}

void Example::onHeadphoneFinished(int exitCode, QProcess::ExitStatus exitStatus) {
    qDebug() << "Headphone on finished";
    qDebug() << "exit code" << exitCode << "exit status" << exitStatus;
}


void Example::onSpeakerFinished(int exitCode, QProcess::ExitStatus exitStatus) {
    qDebug() << "Speaker on finished";
    qDebug() << "exit code" << exitCode << "exit status" << exitStatus;

}
