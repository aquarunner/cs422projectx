/*
 * Project: PeopleFinder
 * Author: dyoung24
 * Instructor: Johnson
 * Course: CS 422
 * Date: 5-2-2012
 */

import QtQuick 1.1
import "../common"

PopUp {
    id: container
    fill: false
    width: parent.width / 2
    height: 60
    //anchors.horizontalCenter: parent.horizontalCenter
    y: parent.height * 0.2
    x: 150

    Text {
        id: popText
        text: container.text
        anchors.fill: parent
        anchors.centerIn: parent
        anchors.margins: 10
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        wrapMode: Text.Wrap
        font.bold: true
        font.pointSize: settings.canvasPointSize
        font.letterSpacing: 1
        color: "white"
    }






}
