import QtQuick 1.1
import "../common"
import "../models"


SimplePage {




    SimplePage {
        id: contentArea

        fill: false
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.margins: 5
        width: 650
        height: 450

        Rectangle {
            anchors.fill: parent
            color: "blue"


            TestModel {
                id: test
            }

            Text {
                //id: name
                text: test.count
                anchors.centerIn: parent
            }
        }

//        Image {
//            id: browserImage
//            source: ""
//            anchors.fill: parent
//            fillMode: Image.PreserveAspectFit
//        }


//        Text {
//            //id: name
//            text: "No image."
//            anchors.centerIn: parent
//            visible: browserImage.status !== Image.Ready
//        }


    }


    SimplePage {
        id: rightControlArea

        fill: false
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.left: contentArea.right
        anchors.bottom: lowerControlArea.top
        anchors.margins: 5


        SimplePage {
            id: sliderArea
            fill: false
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            width: parent.width * 0.5

            VerticalSlider {
                id: slider
                height: parent.height * 0.8
                anchors.centerIn: parent
                //valueLength: list.count

                Component.onCompleted: {
                    //list.currentIndex = 10
                }


                onValueChanged: {
                    //list.currentIndex = slider.value
                }
            }
        }


        SimplePage {
            id: nameListArea

            fill: false
            anchors.top: parent.top
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.left: sliderArea.right

            TextBox {
                id: input

                anchors.right: parent.right
                anchors.left: parent.left
                anchors.top: parent.top
                anchors.topMargin: 40
            }
        }
    }

    SimplePage {
        id: lowerControlArea

        fill: false
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        anchors.top: contentArea.bottom
        anchors.right: parent.right
        anchors.margins: 5

        NameSelection {
            id: nameSelect
            fill: false
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            height: parent.height * 0.3
        }


        FloorSelection {
            id: floorSelect
            fill: false
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: nameSelect.bottom
            //anchors.bottom: deptSelect.top
            height: parent.height * 0.3
        }

        DepartmentSelection {
            id: deptSelect
            fill: false
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: floorSelect.bottom
            anchors.bottom: parent.bottom
        }




    }



//    MultiButton {
//        anchors.right: closeButton.left
//        anchors.rightMargin: 20
//        anchors.verticalCenter: closeButton.verticalCenter
//    }


//    Button {
//        id: closeButton
//        anchors.right: parent.right
//        anchors.bottom: parent.bottom
//        anchors.margins: 20
//        property int num: 0
//        onClicked: {
//            num++;
//            browserImage.source = "../images/Clipboard01 - Copy (" + num + ").png"
//        }
//    }


}
