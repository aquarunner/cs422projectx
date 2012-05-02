/*
 * Project: PeopleFinder
 * Author: dyoung24
 * Instructor: Johnson
 * Course: CS 422
 * Date: 5-2-2012
 */

import QtQuick 1.1

SimplePage {
    id: container
    clip: true
    property variant selection

    signal allSelected()
    signal noneSelected()
    signal multiSelected()
    signal oneSelected(string one)
    signal oneDeSelected(string one)

    // 1 - All
    // 2 - Multi
    // 3 - None
    property int selectionState: 1

    Component.onCompleted: {
        container.state = "All";
    }

    function nextState() {
        if (container.state  === "All") {
            setMulti();
        } else if (container.state === "Multi") {
            setNone();
        } else {
            setAll();
        }
    }

    function setAll() {
        container.state = "All";

        // UnHide all objects contained
        var obj;
        for (var i = 0; container.selection.itemAt(i) !== null; ++i) {
            obj = container.selection.itemAt(i);
            if (obj.selected !== undefined) {
                obj.selected = true;
            }
        }

        allSelected();
    }

    function setMulti() {
        container.state = "Multi";
        multiSelected();
    }

    function setNone() {
        container.state = "None";

        // Hide all objects contained
        var obj;
        for (var i = 0; container.selection.itemAt(i) !== null; ++i) {
            obj = container.selection.itemAt(i);
            if (obj.selected !== undefined) {
                obj.selected = false;
            }
        }

        noneSelected();
    }



    states: [
        State {
            name: "All"
            //when: container.selectionState === 1
            PropertyChanges {
                target: container
                //opacity: 1
            }
        },
        State {
            name: "Multi"
            //when: container.selectionState === 2
            PropertyChanges {
                target: container
                //opacity: 1
            }
        },
        State {
            name: "None"
            //when: container.selectionState === 3
            PropertyChanges {
                target: container
                //opacity: settings.canvasHiddenOpacity
            }
        }


    ]

}
