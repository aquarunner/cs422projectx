import QtQuick 1.1
import "../common"

// Note Multi Buttons can also be selection buttons.  So they really have 5 states

Button {
    id: container
    bottomColor: settings.canvasColor
    topColor: settings.canvasColor
    label: ""
    width: 50
    //height: 50


    Image {
        id: buttonImage
        source: ""
        anchors.fill: parent
        fillMode: Image.PreserveAspectFit
        anchors.margins: 5
    }

    // 1 = All
    // 2 = Multi
    // 3 = None
    property int buttonState: 1
    property int nextButtonState: 1


    function setAll() {
        container.buttonState = 1
    }
    function setMulti() {
        container.buttonState = 2
    }
    function setNone() {
        container.buttonState = 3
    }

    onClicked: {
        if (container.buttonState === 1) {
            setMulti();
        } else if (container.buttonState === 2) {
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
            name: "Selected"
            when: container.selected
            PropertyChanges {
                target: container
                opacity: 1
            }
        },
        State {
            name: "Unselected"
            when: !container.selected
            PropertyChanges {
                target: container
                opacity: settings.canvasHiddenOpacity
            }
        },
        State {
            name: "All"
            when: container.buttonState === 1
            PropertyChanges {
                target: buttonImage
                source: "../images/all.png"
            }
            PropertyChanges {
                target: container
                //topColor: "lightcyan"
                //bottomColor: "lightcyan"
            }
        },
        State {
            name: "Multi"
            when: container.buttonState === 2
            PropertyChanges {
                target: buttonImage
                source: "../images/multi.png"
            }
            PropertyChanges {
                target: container
                //topColor: "khaki"
                //bottomColor: "khaki"
            }
        },
        State {
            name: "None"
            when: container.buttonState === 3
            PropertyChanges {
                target: buttonImage
                source: "../images/checkbox_empty.png"
            }
        }


    ]
}
