/*
 * Project: PeopleFinder
 * Author: dyoung24
 * Instructor: Johnson
 * Course: CS 422
 * Date: 5-2-2012
 */

import QtQuick 1.1


Rectangle {
    id: container

    property string label: "Button"

    property color topColor: "lightcyan"
    property color bottomColor: "darkslategrey"
    property color borderColor: "darkslategrey"
    property int borderWidth: 3

    property string fontName: "Arial"
    property color fontColor: "black"
    property int fontSize: 14
    property bool fontBold: true
    property bool fontItalic: false

    property alias text: container.label

    clip: true
    height: 40
    width: 180
    border.width: container.borderWidth
    border.color: container.borderColor
    radius: 4
    smooth: true

    signal clicked()

    Behavior on opacity {
        NumberAnimation {
            duration: 250
        }
    }

    gradient: Gradient {
        GradientStop {
            position: 0.0
            color: topColor
        }
        GradientStop {
            position: 1.0
            color: !mouseArea.pressed ? bottomColor : topColor
        }
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        onClicked: {
            container.clicked()
        }
    }

    Text {
        id: buttonLabel
        text: container.label
        wrapMode: Text.WordWrap
        anchors.fill: parent
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        font.family: container.fontName
        font.pointSize: container.fontSize
        font.bold: container.fontBold
        font.italic: container.fontItalic
        color: container.fontColor
    }
}
