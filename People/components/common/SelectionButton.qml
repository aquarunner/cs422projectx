import QtQuick 1.1


MultiButton {
    id: container
    label: index
    onClicked: {
        container.selected = !container.selected;
    }
}
