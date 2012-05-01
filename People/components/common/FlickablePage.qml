/*
 * File:
 * Description:
 * Author: dyoung24
 * Instructor: Johnson
 * Course: CS 422
 * Date: 5-2-2012
 */

import QtQuick 1.1


Flickable {
    id: container
    flickableDirection: Flickable.VerticalFlick
    anchors.fill: container.fill ? parent : undefined
    visible: container.opacity !== 0

    property string pageName: ""
    property bool fill: true

    Behavior on opacity {
        NumberAnimation {
            duration: 250
        }
    }

    function show() {
        container.opacity = 1
    }

    function hide() {
        container.opacity = 0
    }

}
