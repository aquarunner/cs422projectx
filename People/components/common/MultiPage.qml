/*
 * File:
 * Description:
 * Author: dyoung24
 * Instructor: Johnson
 * Course: CS 422
 * Date: 5-2-2012
 */

import QtQuick 1.1


SimplePage {
    id: container
    property string currentPage: ""
    property string defaultPage: ""

    Component.onCompleted: {
        hideAll();
        showPage(container.defaultPage);
    }

    function hideAll() {
        var i = 0;
        var o = container.children[i];
        while (o !== undefined) {
            if (o.pageName) {
                o.hide();
            }

            i++;
            o = container.children[i];
        }
        container.currentPage = "";
    }


    function showPage(page) {

        container.hideAll();

        var i = 0;
        var o = container.children[i];
        while (o !== undefined) {
            if (o.pageName && (o.pageName === page)) {
                o.show();
                container.currentPage = page;
                return;
            }

            i++;
            o = container.children[i];
        }
    }
}
