/*
 * Project: PeopleFinder
 * Author: dyoung24
 * Instructor: Johnson
 * Course: CS 422
 * Date: 5-2-2012
 */

import QtQuick 1.1
import "../common"

SimplePage {
    id: container
    //opacity: (settings.selectedPerson !== -1) ? 1 : 0
    anchors.leftMargin: 20

    property string personImageSource: (peopleModel.get(settings.selectedPerson) !== undefined) ? "../images/people/" + peopleModel.get(settings.selectedPerson).image : ""

    Rectangle {
        anchors.fill: parent
        color: "#111111"
        radius: 6

        Image {
            //id: name
            source: "../images/grid.png"
            anchors.right: parent.right
            //anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.margins: 10
            visible: !contentContainer.flipped
            width: 40
            height: 40

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    contentContainer.flip();
                }
            }
        }

    }

    Item {
        id: imageArea
        width: 375
        height: 375
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
        anchors.leftMargin: 20
        opacity: (container.visible && (settings.selectedPerson !== -1)) ? 1 : 0
        Behavior on opacity {
            NumberAnimation {
                duration: 250
            }
        }

        Image {
            id: personImage
            source: container.personImageSource
            anchors.fill: parent
            fillMode: Image.PreserveAspectFit
        }
    }

    Rectangle {
        id: detailsArea
        radius: 4
        width: 300
        height: 300
        anchors.right: parent.right
        anchors.rightMargin: 20
        anchors.verticalCenter: parent.verticalCenter
        color: "khaki"
        opacity: (container.visible && (settings.selectedPerson !== -1)) ? 1 : 0
        Behavior on opacity {
            NumberAnimation {
                duration: 250
            }
        }

        Column {
            anchors.fill: parent
            anchors.margins: 20

            DetailText {
                text: (peopleModel.get(settings.selectedPerson) !== undefined) ? peopleModel.get(settings.selectedPerson).fullName : ""
            }
            DetailText {
                text: (peopleModel.get(settings.selectedPerson) !== undefined) ? peopleModel.get(settings.selectedPerson).office : ""
            }
            DetailText {
                text: (peopleModel.get(settings.selectedPerson) !== undefined) ? peopleModel.get(settings.selectedPerson).phone : ""
            }

        }



        Button {
            label: "Directions"
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.margins: 10
            //topColor: "darkslategrey"
            //bottomColor: "cyan"
            width: 100
            borderWidth: 0
        }
    }


}
