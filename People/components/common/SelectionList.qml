import QtQuick 1.1

SimplePage {
    id: container

    signal allSelected()
    signal oneSelected(string one)
    signal oneDeSelected(string one)
    signal noneSelected()

    // 1 - All
    // 2 - Multi
    // 3 - None
    property int selectionState: 1

    function setAll() {
        container.selectionState = 1;
        allSelected();
    }
    function setMulti() {
        container.selectionState = 2;
        multiSelected();
    }
    function setNone() {
        container.selectionState = 3;
        noneSelected();
    }



    states: [
        State {
            name: "All"
            when: container.selectionState === 1
            PropertyChanges {
                target: container
                opacity: 1
            }
        },
        State {
            name: "Multi"
            when: container.selectionState === 2
            PropertyChanges {
                target: container
                opacity: 1
            }
        },
        State {
            name: "None"
            when: container.selectionState === 3
            PropertyChanges {
                target: container
                opacity: settings.canvasHiddenOpacity
            }
        }


    ]

}
