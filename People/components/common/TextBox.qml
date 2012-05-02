/*
 * Project: PeopleFinder
 * Author: dyoung24
 * Instructor: Johnson
 * Course: CS 422
 * Date: 5-2-2012
 */

/* With credit to http://jryannel.wordpress.com/2010/02/17/using-textinput/
 */


import QtQuick 1.1


Rectangle {
    id: container
    width: 120
    height: 25 * container.lineHeight
    radius: 6
    border.color: borderColor
    border.width: 4
    clip: true

    property color borderColor: "darkcyan"
    property string exampleText: "Example text..."
    property int lineHeight: 1
    property alias input: textInput.text
    property bool fontBold: true
    property int fontPointSize: 10

    Text {
        id: exampleText
        enabled: false
        opacity: 0.3
        visible: !container.input && !textInput.focus
        text: container.exampleText
        anchors.fill: parent
        anchors.margins: 5
        font.italic: true
        font.pointSize: container.fontPointSize
        wrapMode: Text.Wrap
    }
    TextInput {
        id: textInput
        anchors.fill: parent
        anchors.margins: 5
        font.bold: container.fontBold
        font.pointSize: container.fontPointSize
        //wrapMode: Text.Wrap
        //maximumLength: 10

    }
}
