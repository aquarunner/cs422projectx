/*
 * Project: PeopleFinder
 * Author: dyoung24
 * Instructor: Johnson
 * Course: CS 422
 * Date: 5-2-2012
 */

/* With credit to http://jryannel.wordpress.com/2010/02/09/slider-component/#more-70
 */

import QtQuick 1.1

Item {
    id: container;
    width: 100;
    height: 400;


    property int valueLength: 100
    property int value: Math.round(handle.y*valueLength/(container.height-handle.height))
    property bool showValue: true


    signal handleClicked()

    Rectangle {
        id: guide
        color: "grey"
        anchors.centerIn: parent
        height: parent.height
        width: 6
        //opacity: handleMouseArea.pressed ? 1 : 0
    //radius: 4.5

        Behavior on opacity {
            NumberAnimation {
                duration: 450
            }
        }

        gradient: Gradient {
            GradientStop {
                position: 0.0
                color: settings.canvasColor
            }
            GradientStop {
                position: 0.5
                color: "grey"
            }
            GradientStop {
                position: 1.0
                color: settings.canvasColor
            }
        }

    }



    Button {
        id: handle;
        label: ((container.valueLength !== -1) ? container.value + " / " + container.valueLength : "0 / 0")
        width: parent.width;
        borderWidth: 0
        bottomColor: handleMouseArea.pressed ? "lightcyan" : "darkslategrey"
        MouseArea {
            id: handleMouseArea
            anchors.fill: parent
            drag.target: parent;
            drag.axis: "YAxis"
            drag.minimumY: 0;
            drag.maximumY: container.height - handle.height

            onClicked: container.handleClicked();
        }

    }

}

