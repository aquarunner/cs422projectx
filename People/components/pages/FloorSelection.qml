import QtQuick 1.1
import "../common"

SelectionList {
    id: container

    Row {
        id: floorSelectionContainer

        spacing: 10

        Repeater {
            id: floorSelectionRepeater
            model: 13
            delegate: SelectionButton {
                id: btn
                label: index + 1
                onClicked: {
                    if (btn.selected) {
                        container.oneSelected(index + 1)
                    } else {
                        container.oneDeSelected(index + 1)
                    }
                }
            }
        }
    }
}