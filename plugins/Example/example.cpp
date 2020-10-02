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
#include <QMediaPlayer>
#include <QString>
#include <QTime>

#include "example.h"
#include "audiogen.h"

using namespace std;

Example::Example() :
  headphoneProcess(),
  speakerProcess(),
  headphoneVolProcess(),
  speakerVolProcess(),
  micMuteProcess(),
  mic1UnmuteProcess(),
  mic2UnmuteProcess(),
  initStateProcess(),
  headphoneVolRead('0'),
  speakerVolRead('0'),
  micMutesRead('0'),
  initStateRead('0'),
  speakerState('0'),
  headphoneState('0'),
  playheadRead('0'),
  qMediaPlayer(),
  audioGenTest()
{
    connect(&headphoneProcess, SIGNAL(finished(int, QProcess::ExitStatus)), this, SLOT(onHeadphoneFinished(int, QProcess::ExitStatus)));
    connect(&speakerProcess, SIGNAL(finished(int, QProcess::ExitStatus)), this, SLOT(onSpeakerFinished(int, QProcess::ExitStatus)));
    connect(&headphoneVolProcess, SIGNAL(finished(int, QProcess::ExitStatus)), this, SLOT(onHeadphoneVolFinished(int, QProcess::ExitStatus)));
    connect(&speakerVolProcess, SIGNAL(finished(int, QProcess::ExitStatus)), this, SLOT(onSpeakerVolFinished(int, QProcess::ExitStatus)));
    connect(&micMuteProcess, SIGNAL(finished(int, QProcess::ExitStatus)), this, SLOT(onMicMuteFinished(int, QProcess::ExitStatus)));
    connect(&mic1UnmuteProcess, SIGNAL(finished(int, QProcess::ExitStatus)), this, SLOT(onMic1UnmuteFinished(int, QProcess::ExitStatus)));
    connect(&mic2UnmuteProcess, SIGNAL(finished(int, QProcess::ExitStatus)), this, SLOT(onMic2UnmuteFinished(int, QProcess::ExitStatus)));
    connect(&initStateProcess, SIGNAL(finished(int, QProcess::ExitStatus)), this, SLOT(onInitStateFinished(int, QProcess::ExitStatus)));
    connect(&qMediaPlayer, &QMediaPlayer::positionChanged, this, &Example::positionChanged);
    connect(&qMediaPlayer, &QMediaPlayer::durationChanged, this, &Example::durationChanged);
}

// TODO :: cldean up this mess :)

/******************************************************************************/
void Example::speakers() {
    // called from qml button: headphones vol 2%, speakers 85%
    qDebug() << "speakers on";
    // hardcoded location bad ...
    speakerProcess.start("bash /opt/click.ubuntu.com/qtaudio.kaputnikgo/current/scripts/speakers.sh");
    speakerProcess.waitForFinished();
    speakerProcess.close();
    // load the volume
    readSpeakerVol();
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
QString Example::getSpeakerVol() {
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
    // check t is in range and is number
    if (t != speakerVolRead) {
        speakerVolRead = t;
        emit speakerVolChanged();
    }
}

void Example::onSpeakerFinished(int exitCode, QProcess::ExitStatus exitStatus) {
    qDebug() << "Speaker on finished";
    qDebug() << "exit code" << exitCode << "exit status" << exitStatus;
}
void Example::onSpeakerVolFinished(int exitCode, QProcess::ExitStatus exitStatus) {
    qDebug() << "Speaker Vol read finished";
    qDebug() << "exit code" << exitCode << "exit status" << exitStatus;
}

/******************************************************************************/

void Example::headphones() {
    // called from qml button: unmute headphones vol 85%, speakers 2%.
    qDebug() << "headphones on";
    // hardcode location bad...
    headphoneProcess.start("bash /opt/click.ubuntu.com/qtaudio.kaputnikgo/current/scripts/headphones.sh");
    headphoneProcess.waitForFinished();
    headphoneProcess.close();
    // load the volume
    readHeadphoneVol();
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
QString Example::getHeadphoneVol() {
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

void Example::onHeadphoneFinished(int exitCode, QProcess::ExitStatus exitStatus) {
    qDebug() << "Headphone on finished";
    qDebug() << "exit code" << exitCode << "exit status" << exitStatus;
}
void Example::onHeadphoneVolFinished(int exitCode, QProcess::ExitStatus exitStatus) {
    qDebug() << "Headphone Vol read finished";
    qDebug() << "exit code" << exitCode << "exit status" << exitStatus;
}

/******************************************************************************/

// mute all
void Example::micMute() {
    qDebug() << "Mic mute called.";
    micMuteProcess.start("bash /opt/click.ubuntu.com/qtaudio.kaputnikgo/current/scripts/mic_mute.sh");
    micMuteProcess.waitForFinished();
    micMuteProcess.close();
    qDebug() << "Mic mute process closed.";
}
void Example::onMicMuteFinished(int exitCode, QProcess::ExitStatus exitStatus) {
    qDebug() << "Mic mute on finished";
    qDebug() << "exit code" << exitCode << "exit status" << exitStatus;
}
// MIC 1
void Example::mic1Unmute() {
    qDebug() << "Mic1 unmute called.";
    micMuteProcess.start("bash /opt/click.ubuntu.com/qtaudio.kaputnikgo/current/scripts/mic1_unmute.sh");
    micMuteProcess.waitForFinished();
    micMuteProcess.close();
    qDebug() << "Mic1 unmute process closed.";
}
void Example::onMic1UnmuteFinished(int exitCode, QProcess::ExitStatus exitStatus) {
    qDebug() << "Mic1 unmute on finished";
    qDebug() << "exit code" << exitCode << "exit status" << exitStatus;
}
// MIC 2
void Example::mic2Unmute() {
    qDebug() << "Mic2 unmute called.";
    micMuteProcess.start("bash /opt/click.ubuntu.com/qtaudio.kaputnikgo/current/scripts/mic2_unmute.sh");
    micMuteProcess.waitForFinished();
    micMuteProcess.close();
    qDebug() << "Mic2 unmute process closed.";
}
void Example::onMic2UnmuteFinished(int exitCode, QProcess::ExitStatus exitStatus) {
    qDebug() << "Mic2 unmute on finished";
    qDebug() << "exit code" << exitCode << "exit status" << exitStatus;
}
/******************************************************************************/

void Example::audioSetup() {
    qDebug() << "audioSetup get device info:";
    const auto deviceInfos = QAudioDeviceInfo::availableDevices(QAudio::AudioOutput);

    for (const QAudioDeviceInfo &deviceInfo : deviceInfos) {
      qDebug() << "Device name: " << deviceInfo.deviceName();
    }
    // no media is loaded so values will reflect a default state
    qDebug() << "qmediaplayer invoke";
    qDebug() << "isAudioAvailable: " << qMediaPlayer.isAudioAvailable(); // false
    qDebug() << "current state: " << qMediaPlayer.state(); // StoppedState
    qDebug() << "media status: " << qMediaPlayer.mediaStatus(); // NoMedia
    qDebug() << "audio role: " << qMediaPlayer.audioRole(); // MusicRole
    // looks for "file://" + "yourfileyouwanttoplay.mp3"
    qMediaPlayer.setMedia(QUrl::fromLocalFile(QStringLiteral("/opt/click.ubuntu.com/qtaudio.kaputnikgo/current/assets/AlicePt1.ogg"))); // working
}
void Example::playAlice() {
    // check for qMediaPlayer.mediaStatus() == QMediaPlayer::LoadedMedia
    qDebug() << "playAlice called, status: " << qMediaPlayer.mediaStatus(); // returns loadingMedia
    if (qMediaPlayer.mediaStatus() == QMediaPlayer::LoadingMedia) {
        qDebug() << "Check: Alice is loading, try play.";
        // default vol = 100, set volume to 50, not logarithmic
        if (qMediaPlayer.volume() == 100) {
            qMediaPlayer.setVolume(50);
        }
        qMediaPlayer.play();
    }
    else {
        qDebug() << "Check: Alice not loading: " << qMediaPlayer.mediaStatus();
    }
}
void Example::stopAlice() {
    qDebug() << "stopAlice called, status: " << qMediaPlayer.mediaStatus(); // returns
    qMediaPlayer.stop();
}

qint64 Example::getPlayhead() {
    // do some checks first, convert to mins:secs
    return qMediaPlayer.position() / 1000;
}

QString Example::getPlayheadText() {
    // this is slow, mainly every second updates.
    QString tStr;
    qint64 currentInfo = qMediaPlayer.position(); // / 1000;
    // QTime (int h, int m, int s = 0, int ms = 0)
    // should be no hours info.
    if (currentInfo > 0) {
        QTime currentTime(
          (currentInfo / 3600) % 60,
          (currentInfo / 60) % 60,
          currentInfo % 60,
          (currentInfo * 1000) % 1000
        );
        QString format = "mm:ss";
        tStr = currentTime.toString(format);
    }
    return tStr;
}

void Example::setPlayhead(qint64 val) {
    // not yet

/*
    playheadSlider->setTracking(false);
    //playheadSlider->live(false);
    if (val != 0) {
      playheadSlider->setValue(val / 1000);
    }
    playheadSlider->setTracking(true);
    // push it to a var in qml
*/
    // emit signal of change
    //playheadChanged();
}

void Example::positionChanged(qint64 position) {
    // gets mediaplayer position signal updates to this class
    playheadRead = position / 1000;
    playheadChanged();
}
void Example::durationChanged(qint64 duration) {
    // file length has been loaded, in ms so / 1000 for seconds etc.
    // gets called multiple times.
    qDebug() << "durationChanged duration: " << duration; // 640520
}

qint64 Example::getDuration() {
    return qMediaPlayer.duration() / 1000;
}
/*
void Example::playheadChanged() {
   //
}
*/

/******************************************************************************/

void Example::runAudioGen() {
    qDebug() << "runAudioGen called from qml";
    //AudioTest audioGenTest;
    audioGenTest.runAudioGenTest();
}
void Example::toggleAudioGen() {
    qDebug() << "toggleAudioGen called from qml";
    audioGenTest.toggleSuspendResume();
}
int Example::getCurrentToneFreq() {
    audioGenTest.getCurrentToneFreq();
}

/******************************************************************************/



/******************************************************************************/

void Example::getInitState() {
    // call the init_state.sh script (is a bash not sh)
    // returns string "on+off"
    qDebug() << "initState called.";
    initStateProcess.start("bash /opt/click.ubuntu.com/qtaudio.kaputnikgo/current/scripts/init_state.sh");
    initStateProcess.waitForFinished();
    initStateRead = QString(initStateProcess.readAllStandardOutput());
    initStateProcess.close();
    // speakerState = first part
    QStringList list_str = initStateRead.split("+");
    speakerState = list_str.first();
    // headphoneState = second part
    headphoneState = list_str.back();
    // strip /n
    headphoneState.chop(1);
    qDebug() << "initState read is Spkr: " << speakerState << " Hdph: " << headphoneState;

}

void Example::onInitStateFinished(int exitCode, QProcess::ExitStatus exitStatus) {
    qDebug() << "initState read finished";
    qDebug() << "exit code" << exitCode << "exit status" << exitStatus;
}

QString Example::getSpeakerState() {
    return speakerState;
}
QString Example::getHeadphoneState() {
    return headphoneState;
}

/******************************************************************************/

void Example::destructor() {
    // try and catch app close/exit/destroy etc - DOES NOT
    qDebug() << "DESTRUCTOR CALLED.";
}
