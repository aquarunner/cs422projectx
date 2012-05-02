/*
 * File:
 * Description:
 * Author: dyoung24
 * Instructor: Johnson
 * Course: CS 422
 * Date: 5-2-2012
 */

import QtQuick 1.1
import "../common"

SimplePage {
    id: container

    Column {
        anchors.centerIn: parent
        spacing: 50
        CanvasText {
            text: "Press Ok To Continue"
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Button {
            label: "Ok"
            anchors.horizontalCenter: parent.horizontalCenter
            onClicked: {
                mainContainer.showPage("BrowserPage");
            }
        }
    }
}
