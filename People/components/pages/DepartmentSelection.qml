import QtQuick 1.1
import "../common"

SelectionList {
    id: container
    selection: deptSelectionRepeater

    Row {
        id: deptSelectionContainer
        //spacing: 20

        Repeater {
            id: deptSelectionRepeater
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
                width: (container.width - 20) / 8
                height: 40
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
