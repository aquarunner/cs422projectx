/*
 * Project: PeopleFinder
 * Author: dyoung24
 * Instructor: Johnson
 * Course: CS 422
 * Date: 5-2-2012
 */


import QtQuick 1.1


Flipable {
    id: container
    anchors.fill: container.fill ? parent : undefined
    visible: container.opacity !== 0

    property string pageName: ""
    property bool flipped: false
    property bool fill: true
    property int angle: 0

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

    function flip() {
        container.flipped = !flipped
    }

    function showFront() {
        container.flipped = false
    }

    function showBack() {
        container.flipped = true
    }

    transform: Rotation {
        origin.x: container.width/2
        origin.y: container.height/2
        axis.x: 0
        axis.y: 1
        axis.z: 0
        angle: container.angle
    }

    states: State {
        name: "back"
        when: container.flipped
        PropertyChanges {
            target: container
            angle: 180
        }
    }

    transitions: Transition {
        NumberAnimation{
            property: "angle";
            duration: 250
        }
    }
}
