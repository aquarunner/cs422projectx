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

    selection: nameSelectionRepeater

    Component.onCompleted: {
        var alph = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
        for (var i = 0; i < alph.length; ++i) {
            alphabetModel.append({"letter": alph.charAt(i)});
        }
    }

    Row {
        id: nameSelectionContainer

        //spacing: 5

        Repeater {
            id: nameSelectionRepeater
            clip: true
            model: ListModel {id: alphabetModel}

            delegate: SelectionButton {
                id: btn
                height: 40
                width: (container.width - 10) / 26
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
