import QtQuick 1.1
import "../common"
import "../models"


SimplePage {
    id: container
    opacity: 0

    onVisibleChanged: {
        if (container.visible) {
            pop.show("Hint: use the slider on the right to browse names.\nUse the selections below to filter by last name, floor or department.");
        }
    }

    ListModel {
        id: peopleModel
        Component.onCompleted: {
            dbi.initialize();
            dbi.importPeople(peopleModel);
        }
    }


    SimplePage {
        id: headerArea
        fill: false
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        height: 40


        Row {
            anchors.fill: parent
            anchors.leftMargin: 20
            spacing: 5

            Image {
                //id: name
                source: "../images/quit.png"
                width: 35
                height: 40
                fillMode: Image.PreserveAspectFit
                scale: quitButtonMouseArea.pressed ? 0.9 : 1

                MouseArea {
                    id: quitButtonMouseArea
                    anchors.fill: parent
                    onClicked: {
                        Qt.quit();
                    }
                }
            }


            Image {
                //id: name
                source: "../images/options.png"
                width: 40
                height: 40
                fillMode: Image.PreserveAspectFit
                scale: optionsButtonMouseArea.pressed ? 0.9 : 1

                MouseArea {
                    id: optionsButtonMouseArea
                    anchors.fill: parent
                }
            }

            Image {
                //id: name
                source: "../images/help.png"
                width: 40
                height: 40
                fillMode: Image.PreserveAspectFit
                scale: helpButtonMouseArea.pressed ? 0.9 : 1

                MouseArea {
                    id: helpButtonMouseArea
                    anchors.fill: parent
                }
            }


        }
    }

    SimplePage {
        id: contentArea

        fill: false
        anchors.left: parent.left
        anchors.top: headerArea.bottom
        anchors.right: rightControlArea.left
        anchors.bottom: lowerControlArea.top
        anchors.margins: 5
        width: 650
        height: 370
        FlipablePage {
            id: contentContainer
            front: PersonDetails { id: personDetails }
            back: PeopleGridView { id: peopleGridView }
        }
    }


    SimplePage {
        id: rightControlArea

        fill: false
        anchors.right: parent.right
        anchors.top: parent.top
        //anchors.left: contentArea.right
        width: 250
        anchors.bottom: lowerControlArea.top
        anchors.margins: 5


        SimplePage {
            id: sliderArea
            fill: false
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.topMargin: headerArea.height
            //height: peopleListContainer.height
            anchors.bottom: parent.bottom
            anchors.right: nameListArea.left
            anchors.margins: 10
            //width: parent.width

            VerticalSlider {
                id: peopleSlider
                height: peopleListContainer.height// * 0.8
                width: parent.width// * 0.5
                //anchors.centerIn: parent
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 40
                valueLength: peopleModel.count - 1

                onHandleClicked: {
                    contentContainer.flip();
                }

                onValueChanged: {
                    settings.selectedPerson = peopleSlider.value
                }
            }
        }


        SimplePage {
            id: nameListArea

            fill: false
            anchors.top: parent.top
            anchors.topMargin: 40//headerArea.height
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            //anchors.left: sliderArea.right
            width: 150

            TextBox {
                id: searchText
                exampleText: "Search..."
                anchors.right: parent.right
                anchors.left: parent.left
                anchors.top: parent.top
                //anchors.topMargin: 40
                z: 1

                onInputChanged: {
                    settings.fullNameSearch = searchText.input;
                    dbi.importPeople(peopleModel);
                }
            }

            Item {
                id: peopleListContainer
                anchors.top: searchText.bottom
                anchors.left: parent.left
                anchors.bottom: parent.bottom
                anchors.right: parent.right
                anchors.topMargin: 40
                anchors.bottomMargin: 40
                clip: true

                ListView {
                    id: peopleList
                    anchors.fill: parent
                    currentIndex: peopleSlider.value

                    signal currentIndexChanged(int index)

                    onCurrentIndexChanged: {
                        //personImage.source = "../images/people/" + peopleList.currentItem.imgSource;
                    }

                    model: peopleModel
                    delegate: Text {
                        id: nameText
                        text: lastName + ", " + firstName
                        //anchors.leftMargin: 20
                        font.pointSize: 10
                        font.bold: ListView.isCurrentItem
                        //font.italic: ListView.isCurrentItem
                        color: ListView.isCurrentItem ? "cyan" : "white"
                        property string imgSource: image


                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                //peopleList.currentIndex = index;
                                //peopleSlider.value = index
                            }
                        }
                    }

                }
            }
        }
    }

    SimplePage {
        id: lowerControlArea

        fill: false
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        //anchors.top: contentArea.bottom
        height: 150
        anchors.right: parent.right
        anchors.margins: 5

        NameSelection {
            id: nameSelect
            fill: false
            anchors.left: parent.left
            anchors.right: nameToggleButton.left
            anchors.top: parent.top
            height: parent.height * 0.3

            onOneDeSelected: {
                settings.lastNameSearch = helper.trim(settings.lastNameSearch.replace(one, ""));
                nameToggleButton.setMulti();
                nameSelect.setMulti();
                dbi.importPeople(peopleModel);
            }
            onOneSelected: {
                settings.lastNameSearch += " " + one;
                nameToggleButton.setMulti();
                nameSelect.setMulti();
                dbi.importPeople(peopleModel);
            }
            onAllSelected: {
                settings.lastNameSearch = settings.defaultLastNameSearch;
                dbi.importPeople(peopleModel);
            }
            onNoneSelected: {
                settings.lastNameSearch = "";
                dbi.importPeople(peopleModel);
            }

        }


        FloorSelection {
            id: floorSelect
            fill: false
            anchors.left: parent.left
            anchors.right: floorToggleButton.left
            anchors.top: nameSelect.bottom
            height: parent.height * 0.3

            onOneDeSelected: {
                settings.floorSearch = helper.trim(settings.floorSearch.replace(" " + one, ""));
                floorToggleButton.setMulti();
                floorSelect.setMulti();
                dbi.importPeople(peopleModel);
            }
            onOneSelected: {
                settings.floorSearch += " " + one;
                floorToggleButton.setMulti();
                floorSelect.setMulti();
                dbi.importPeople(peopleModel);
            }
            onAllSelected: {
                settings.floorSearch = settings.defaultFloorSearch;
                dbi.importPeople(peopleModel);
            }
            onNoneSelected: {
                settings.floorSearch = "";
                dbi.importPeople(peopleModel);
            }
        }

        DepartmentSelection {
            id: deptSelect
            fill: false
            anchors.left: parent.left
            anchors.right: deptToggleButton.left
            anchors.top: floorSelect.bottom
            anchors.bottom: parent.bottom

            onOneDeSelected: {
                settings.deptSearch = helper.trim(settings.deptSearch.replace(" " + one, ""));
                deptToggleButton.setMulti();
                deptSelect.setMulti();
                dbi.importPeople(peopleModel);
            }
            onOneSelected: {
                settings.deptSearch += " " + one;
                deptToggleButton.setMulti();
                deptSelect.setMulti();
                dbi.importPeople(peopleModel);
            }
            onAllSelected: {
                settings.deptSearch = settings.defaultDeptSearch;
                dbi.importPeople(peopleModel);
            }
            onNoneSelected: {
                settings.deptSearch = "";
                dbi.importPeople(peopleModel);
            }
        }


        ToggleButton {
            id: nameToggleButton
            anchors.right: parent.right
            anchors.top: parent.top
            //state: "All"
            //state: nameSelect.state
            //buttonState: 1
            //anchors.rightMargin: 20
            //anchors.verticalCenter: closeButton.verticalCenter

            onClicked: {
                nameSelect.nextState();
            }

        }

        ToggleButton {
            id: floorToggleButton
            anchors.right: parent.right
            anchors.top: floorSelect.top
            //buttonState: 1
            //anchors.rightMargin: 20
            //anchors.verticalCenter: closeButton.verticalCenter

            onClicked: {
                floorSelect.nextState();
            }

        }

        ToggleButton {
            id: deptToggleButton
            anchors.right: parent.right
            anchors.top: deptSelect.top
            //buttonState: 1
            //anchors.rightMargin: 20
            //anchors.verticalCenter: closeButton.verticalCenter

            onClicked: {
                deptSelect.nextState();
            }

        }


    }





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
