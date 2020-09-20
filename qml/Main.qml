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

            Label {
                id: label1
                Layout.alignment: Qt.AlignHCenter
                text: i18n.tr('Press BUTTON1 for headphones')
            }
            Button {
                Layout.alignment: Qt.AlignHCenter
                text: i18n.tr('BUTTON1')
                color: UbuntuColors.graphite
                onClicked: {
                  Example.headphones()
                  label1.text = "BUTTON1: unmute headphones, mute speakers."
                }
            }

            Label {
                id: label2
                Layout.alignment: Qt.AlignHCenter
                text: i18n.tr('Press Button2 for speakers')
            }
            Button {
                Layout.alignment: Qt.AlignHCenter
                text: i18n.tr('BUTTON2')
                color: UbuntuColors.warmGrey
                onClicked: {
                  Example.speakers()
                  label2.text = "BUTTON2: mute headphones, unmute speakers."
                }
            }
        }
    }
}
