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

import Example 1.0

MainView {
    id: root
    objectName: 'mainView'
    applicationName: 'qtaudio.kaputnikgo'
    automaticOrientation: true

    width: units.gu(45)
    height: units.gu(100)

    Page {
        anchors.fill: parent

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
            }
// HEADPHONES MUTE CONTROL
            Label {
                id: label1
                anchors {
                  top: header.bottom
                  topMargin: 8
                }
                Layout.alignment: Qt.AlignHCenter
                text: i18n.tr('Press BUTTON1 for headphones')
            }
            Button {
                id: button1
                Layout.alignment: Qt.AlignHCenter
                anchors {
                  top: label1.bottom
                  topMargin: 8
                }
                text: i18n.tr('BUTTON1')
                color: UbuntuColors.graphite
                onClicked: {
                  Example.headphones()
                  label1.text = "BUTTON1: unmute headphones, mute speakers."
                }
            }
// SPEAKERS MUTE CONTROL
            Label {
                id: label2
                Layout.alignment: Qt.AlignHCenter
                anchors {
                  top: button1.bottom
                  topMargin: 24
                }
                text: i18n.tr('Press Button2 for speakers')
            }
            Button {
                id: button2
                Layout.alignment: Qt.AlignHCenter
                anchors {
                  top: label2.bottom
                  topMargin: 8
                }
                text: i18n.tr('BUTTON2')
                color: UbuntuColors.warmGrey
                onClicked: {
                  Example.speakers()
                  label2.text = "BUTTON2: mute headphones, unmute speakers."
                }
            }
// READ HEADPHONE VOLUME
            Label {
                id: label3
                Layout.alignment: Qt.AlignHCenter
                anchors {
                  top: button2.bottom
                  topMargin: 24
                }
                text: i18n.tr('Read volume for headphones')
            }
            Button {
                id: button3
                Layout.alignment: Qt.AlignHCenter
                anchors {
                  top: label3.bottom
                  topMargin: 8
                }
                text: i18n.tr('BUTTON3')
                color: UbuntuColors.warmGrey
                onClicked: {
                  Example.readHeadphoneVol()
                  label3.text = "BUTTON3: read headphone volume."
                }
            }
// READ SPEAKER VOLUME
            Label {
                id: label4
                Layout.alignment: Qt.AlignHCenter
                anchors {
                  top: button3.bottom
                  topMargin: 24
                }
                text: i18n.tr('Read volume for speakers')
            }
            Button {
                id: button4
                Layout.alignment: Qt.AlignHCenter
                anchors {
                  top: label4.bottom
                  topMargin: 8
                }
                text: i18n.tr('BUTTON4')
                color: UbuntuColors.warmGrey
                onClicked: {
                  Example.readSpeakerVol()
                  label4.text = "BUTTON4: read speaker volume."
                }
            }
        }
    }
}
