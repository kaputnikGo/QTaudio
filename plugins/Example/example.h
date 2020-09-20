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

class Example: public QObject {
    Q_OBJECT

  public:
    Example();
    ~Example() = default;

    Q_INVOKABLE void speakers();
    Q_INVOKABLE void headphones();

  private Q_SLOTS:
    void onHeadphoneFinished(int exitCode, QProcess::ExitStatus exitStatus);
    void onSpeakerFinished(int exitCode, QProcess::ExitStatus exitStatus);


  private:
    QProcess headphoneProcess;
    QProcess speakerProcess;

};

#endif
