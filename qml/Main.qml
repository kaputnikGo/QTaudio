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

    //theme.name: "Ubuntu.Components.Themes.SuruDark
    // width needs be 51.5 on reolad qml...
    width: units.gu(51)
    height: units.gu(102)

    PageStack {
        id: mainPageStack
        anchors.fill: parent
        Component.onCompleted: push(pageMain)

        Page {
            id: pageMain
            anchors.fill: parent
            visible: false

            MediaPlayer {
                id: clickSound
                source: "file:///opt/click.ubuntu.com/qtaudio.kaputnikgo/current/assets/Stapler-sfx.ogg"
            }

            header: PageHeader {
                id: headerMain
                width: parent.width // match parent
                title: i18n.tr('QTaudio checker')

                ActionBar {
                    anchors {
                        top: headerMain.top
                        right: headerMain.right
                    }
                    numberOfSlots: 1
                    actions: [
                        Action {
                            //iconName: "starred"
                            text: "Record"
                            onTriggered: mainPageStack.push(Qt.resolvedUrl("Record.qml"))
                        },
                        Action {
                            text: "About"
                            onTriggered: mainPageStack.push(Qt.resolvedUrl("About.qml"))
                        }
                    ]
                }
            }

            ColumnLayout {
                spacing: units.gu(2)
                Layout.alignment: Qt.AlignHCenter
                anchors {
                    margins: units.gu(2)
                    top: headerMain.bottom
                    left: parent.left
                    right: parent.right
                    bottom: parent.bottom
                    topMargin: 18
                }

                Component.onCompleted: {
                    // note: this is init state,
                    // both outputs can be on/off at same time
                    Example.getInitState()
                    // set output button colours and get vol
                    if (Example.getSpeakerState() == "on") {
                        speakerSlider.value = Example.getSpeakerVol()
                        buttonSpeaker.color = UbuntuColors.green
                    }
                    else {
                        // speaker is off
                        buttonSpeaker.color = UbuntuColors.red
                    }
                    //
                    if (Example.getHeadphoneState() == "on") {
                        headphoneSlider.value = Example.getHeadphoneVol()
                        buttonHeadphone.color = UbuntuColors.green
                    }
                    else {
                        // headphone is off
                        buttonHeadphone.color = UbuntuColors.red
                    }
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
                      topMargin: units.gu(2)
                    }
                    Layout.alignment: Qt.AlignHCenter
                    text: i18n.tr('Switch between headphones or speaker')
                }

              // make buttons in a row
                Row {
                    id: outputRow
                    spacing: units.gu(2)
                    height: units.gu(6) // needs a height else 1px
                    width: parent.width // match parent
                    anchors {
                        margins: units.gu(2)
                    }
                    Layout.alignment: Qt.AlignHCenter

                    Button {
                        id: buttonHeadphone
                        Layout.alignment: Qt.AlignLeft
                        anchors {
                            top: outputRow.top
                            topMargin: units.gu(2)
                        }
                        text: i18n.tr('Headphones')
                        color: UbuntuColors.graphite
                        onClicked: {
                          clickSound.stop()
                          clickSound.play()
                          Example.headphones()
                          label1.text = "headphones vol 80%, speakers vol 2%."
                          buttonHeadphone.color = UbuntuColors.green
                          headphoneSlider.value = Example.getHeadphoneVol()
                          buttonSpeaker.color = UbuntuColors.red
                          speakerSlider.value = Example.getSpeakerVol()
                        }
                    }
                    Button {
                        id: buttonSpeaker
                        Layout.alignment: Qt.AlignRight
                        anchors {
                          top: outputRow.top
                          topMargin: units.gu(2)
                        }
                        text: i18n.tr('Speakers')
                        color: UbuntuColors.graphite
                        onClicked: {
                          clickSound.stop()
                          clickSound.play()
                          Example.speakers()
                          label1.text = "headphones vol 2%, speakers vol 80%."
                          buttonSpeaker.color = UbuntuColors.green
                          speakerSlider.value = Example.getSpeakerVol()
                          buttonHeadphone.color = UbuntuColors.red
                          headphoneSlider.value = Example.getHeadphoneVol()
                        }
                    }
                }// end buttons row

    // DISPLAY SPEAKER VOLUME
                Row {
                    id: spkrVolRow
                    spacing: units.gu(2)
                    height: units.gu(6) // needs a height else 1px
                    width: parent.width // match parent
                    anchors {
                        margins: units.gu(2)
                    }
                    Layout.alignment: Qt.AlignHCenter
                    Text {
                        text: "spkr"
                        Layout.alignment: Qt.AlignLeft
                    }
                    Slider {
                        id: speakerSlider
                        Layout.alignment: Qt.AlignRight
                        function formatValue(v) {
                          return v.toFixed(0)
                        }
                        minimumValue: 0
                        maximumValue: 100
                        stepSize: 1
                        value: 0.0
                        live: true
                    }
                } // end spkrVol row
                Row {
                    id: hdphVolRow
                    spacing: units.gu(2)
                    height: units.gu(6) // needs a height else 1px
                    width: parent.width // match parent
                    anchors {
                        margins: units.gu(2)
                    }
                    Layout.alignment: Qt.AlignHCenter
                    Text {
                        text: "hdph"
                        Layout.alignment: Qt.AlignLeft
                    }
                    Slider {
                        id: headphoneSlider
                        Layout.alignment: Qt.AlignRight
                        function formatValue(v) {
                          return v.toFixed(0)
                        }
                        minimumValue: 0
                        maximumValue: 100
                        stepSize: 1
                        value: 0.0
                        live: true
                    }
                }// end hdph row
    //
    // ALL MIC MUTE
    //
                Button {
                    id: button5
                    Layout.alignment: Qt.AlignHCenter
                    anchors {
                      topMargin: units.gu(2)
                    }
                    text: i18n.tr('Mute all Mics')
                    color: UbuntuColors.graphite
                    onClicked: {
                      clickSound.stop()
                      clickSound.play()
                      Example.micMute()
                      button5.color = UbuntuColors.red
                      button6.color = UbuntuColors.graphite
                      button7.color = UbuntuColors.graphite
                    }
                }
    //
    // MIC UNMUTE
    //
            // make MIC buttons in a row
                Row {
                    id: unmuteRow
                    spacing: units.gu(2)
                    height: units.gu(4) // needs a height else 1px
                    width: parent.width // match parent
                    anchors {
                        margins: units.gu(2)
                    }
                    Layout.alignment: Qt.AlignHCenter

    // DO NOT ALLOW MIC1 handset while SPEAKER.
                    Button {
                        id: button6
                        Layout.alignment: Qt.AlignHCenter
                        anchors {
                          top: unmuteRow.top
                        }
                        text: i18n.tr('Mic1 Handset unmute')
                        color: UbuntuColors.graphite
                        onClicked: {
                          clickSound.stop()
                          clickSound.play()
                          // toggle Headphones
                          buttonHeadphone.clicked()
                          button7.text = "Mic1 Handset unmuted."
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
                          top: unmuteRow.top
                        }
                        text: i18n.tr('Mic2 Headset unmute')
                        color: UbuntuColors.graphite
                        onClicked: {
                          clickSound.stop()
                          clickSound.play()
                          // toggle Speakers
                          buttonSpeaker.clicked()
                          button7.text = "Mic2 Headset unmuted."
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
                      topMargin: units.gu(2)
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
                      topMargin: units.gu(2)
                    }
                    text: i18n.tr('press QAudio Setup to load file first')
                }
                Button {
                    id: button8
                    Layout.alignment: Qt.AlignHCenter
                    anchors {
                      top: label8.bottom
                      topMargin: units.gu(2)
                    }
                    text: i18n.tr('QAudio Setup')
                    color: UbuntuColors.orange
                    onClicked: {
                      clickSound.stop()
                      clickSound.play()
                      Example.audioSetup()
                      label8.text = "Play AlicePt1.ogg, 10:40 mins"
                    }
                }
    //
    // PLAY/STOP OGG FILE
    //
                // play/stop buttons row
                Row {
                    id: qaudioRow
                    spacing: units.gu(2)
                    height: units.gu(6) // needs a height else 1px
                    width: parent.width // match parent
                    anchors {
                        margins: units.gu(2)
                    }
                    Layout.alignment: Qt.AlignHCenter

                    Button {
                        id: button9
                        Layout.alignment: Qt.AlignLeft
                        anchors {
                          top: qaudioRow.top
                        }
                        text: i18n.tr('Play ogg Audio')
                        color: UbuntuColors.slate
                        onClicked: {
                          clickSound.stop()
                          clickSound.play()
                          Example.playAlice()
                          button9.color = UbuntuColors.green
                          button10.color = UbuntuColors.slate
                          label8.text = "Playing AlicePt1.ogg now: " + Example.getDuration()
                        }
                    }
                    Button {
                        id: button10
                        Layout.alignment: Qt.AlignRight
                        anchors {
                          top: qaudioRow.top
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
                          label8.text = "Stopped AlicePt1.ogg"
                        }
                    }
                } // end row
    // qAudio playhead slider
                Slider {
                    id: playheadSlider
                    objectName: 'playheadSlider'
                    anchors {
                      topMargin: units.gu(2)
                    }
                    Layout.alignment: Qt.AlignHCenter
                    function formatValue(v) {
                      return v.toFixed(0)
                    }
                    minimumValue: 0
                    maximumValue: 100 //Example.qMediaPlayer.duration || 1
                    value: Example.getPlayhead()
                    // tracking
                    live: true
                    Connections {
                        target: Example
                        onPlayheadChanged: {
                          playheadSlider.value = Example.getPlayhead()
                          playheadSlider.maximumValue = Example.getDuration() || 1
                          label8.text = "playheadChanged: " + Example.getPlayhead()
                        }

                    }
                }
                Text {
                    text: "start"
                    anchors.top: playheadSlider.bottom
                    anchors.left: playheadSlider.left
                }
                Text {
                    text: "end"
                    anchors.top: playheadSlider.bottom
                    anchors.right: playheadSlider.right
                }
    //
    // CALL AUDIOGEN
    //
                Label {
                    id: label11
                    Layout.alignment: Qt.AlignHCenter
                    /*
                    anchors {
                      topMargin: units.gu(2)
                    }
                    */
                    text: i18n.tr("press to run AudioGen tone at " + Example.getCurrentToneFreq())
                }

                Row {
                    id: audiogenRow
                    spacing: units.gu(2)
                    height: units.gu(4) // needs a height else 1px
                    width: parent.width // match parent
                    anchors {
                        margins: units.gu(2)
                    }
                    Layout.alignment: Qt.AlignHCenter

                    Button {
                        id: button11
                        Layout.alignment: Qt.AlignLeft
                        anchors {
                          top: audiogenRow.top
                        }
                        text: i18n.tr("Run AudioGen")
                        color: UbuntuColors.slate
                        onClicked: {
                          clickSound.stop()
                          clickSound.play()
                          Example.runAudioGen()
                          button11.color = UbuntuColors.red
                          button11.text = "Restart +100hz"
                          label11.text = "AudioGen running at " + Example.getCurrentToneFreq()
                        }
                    }
                    Button {
                        id: button12
                        Layout.alignment: Qt.AlignRight
                        anchors {
                          top: audiogenRow.top
                        }
                        text: i18n.tr("input AudioGen")
                        color: UbuntuColors.slate
                        onClicked: {
                          clickSound.stop()
                          clickSound.play()
                          button12.color = UbuntuColors.blue
                          button12.text = "input AudioGen"
                          Example.toggleAudioGen()
                        }
                    }
                }// end audiogenRow

    // add QAudio volume slider here?
                Slider {
                    id: audiogenSlider
                    anchors {
                      topMargin: units.gu(2)
                    }
                    Layout.alignment: Qt.AlignHCenter
                    function formatValue(v) {
                      return v.toFixed(0)
                    }
                    minimumValue: 0
                    maximumValue: 100
                    stepSize: 1
                    value: 50
                    live: true
                }
                // expander item, required to force layout to specified height and not auto fill screen.
                Item {
                  //Layout.fillWidth: true
                  // or
                  Layout.fillHeight: true
                }
            } // end ColumnLayout
            BottomEdge {
                id: bottomEdge
                hint.text: "swipe up for latest"
                // put your content and setup here
                // contentUrl: Qt.resolvedUrl("About.qml")
                regions: [customRegion]
            }
            BottomEdgeRegion {
                id: customRegion
                from: 0.2
                contentComponent: Page {
                    width: bottomEdge.width
                    height: bottomEdge.height
                    header: PageHeader {
                        title: "Changelog"
                    }
                    Text {
                        id: changeText
                        Layout.alignment: Qt.AlignHCenter
                        anchors {
                            topMargin: units.gu(4)
                        }
                        width: parent.width
                        wrapMode: Text.WordWrap
                        //  use \ to escape quotation marks,
                        //  \n for new lines.
                        //  Use \\ to get a \ in the string
                        // beware of the Atom Editor retaining spaces for QML rendering, hence far-left justify:
                        text: "\n \n
  - version 0.1.3 \n
  - added CHANGELOG \n
  - added output volume sliders read only \n
  - added volume slider for audioGen (not working yet) \n
  - clean up of layout qml \n
  - 2 output sliders (headphone, speaker) \n
  - get init audio state to GUI \n
  - set output script now turns on and off as well \n
  - added playhead slider read only \n
  - labels for vol sliders \n
  - add ActionBar menu \n
  - add BottomEdge gesture slide thing"
                    }// end Text
                }// end contentComponent
            }
        } // end Page
    }// end PageStack
} // end MainView
