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
  speakerProcess(),
  headphoneVolProcess(),
  speakerVolProcess(),
  headphoneVolRead('0'),
  speakerVolRead('0')
{
    // maybe
    connect(&headphoneProcess, SIGNAL(finished(int, QProcess::ExitStatus)), this, SLOT(onHeadphoneFinished(int, QProcess::ExitStatus)));
    connect(&speakerProcess, SIGNAL(finished(int, QProcess::ExitStatus)), this, SLOT(onSpeakerFinished(int, QProcess::ExitStatus)));
    connect(&headphoneVolProcess, SIGNAL(finished(int, QProcess::ExitStatus)), this, SLOT(onHeadphoneVolFinished(int, QProcess::ExitStatus)));
    connect(&speakerVolProcess, SIGNAL(finished(int, QProcess::ExitStatus)), this, SLOT(onSpeakerVolFinished(int, QProcess::ExitStatus)));
}

void Example::speakers() {
    // called from qml button: headphones vol 2%, speakers 85%
    qDebug() << "speakers on";
    // hardcoded location bad ...
    speakerProcess.start("bash /opt/click.ubuntu.com/qtaudio.kaputnikgo/current/scripts/speakers.sh");
    speakerProcess.waitForFinished();
    speakerProcess.close();
    /*
    const auto deviceInfos = QAudioDeviceInfo::availableDevices(QAudio::AudioOutput);

    for (const QAudioDeviceInfo &deviceInfo : deviceInfos) {
      qDebug() << "Device name: " << deviceInfo.deviceName();
    }
    */
    //readSpeakerVol();
}
void Example::headphones() {
    // called from qml button: unmute headphones vol 85%, speakers 2%.
    qDebug() << "headphones on";
    // hardcode location bad...
    headphoneProcess.start("bash /opt/click.ubuntu.com/qtaudio.kaputnikgo/current/scripts/headphones.sh");
    headphoneProcess.waitForFinished();
    headphoneProcess.close();
    //readHeadphoneVol();
}

void Example::readHeadphoneVol() {
    qDebug() << "headphone vol read";
    headphoneVolProcess.start("bash /opt/click.ubuntu.com/qtaudio.kaputnikgo/current/scripts/headphone_vol.sh");
    headphoneVolProcess.waitForFinished();
    headphoneVolRead = QString(headphoneVolProcess.readAllStandardOutput());
    // strip /n
    headphoneVolRead.chop(1);
    headphoneVolProcess.close();
    qDebug() << headphoneVolRead;
}
void Example::readSpeakerVol() {
    qDebug() << "speaker vol read";
    speakerVolProcess.start("bash /opt/click.ubuntu.com/qtaudio.kaputnikgo/current/scripts/speaker_vol.sh");
    speakerVolProcess.waitForFinished();
    speakerVolRead = QString(speakerVolProcess.readAllStandardOutput());
    // strip /n
    speakerVolRead.chop(1);
    speakerVolProcess.close();
    qDebug() << speakerVolRead;
}

QString Example::getHeadphoneVol() {
    headphones();
    qDebug() << "getHeadphoneVol: " << headphoneVolRead;
    qDebug() << "headphone vol read";
    headphoneVolProcess.start("bash /opt/click.ubuntu.com/qtaudio.kaputnikgo/current/scripts/headphone_vol.sh");
    headphoneVolProcess.waitForFinished();
    headphoneVolRead = QString(headphoneVolProcess.readAllStandardOutput());
    // strip /n
    headphoneVolRead.chop(1);
    headphoneVolProcess.close();
    qDebug() << headphoneVolRead;
    return headphoneVolRead;
}
void Example::setHeadphoneVol(const QString &t) {
    // check t is in range and is number
    if (t != headphoneVolRead) {
        headphoneVolRead = t;
        emit headphoneVolChanged();
    }
}
QString Example::getSpeakerVol() {
    speakers();
    qDebug() << "getSpeakerVol: " << speakerVolRead;
    qDebug() << "speaker vol read";
    speakerVolProcess.start("bash /opt/click.ubuntu.com/qtaudio.kaputnikgo/current/scripts/speaker_vol.sh");
    speakerVolProcess.waitForFinished();
    speakerVolRead = QString(speakerVolProcess.readAllStandardOutput());
    // strip /n
    speakerVolRead.chop(1);
    speakerVolProcess.close();
    qDebug() << speakerVolRead;
    return speakerVolRead;
}
void Example::setSpeakerVol(const QString &t) {
    // check t i sin range and is number
    if (t != speakerVolRead) {
        speakerVolRead = t;
        emit speakerVolChanged();
    }
}

void Example::onHeadphoneFinished(int exitCode, QProcess::ExitStatus exitStatus) {
    qDebug() << "Headphone on finished";
    qDebug() << "exit code" << exitCode << "exit status" << exitStatus;
}
void Example::onSpeakerFinished(int exitCode, QProcess::ExitStatus exitStatus) {
    qDebug() << "Speaker on finished";
    qDebug() << "exit code" << exitCode << "exit status" << exitStatus;
}
void Example::onHeadphoneVolFinished(int exitCode, QProcess::ExitStatus exitStatus) {
    qDebug() << "Headphone Vol read finished";
    qDebug() << "exit code" << exitCode << "exit status" << exitStatus;
}
void Example::onSpeakerVolFinished(int exitCode, QProcess::ExitStatus exitStatus) {
    qDebug() << "Speaker Vol read finished";
    qDebug() << "exit code" << exitCode << "exit status" << exitStatus;
}
