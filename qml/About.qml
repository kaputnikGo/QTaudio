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

//import Example 1.0

MainView {
    id: rootAbout
    objectName: 'aboutView'
    applicationName: 'qtaudio.kaputnikgo'
    automaticOrientation: true

    //theme.name: "Ubuntu.Components.Themes.SuruDark
    width: units.gu(51)
    height: units.gu(102)

    PageStack {
        id: aboutPageStack
        anchors.fill: parent
        Component.onCompleted: push(pageAbout)

        Page {
            id: pageAbout
            anchors.fill: parent
            visible: false

            header: PageHeader {
                id: headerAbout
                width: parent.width // match parent
                title: i18n.tr('QTaudio about')

                ActionBar {
                    anchors {
                        top: headerAbout.top
                        right: headerAbout.right
                    }
                    numberOfSlots: 1
                    actions: [
                        Action {
                            //iconName: "share"
                            text: "Main"
                            onTriggered: aboutPageStack.push(Qt.resolvedUrl("Main.qml"))
                        },
                        Action {
                            //iconName: "starred"
                            text: "Record"
                            onTriggered: aboutPageStack.push(Qt.resolvedUrl("Record.qml"))
                        }
                    ]
                }
            }

            ColumnLayout {
                spacing: units.gu(2)
                Layout.alignment: Qt.AlignHCenter
                anchors {
                    margins: units.gu(2)
                    top: headerAbout.bottom
                    left: parent.left
                    right: parent.right
                    bottom: parent.bottom
                    topMargin: 18
                }

                Label {
                    id: labelAbout
                    anchors {
                      top: parent.top
                      topMargin: units.gu(2)
                    }
                    Layout.alignment: Qt.AlignHCenter
                    text: i18n.tr('About page of some stuff')
                }

                Text {
                    id: aboutText
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
                    text: "This could be a link: <a href='https://cityfreqs.com.au'>City Freqs</a>"
                    onLinkActivated: Qt.openUrlExternally(link)
                }

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
