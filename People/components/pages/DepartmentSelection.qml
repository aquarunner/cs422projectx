import QtQuick 1.1
import "../common"

SelectionList {
    id: container

    Row {
        id: deptSelectionContainer

        spacing: 20

        Repeater {
            id: floorSelectionRepeater
            model: ListModel{
                id: departmentsModel

                ListElement {dept: "BIOE"}
                ListElement {dept: "CHE"}
                ListElement {dept: "CME"}
                ListElement {dept: "CS"}
                ListElement {dept: "ECE"}
                ListElement {dept: "MSCS"}
                ListElement {dept: "MIE"}
                ListElement {dept: "COE"}

            }

            delegate: SelectionButton {
                id: btn
                width: 80
                height: 60
                label: dept
                onClicked: {
                    if (btn.selected) {
                        container.oneSelected(dept)
                    } else {
                        container.oneDeSelected(dept)
                    }
                }
            }
        }
    }
}
