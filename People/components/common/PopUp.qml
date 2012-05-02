/*
 * Project: PeopleFinder
 * Author: dyoung24
 * Instructor: Johnson
 * Course: CS 422
 * Date: 5-2-2012
 */

import QtQuick 1.1



SimplePage  {
    id: container
    opacity: showing ? 1 : 0

    property string text: ""
    property bool showing: false

    function show(message) {
        showing = false;
        popTimer.stop();
        container.text = message;
        showing = true;
    }


    Behavior on opacity {
        NumberAnimation {
            duration: 200
        }
    }

    onShowingChanged: {
        if (showing) {
            popTimer.start();
        }
    }

    Timer {
        id: popTimer
        running: false
        repeat: false
        interval: 3000
        onTriggered: {
            showing = false;
        }
    }

    MouseArea {
        anchors.fill: parent
        onClicked: container.showing = false;
    }
}
