/*
 * File:
 * Description:
 * Author: dyoung24
 * Instructor: Johnson
 * Course: CS 422
 * Date: 5-2-2012
 */

//http://jryannel.wordpress.com/2010/02/09/slider-component/#more-70
import QtQuick 1.1

Item {
    id: container;
    width: 100;
    height: 400;

    property int valueLength: 100
    property int value: Math.round(handle.y*valueLength/(container.height-handle.height))
    property bool showValue: true


    Rectangle {
        color: "black"
        anchors.centerIn: parent
        height: parent.height
        width: 5
        radius: 4

    }



    Rectangle {
        id: handle;
        width: parent.width;
        height: 40
        color: "red"
        MouseArea {
            anchors.fill: parent
            drag.target: parent; drag.axis: "YAxis"
            drag.minimumY: 0;
            drag.maximumY: container.height - handle.height
        }

        Text {
            id: valueIndicator
            text: container.value
            anchors.centerIn: parent
        }


    }





}

