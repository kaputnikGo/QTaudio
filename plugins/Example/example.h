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

#ifndef EXAMPLE_H
#define EXAMPLE_H

#include <QObject>
#include <QProcess>
#include <QtMultimedia/QMediaPlayer>

#include "audiogen.h"

class Example: public QObject {
    Q_OBJECT

    Q_PROPERTY(QString headphoneVolRead READ getHeadphoneVol WRITE setHeadphoneVol NOTIFY headphoneVolChanged)
    Q_PROPERTY(QString speakerVolRead READ getSpeakerVol WRITE setSpeakerVol NOTIFY speakerVolChanged)
    Q_PROPERTY(QString micMutesRead READ getMicMutes WRITE setMicMutes NOTIFY micMutesChanged)
    Q_PROPERTY(qint64 playheadRead READ getPlayhead WRITE setPlayhead NOTIFY playheadChanged)

  public:
    Example();
    ~Example() = default;

    Q_INVOKABLE void getInitState();
    Q_INVOKABLE QString getSpeakerState();
    Q_INVOKABLE QString getHeadphoneState();

    Q_INVOKABLE void headphones();
    Q_INVOKABLE void readHeadphoneVol();
    Q_INVOKABLE QString getHeadphoneVol();

    Q_INVOKABLE void speakers();
    Q_INVOKABLE void readSpeakerVol();
    Q_INVOKABLE QString getSpeakerVol();

    Q_INVOKABLE void micMute();
    Q_INVOKABLE void mic1Unmute();
    Q_INVOKABLE void mic2Unmute();
    Q_INVOKABLE QString getMicMutes();

    Q_INVOKABLE void audioSetup();
    Q_INVOKABLE void playAlice();
    Q_INVOKABLE void stopAlice();

    Q_INVOKABLE qint64 getPlayhead();
    Q_INVOKABLE QString getPlayheadText();
    Q_INVOKABLE qint64 getDuration();

    Q_INVOKABLE void runAudioGen();
    Q_INVOKABLE void toggleAudioGen();
    Q_INVOKABLE int getCurrentToneFreq();
    Q_INVOKABLE void destructor();


    void setHeadphoneVol(const QString &t);
    void setSpeakerVol(const QString &t);
    void setMicMutes(const QString &t);
    void setPlayhead(qint64 val);

    QMediaPlayer qMediaPlayer;

  private Q_SLOTS:
    void onHeadphoneFinished(int exitCode, QProcess::ExitStatus exitStatus);
    void onSpeakerFinished(int exitCode, QProcess::ExitStatus exitStatus);
    void onHeadphoneVolFinished(int exitCode, QProcess::ExitStatus exitStatus);
    void onSpeakerVolFinished(int exitCode, QProcess::ExitStatus exitStatus);
    void onMicMuteFinished(int exitCode, QProcess::ExitStatus exitStatus);
    void onMic1UnmuteFinished(int exitCode, QProcess::ExitStatus exitStatus);
    void onMic2UnmuteFinished(int exitCode, QProcess::ExitStatus exitStatus);
    void onInitStateFinished(int exitCode, QProcess::ExitStatus exitStatus);
    void positionChanged(qint64 position);
    void durationChanged(qint64 duration);

  signals:
    void headphoneVolChanged();
    void speakerVolChanged();
    void micMutesChanged();
    void playheadChanged();

  private:
    QProcess headphoneProcess;
    QProcess speakerProcess;
    QProcess headphoneVolProcess;
    QProcess speakerVolProcess;
    QProcess micMuteProcess;
    QProcess mic1UnmuteProcess;
    QProcess mic2UnmuteProcess;
    QProcess initStateProcess;

    QString initStateRead;
    QString speakerState;
    QString headphoneState;
    QString headphoneVolRead;
    QString speakerVolRead;
    QString micMutesRead;

    qint64 playheadRead;

    //QMediaPlayer qMediaPlayer;
    AudioGenTest audioGenTest;

};

#endif
