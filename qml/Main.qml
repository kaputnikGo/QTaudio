/*
 * Copyright (C) 2020  Kaputnik Go
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; version 3.
 *
 * QTtemplate is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

import QtQuick 2.7
import Ubuntu.Components 1.3
//import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import Qt.labs.settings 1.0
import QtMultimedia 5.4

import Example 1.0

MainView {
    id: root
    objectName: 'mainView'
    applicationName: 'qtaudio.kaputnikgo'
    automaticOrientation: true

    width: units.gu(45)
    height: units.gu(100)

    Page {
        id: page1
        anchors.fill: parent

        MediaPlayer {
            id: clickSound
            source: "../assets/Stapler-sfx.ogg"
        }

        header: PageHeader {
            id: header
            title: i18n.tr('QTaudio')
        }

        ColumnLayout {
            spacing: units.gu(2)
            anchors {
                margins: units.gu(2)
                top: header.bottom
                left: parent.left
                right: parent.right
                bottom: parent.bottom
                topMargin: 24
            }
// HEADPHONES ENABLE
            Label {
                id: label1
                anchors {
                  top: parent.top
                  topMargin: 24
                }
                Layout.alignment: Qt.AlignHCenter
                text: i18n.tr('Press to enable headphones')
            }
            Button {
                id: button1
                Layout.alignment: Qt.AlignHCenter
                anchors {
                  top: label1.bottom
                  topMargin: 8
                }
                text: i18n.tr('Headphones')
                color: UbuntuColors.graphite
                onClicked: {
                  clickSound.play()
                  //Example.headphones()
                  label1.text = "headphones unmute vol 85%, speakers vol 2%."
                  button1.color = UbuntuColors.green
                  button3.color = UbuntuColors.graphite
                  // clear previous display
                  label3.text = "Press to enable speakers"
                  label4.text = "display speaker volume"
                  // update readvol text
                  //Example.readHeadphoneVol()
                  label2.text = "current headphone volume: " + Example.getHeadphoneVol()
                }
            }
// DISPLAY HEADPHONE VOLUME
            Label {
                id: label2
                Layout.alignment: Qt.AlignHCenter
                anchors {
                  top: button1.bottom
                  topMargin: 8
                }
                text: i18n.tr('display headphone volume')
            }
//
// SPEAKERS ENABLE
//
            Label {
                id: label3
                Layout.alignment: Qt.AlignHCenter
                anchors {
                  top: label2.bottom
                  topMargin: 24
                }
                text: i18n.tr('Press to enable speakers')
            }
            Button {
                id: button3
                Layout.alignment: Qt.AlignHCenter
                anchors {
                  top: label3.bottom
                  topMargin: 8
                }
                text: i18n.tr('Speakers')
                color: UbuntuColors.graphite
                onClicked: {
                  clickSound.play()
                  //Example.speakers()
                  label3.text = "headphones vol 2%, speakers vol 85%."
                  button3.color = UbuntuColors.green
                  button1.color = UbuntuColors.graphite
                  // clear previous display
                  label1.text = "Press to enable headphones"
                  label2.text = "display headphone volume"
                  // update speaker vol text
                  //Example.readSpeakerVol()
                  // is getting old value (3), needs to be pressed again to update
                  label4.text = "current speaker volume: " + Example.getSpeakerVol()
                }
            }
// DISPLAY SPEAKER VOL
            Label {
                id: label4
                Layout.alignment: Qt.AlignHCenter
                anchors {
                  top: button3.bottom
                  topMargin: 24
                }
                text: i18n.tr('display speaker volume')
            }
        }
    }
}
