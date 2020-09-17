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
                id: label
                Layout.alignment: Qt.AlignHCenter
                text: i18n.tr('Press the BUTTON below and check the logs!')
            }
            Button {
                Layout.alignment: Qt.AlignHCenter
                text: i18n.tr('Press here!')
                color: UbuntuColors.graphite
                onClicked: Example.speak()
            }

            Label {
                id: label2
                Layout.alignment: Qt.AlignHCenter
                text: i18n.tr('Its a new line of text above BUTTON2')
            }
            Button {
                Layout.alignment: Qt.AlignHCenter
                text: i18n.tr('BUTTON2')
                color: UbuntuColors.warmGrey
                onClicked: {
                  label2.text = "BUTTON2 was clicked."
                  Example.devices()
                }
            }
        }
    }
}
