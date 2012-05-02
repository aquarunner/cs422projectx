/*
 * Project: PeopleFinder
 * Author: dyoung24
 * Instructor: Johnson
 * Course: CS 422
 * Date: 5-2-2012
 */

import QtQuick 1.1

Item {
    id: container

    property string appName: "PeopleFinder"
    property color canvasColor: "#222222"
    property bool firstRun: true
    property int canvasPointSize: 11
    property double canvasHiddenOpacity: 0.1
    property string defaultFloorSearch: " 1 2 3 4 5 6 7 8 9 10 11 12 13"
    property string floorSearch: container.defaultFloorSearch
    property string defaultDeptSearch: " BIOE CHE CME CS ECE MSCS MIE COE"
    property string deptSearch: container.defaultDeptSearch
    property string defaultLastNameSearch: " A B C D E F G H I J K L M N O P Q R S T U V W X Y Z"
    property string lastNameSearch: container.defaultLastNameSearch
    property string fullNameSearch: ""
    property int selectedPerson: -1
}
