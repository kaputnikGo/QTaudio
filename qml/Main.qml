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

    Component.onDestruction: {
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
                topMargin: 18
            }
            /*
            // expander item
            Item {
              Layout.fillWidth: true
              // or
              Layout.fillHeight: true
            }
            */
// HEADPHONES/SPEAKER ENABLE
            Label {
                id: label1
                anchors {
                  top: parent.top
                  topMargin: 24
                }
                Layout.alignment: Qt.AlignHCenter
                text: i18n.tr('Switch between headphones or speaker')
            }

          // make buttons in a row
            Row {
                id: outputRow
                spacing: units.gu(2)
                height: units.gu(6) // needs a height else 1px
                anchors {
                    margins: units.gu(2)
                    top: label1.bottom
                    left: parent.left
                    right: parent.right
                }
                Layout.alignment: Qt.AlignHCenter

                Button {
                    id: button1
                    anchors {
                        top: label1.bottom
                        left: outputRow.left
                        topMargin: 8
                    }
                    text: i18n.tr('Headphones')
                    color: UbuntuColors.graphite
                    onClicked: {
                      clickSound.stop()
                      clickSound.play()
                      label1.text = "headphones unmute vol 80%, speakers vol 2%."
                      button1.color = UbuntuColors.green
                      button3.color = UbuntuColors.graphite
                      label2.text = "current headphone volume: " + Example.getHeadphoneVol()
                    }
                }
                Button {
                    id: button3
                    anchors {
                      top: label1.bottom
                      right: outputRow.right
                      topMargin: 8
                    }
                    text: i18n.tr('Speakers')
                    color: UbuntuColors.graphite
                    onClicked: {
                      clickSound.stop()
                      clickSound.play()
                      label1.text = "headphones vol 2%, speakers vol 80%."
                      button3.color = UbuntuColors.green
                      button1.color = UbuntuColors.graphite
                      label2.text = "current speaker volume: " + Example.getSpeakerVol()
                    }
                }
            }// end buttons row

// DISPLAY VOLUME
// replace this with a volume slider
            Label {
                id: label2
                Layout.alignment: Qt.AlignHCenter
                anchors {
                  top: button3.bottom
                  topMargin: 8
                }
                text: i18n.tr('display current volume')
            }

// add a <hr /> type thing here
            Label {
                id: separator1
                Layout.alignment: Qt.AlignHCenter
                anchors {
                  top: label2.bottom
                  topMargin: 12
                }
                text: i18n.tr('_______________________________________________')
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
// MIC UNMUTE
//

            Label {
                id: label6
                Layout.alignment: Qt.AlignHCenter
                anchors {
                  top: button5.bottom
                  topMargin: 24
                }
                text: i18n.tr('Press to unmute either mic.')
            }

        // make MIC buttons in a row
            Row {
                id: unmuteRow
                spacing: units.gu(2)
                height: units.gu(4) // needs a height else 1px
                anchors {
                    margins: units.gu(2)
                    top: label6.bottom
                    left: parent.left
                    right: parent.right
                }
                Layout.alignment: Qt.AlignHCenter

// DO NOT ALLOW MIC1 handset while SPEAKER.
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
                      // toggle Headphones
                      button1.clicked()
                      label6.text = "Mic1 Handset unmuted."
                      button6.color = UbuntuColors.green
                      button5.color = UbuntuColors.graphite
                      // lastly:
                      Example.mic1Unmute()
                    }
                }

// DO NOT ALLOW MIC2 headset while HEADPHONES.
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
                      // toggle Speakers
                      button3.clicked()
                      Example.mic2Unmute()
                      label6.text = "Mic2 Headset unmuted."
                      button7.color = UbuntuColors.green
                      button5.color = UbuntuColors.graphite
                      // lastly:
                      Example.mic2Unmute()
                    }
                }
            }// end row

// add a mic gain slider here

// add <hr /> thing here
            Label {
                id: separator2
                Layout.alignment: Qt.AlignHCenter
                anchors {
                  top: button7.bottom
                  topMargin: 2
                }
                text: i18n.tr('_______________________________________________')
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
                  label8.text = "Setup and loaded QAudio and debug log."
                  label9.text = "Play AlicePt1.ogg, 10:40 mins"
                }
            }
//
// PLAY/STOP OGG FILE
//
            Label {
                id: label9
                Layout.alignment: Qt.AlignHCenter
                anchors {
                  top: button8.bottom
                  topMargin: 24
                }
                text: i18n.tr('press QAudio Setup to load file first')
            }
            // play/stop buttons row
            Row {
                id: qaudioRow
                spacing: units.gu(2)
                height: units.gu(6) // needs a height else 1px
                anchors {
                    margins: units.gu(2)
                    top: label9.bottom
                    left: parent.left
                    right: parent.right
                }
                Layout.alignment: Qt.AlignHCenter

                Button {
                    id: button9
                    anchors {
                      top: label9.bottom
                      left: qaudioRow.left
                      topMargin: 8
                    }
                    text: i18n.tr('Play ogg Audio')
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
                    anchors {
                      top: label9.bottom
                      right: qaudioRow.right
                      topMargin: 12
                    }
                    text: i18n.tr('Stop ogg Audio')
                    color: UbuntuColors.slate
                    onClicked: {
                      clickSound.stop()
                      clickSound.play()
                      Example.stopAlice()
                      button9.color = UbuntuColors.slate
                      button10.color = UbuntuColors.green
                      // this logic not good, needs a checkIfLoaded()
                      label9.text = "Stopped AlicePt1.ogg"
                    }
                }
            } // end row

// add a qAudio volume slider here / playhead slider

// add <hr /> thing here
            Label {
                id: separator3
                Layout.alignment: Qt.AlignHCenter
                anchors {
                  top: button10.bottom
                  topMargin: 12
                }
                text: i18n.tr('_______________________________________________')
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
                text: i18n.tr('press to run AudioGen')
            }
            Button {
                id: button11
                Layout.alignment: Qt.AlignHCenter
                anchors {
                  top: label11.bottom
                  topMargin: 8
                }
                text: i18n.tr('Run AudioGen')
                color: UbuntuColors.slate
                onClicked: {
                  clickSound.stop()
                  clickSound.play()
                  Example.runAudioGen()
                  button11.color = UbuntuColors.red
                  button11.text = "Stop AudioGen"
                  // logic state here too...
                  // label11.text: button11.onClicked? "blah" : "Other blah"
                  label11.text = "AudioGen running/stopped"
                }
            }
            Label {
                id: label12
                Layout.alignment: Qt.AlignHCenter
                anchors {
                  top: button11.bottom
                  topMargin: 24
                }
                text: i18n.tr('toggle pause AudioGen')
            }
            Button {
                id: button12
                Layout.alignment: Qt.AlignHCenter
                anchors {
                  top: label12.bottom
                  topMargin: 8
                }
                text: i18n.tr('Pause AudioGen')
                color: UbuntuColors.slate
                onClicked: {
                  clickSound.stop()
                  clickSound.play()
                  Example.toggleAudioGen()
                  button12.color = UbuntuColors.blue
                  button12.text = "Resume AudioGen"
                  // logic state here
                  label12.text = "AudioGen paused/resumed"
                }
            }

// add QAudio volume slider here?

        } // end ColumnLayout
    } // end Page
} // end MainView
