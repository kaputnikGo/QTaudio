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

    //
    state: settings.state
    states: [
        State {
            name: "active"
        },
        State {
            name: "inactive"
        }
    ]

    Settings {
        id: settings
        property string state: "active"
    }

    Component.onDestruction: {
        settings.state = page.state
        Example.destructor()
    }

    Page {
        id: page1
        anchors.fill: parent

        MediaPlayer {
            id: clickSound
            source: "file:///opt/click.ubuntu.com/qtaudio.kaputnikgo/current/assets/Stapler-sfx.ogg"
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
                  clickSound.stop()
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
                  clickSound.stop()
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

// add a <hr /> type thing here
            Label {
                id: separator1
                Layout.alignment: Qt.AlignHCenter
                anchors {
                  top: label4.bottom
                  topMargin: 12
                }
                text: i18n.tr('__________________________________________')
            }
//
// ALL MIC MUTE
//
            Label {
                id: label5
                Layout.alignment: Qt.AlignHCenter
                anchors {
                  top: separator1.bottom
                  topMargin: 24
                }
                text: i18n.tr('Press to mute all mics')
            }
            Button {
                id: button5
                Layout.alignment: Qt.AlignHCenter
                anchors {
                  top: label5.bottom
                  topMargin: 8
                }
                text: i18n.tr('Mic mute')
                color: UbuntuColors.graphite
                onClicked: {
                  clickSound.stop()
                  clickSound.play()
                  Example.micMute()
                  label5.text = "all mics muted."
                  button5.color = UbuntuColors.red
                  button6.color = UbuntuColors.graphite
                  button7.color = UbuntuColors.graphite
                  // clear previous display
                  label6.text = "Press to unmute Mic1 Handset"
                  label7.text = "Press to unmute Mic2 Headset"

                }
            }
//
// MIC 1 UNMUTE
//
            Label {
                id: label6
                Layout.alignment: Qt.AlignHCenter
                anchors {
                  top: button5.bottom
                  topMargin: 24
                }
                text: i18n.tr('Press to unmute Mic1 Handset')
            }
            Button {
                id: button6
                Layout.alignment: Qt.AlignHCenter
                anchors {
                  top: label6.bottom
                  topMargin: 8
                }
                text: i18n.tr('Mic1 Handset unmute')
                color: UbuntuColors.graphite
                onClicked: {
                  clickSound.stop()
                  clickSound.play()
                  Example.mic1Unmute()
                  label6.text = "Mic1 unmuted."
                  button6.color = UbuntuColors.green
                  button5.color = UbuntuColors.graphite
                  // clear previous display
                  label5.text = "Press to mute all mics"
                }
            }
//
// MIC 2 UNMUTE
//
            Label {
                id: label7
                Layout.alignment: Qt.AlignHCenter
                anchors {
                  top: button6.bottom
                  topMargin: 24
                }
                text: i18n.tr('Press to unmute Mic2 Headset')
            }
            Button {
                id: button7
                Layout.alignment: Qt.AlignHCenter
                anchors {
                  top: label7.bottom
                  topMargin: 8
                }
                text: i18n.tr('Mic2 Headset unmute')
                color: UbuntuColors.graphite
                onClicked: {
                  clickSound.stop()
                  clickSound.play()
                  Example.mic2Unmute()
                  label7.text = "Mic2 unmuted."
                  button7.color = UbuntuColors.green
                  button5.color = UbuntuColors.graphite
                  // clear previous display
                  label5.text = "Press to mute all mics"
                }
            }

// add <hr /> thing here
            Label {
                id: separator2
                Layout.alignment: Qt.AlignHCenter
                anchors {
                  top: button7.bottom
                  topMargin: 12
                }
                text: i18n.tr('__________________________________________')
            }
//
// QAUDIO DEVICE SETUP
//
            Label {
                id: label8
                Layout.alignment: Qt.AlignHCenter
                anchors {
                  top: separator2.bottom
                  topMargin: 24
                }
                text: i18n.tr('Setup and load QAudio')
            }
            Button {
                id: button8
                Layout.alignment: Qt.AlignHCenter
                anchors {
                  top: label8.bottom
                  topMargin: 8
                }
                text: i18n.tr('QAudio Setup')
                color: UbuntuColors.orange
                onClicked: {
                  clickSound.stop()
                  clickSound.play()
                  Example.audioSetup()
                  label8.text = "Setup and loaded QAudio to debug."
                  label9.text = "Play AlicePt1.ogg, 10:40 mins"
                }
            }
//
// PLAY OGG FILE
//
            Label {
                id: label9
                Layout.alignment: Qt.AlignHCenter
                anchors {
                  top: button8.bottom
                  topMargin: 24
                }
                text: i18n.tr('press QAudio Setup to load file')
            }
            Button {
                id: button9
                Layout.alignment: Qt.AlignHCenter
                anchors {
                  top: label9.bottom
                  topMargin: 8
                }
                text: i18n.tr('Play Audio')
                color: UbuntuColors.slate
                onClicked: {
                  clickSound.stop()
                  clickSound.play()
                  Example.playAlice()
                  button9.color = UbuntuColors.green
                  button10.color = UbuntuColors.slate
                  label9.text = "Playing AlicePt1.ogg now..."
                }
            }
            Button {
                id: button10
                Layout.alignment: Qt.AlignHCenter
                anchors {
                  top: button9.bottom
                  topMargin: 12
                }
                text: i18n.tr('Stop Audio')
                color: UbuntuColors.slate
                onClicked: {
                  clickSound.stop()
                  clickSound.play()
                  Example.stopAlice()
                  button9.color = UbuntuColors.slate
                  button10.color = UbuntuColors.green
                  // this logic not good, needs a checkIfLoaded()
                  label9.text = "Play AlicePt1.ogg, 10:40 mins"
                }
            }
// add <hr /> thing here
            Label {
                id: separator3
                Layout.alignment: Qt.AlignHCenter
                anchors {
                  top: button10.bottom
                  topMargin: 12
                }
                text: i18n.tr('__________________________________________')
            }
//
// CALL AUDIOGEN
//
            Label {
                id: label11
                Layout.alignment: Qt.AlignHCenter
                anchors {
                  top: separator3.bottom
                  topMargin: 24
                }
                text: i18n.tr('press to toggle AudioGen')
            }
            Button {
                id: button11
                Layout.alignment: Qt.AlignHCenter
                anchors {
                  top: label11.bottom
                  topMargin: 8
                }
                text: i18n.tr('Toggle AudioGen')
                color: UbuntuColors.slate
                onClicked: {
                  clickSound.stop()
                  clickSound.play()
                  Example.callAudioGen()
                  button11.color = UbuntuColors.blue
                  label11.text = "AudioGen toggled off/on..."
                }
            }
        }
    }
}
