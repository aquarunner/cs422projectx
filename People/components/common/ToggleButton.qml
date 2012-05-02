import QtQuick 1.1
import "../common"

MultiButton {
    id: container
    width: 80
    height: 40
    topColor: "#FFFF66"
    bottomColor: "#FFCC00"
    //anchors.margins: 5
    label: ""
    //borderColor: container.topColor
    borderWidth: 0
    imageAll: "../images/check_all.png"
    imageMulti: "../images/check_multi.png"
    imageNone: "../images/check_none.png"

    Component.onCompleted: {
        container.state = "All"
    }
}
