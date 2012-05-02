/*
 * Project: PeopleFinder
 * Author: dyoung24
 * Instructor: Johnson
 * Course: CS 422
 * Date: 5-2-2012
 */

import QtQuick 1.1
import "../common"

// Note Multi Buttons can also be selection buttons.  So they really have 5 states

SelectionButton {
    id: container


    selectionButton: false

    property string imageAll: ""
    property string imageMulti: ""
    property string imageNone: ""


    Image {
        id: buttonImage
        //source: "../images/check_all.png"
        anchors.fill: parent
        fillMode: Image.PreserveAspectFit
        anchors.margins: 5
    }

    function setAll() {
        container.state = "All"
    }
    function setMulti() {
        container.state = "Multi"
    }
    function setNone() {
        container.state = "None"
    }

    onClicked: {
        if (container.state === "All") {
            setMulti();
        } else if (container.state === "Multi") {
            setNone();
        } else {
            setAll();
        }
    }

    Behavior on borderWidth {
        NumberAnimation {
            duration: 250
        }
    }

    states: [
        State {
            name: "All"
            //when: container.buttonState === 1
            PropertyChanges {
                target: buttonImage
                source: container.imageAll
            }
        },
        State {
            name: "Multi"
            //when: container.buttonState === 2
            PropertyChanges {
                target: buttonImage
                source: container.imageMulti
            }
        },
        State {
            name: "None"
            //when: container.buttonState === 3
            PropertyChanges {
                target: buttonImage
                source: container.imageNone
            }
        }
    ]
}
