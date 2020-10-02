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
    id: rootRecord
    objectName: 'recordView'
    applicationName: 'qtaudio.kaputnikgo'
    automaticOrientation: true

    //theme.name: "Ubuntu.Components.Themes.SuruDark
    width: units.gu(51)
    height: units.gu(102)

    PageStack {
        id: recordPageStack
        anchors.fill: parent
        Component.onCompleted: push(pageRecord)

        Page {
            id: pageRecord
            anchors.fill: parent
            visible: false

            header: PageHeader {
                id: headerRecord
                width: parent.width // match parent
                title: i18n.tr('QTaudio audio view')

                ActionBar {
                    anchors {
                        top: headerRecord.top
                        right: headerRecord.right
                    }
                    numberOfSlots: 1
                    actions: [
                        Action {
                            //iconName: "share"
                            text: "Main"
                            onTriggered: recordPageStack.push(Qt.resolvedUrl("Main.qml"))
                        },
                        Action {
                            //iconName: "starred"
                            text: "About"
                            onTriggered: recordPageStack.push(Qt.resolvedUrl("About.qml"))
                        }
                    ]
                }
            }

            ColumnLayout {
                spacing: units.gu(2)
                Layout.alignment: Qt.AlignHCenter
                anchors {
                    margins: units.gu(2)
                    top: headerRecord.bottom
                    left: parent.left
                    right: parent.right
                    bottom: parent.bottom
                    topMargin: 18
                }

                Label {
                    id: labelRecord
                    anchors {
                      top: parent.top
                      topMargin: units.gu(2)
                    }
                    Layout.alignment: Qt.AlignHCenter
                    text: i18n.tr('Try some record audio and fft')
                }

                Text {
                    id: recordText
                    Layout.alignment: Qt.AlignHCenter
                    anchors {
                        topMargin: units.gu(2)
                    }
                    width: parent.width
                    wrapMode: Text.WordWrap
                    //  use \ to escape quotation marks,
                    //  \n for new lines.
                    //  Use \\ to get a \ in the string
                    // beware of the Atom Editor retaining spaces for QML rendering, hence far-left justify:
                    text: "Maybe an fft window for frequency response. \n need an fft library."
                }

                Row {
                    id: recordRow
                    spacing: units.gu(2)
                    height: units.gu(4) // needs a height else 1px
                    width: parent.width // match parent
                    anchors {
                        margins: units.gu(2)
                    }
                    Button {
                        id: buttonArm
                        Layout.alignment: Qt.AlignLeft
                        anchors {
                          top: recordRow.top
                        }
                        text: i18n.tr("Arm Display")
                        color: UbuntuColors.slate
                        onClicked: {
                          clickSound.stop()
                          clickSound.play()
                          buttonArm.color = UbuntuColors.green
                          buttonArm.text = "ARMED"

                        }
                    }
                    Button {
                        id: buttonRecord
                        Layout.alignment: Qt.AlignRight
                        anchors {
                          top: recordRow.top
                        }
                        text: i18n.tr("Display")
                        color: UbuntuColors.slate
                        onClicked: {
                          clickSound.stop()
                          clickSound.play()
                          buttonArm.color = UbuntuColors.red
                          buttonArm.text = "DISPLAYING"

                        }
                    }
                }// end recordRow

                // expander item, required to force layout to specified height and not auto fill screen.
                Item {
                  //Layout.fillWidth: true
                  // or
                  Layout.fillHeight: true
                }
            } // end column
        } // end Page
    } // end PageStack
} // end view
