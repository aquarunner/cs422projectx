import QtQuick 1.1
import "../common"

SimplePage {
    id: container

    GridView {
        id: peopleGrid
        clip: true
        currentIndex: peopleSlider.value
        anchors.leftMargin: 20
        //anchors.topMargin: 40
        anchors.bottomMargin: 20
        anchors.fill: parent
        model: peopleModel
        delegate: Item {
            id: gridDelegate
            property string imgSource: "../images/people/" + image
            width: 70
            height: 70
            Rectangle {
                anchors.fill: parent
                visible: gridDelegate.GridView.isCurrentItem
            }

            Image {
                //id: personImage
                source: gridDelegate.imgSource
                //anchors.margins: 40
                anchors.fill: parent
                anchors.margins: 1
                fillMode: Image.PreserveAspectFit

                MouseArea {
                    id: gridImageMouseArea
                    anchors.fill: parent
                    onClicked: {
                        settings.selectedPerson = index;
                        contentContainer.flip();
                    }
                }
            }
        }
    }



}
