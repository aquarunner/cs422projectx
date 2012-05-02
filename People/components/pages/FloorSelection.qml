/*
 * Project: PeopleFinder
 * Author: dyoung24
 * Instructor: Johnson
 * Course: CS 422
 * Date: 5-2-2012
 */

import QtQuick 1.1
import "../common"

SelectionList {
    id: container
    selection: floorSelectionRepeater

    Row {
        id: floorSelectionContainer
        //clip: true
        //spacing: 10

        Repeater {
            id: floorSelectionRepeater
            model: 13
            delegate: SelectionButton {
                id: btn
                width: (container.width - 20) / 13
                height: 40
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
