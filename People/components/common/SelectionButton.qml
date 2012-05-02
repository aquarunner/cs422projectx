/*
 * Project: PeopleFinder
 * Author: dyoung24
 * Instructor: Johnson
 * Course: CS 422
 * Date: 5-2-2012
 */

import QtQuick 1.1


Button {
    id: container

    property bool selected: true
    property bool selectionButton: true

    onClicked: {
        if (container.selectionButton) {
            container.selected = !container.selected;
        }
    }

    states: [
        State {
            name: "Selected"
            when: container.selected
            PropertyChanges {
                target: container
                opacity: 1
            }
        },
        State {
            name: "Unselected"
            when: !container.selected
            PropertyChanges {
                target: container
                opacity: settings.canvasHiddenOpacity
            }
        }
    ]

}
