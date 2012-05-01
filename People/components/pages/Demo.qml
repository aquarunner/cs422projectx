/*
 * File:
 * Description:
 * Author: dyoung24
 * Instructor: Johnson
 * Course: CS 422
 * Date: 5-2-2012
 */

import QtQuick 1.1
import "../common"

SimplePage {

    VerticalSlider {
        id: slider
        height: parent.height
        anchors.centerIn: parent
        valueLength: list.count

        Component.onCompleted: {
            list.currentIndex = 10
        }


        onValueChanged: {
            list.currentIndex = slider.value
        }
    }

    ListView {
        id: list
        spacing: 5
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.top: parent.top
        //highlightFollowsCurrentItem: true
        width: 100
        model: 10
        delegate: Rectangle {
            id: delegate
            width: parent.width
            height: 50
            anchors.bottomMargin: 10
            color: "black"

            Text {
                id: name
                text: index
                color: delegate.ListView.isCurrentItem ? "red" : "white"
            }
        }

        onCurrentIndexChanged: {

        }
    }

}
