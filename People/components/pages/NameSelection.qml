import QtQuick 1.1
import "../common"

SelectionList {
    id: container

    Component.onCompleted: {
        var alph = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
        for (var i = 0; i < alph.length; ++i) {
            alphabetModel.append({"letter": alph.charAt(i)});
        }
    }

    Row {
        id: nameSelectionContainer

        spacing: 5

        Repeater {
            id: nameSelectionRepeater
            model: ListModel {id: alphabetModel}

            delegate: SelectionButton {
                id: btn
                height: 20
                width: 30
                //fontSize: 8
                label: letter
                onClicked: {
                    if (btn.selected) {
                        container.oneSelected(letter)
                    } else {
                        container.oneDeSelected(letter)
                    }
                }
            }
        }
    }
}
