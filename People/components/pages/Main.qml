/*
 * File:
 * Description:
 * Author: dyoung24
 * Instructor: Johnson
 * Course: CS 422
 * Date: 5-2-2012
 */

import QtQuick 1.1
import "../common"

Rectangle {
    id: container
    color: settings.canvasColor
    anchors.fill: parent

    MultiPage {
        id: mainContainer

        defaultPage: settings.firstRun ? "WelcomePage" : "BrowserPage"

        WelcomePage {
            pageName: "WelcomePage"
        }

        BrowserPage {
            pageName: "BrowserPage"
        }

        OptionsPage {
            pageName: "OptionsPage"
        }

        HelpPage {
            pageName: "HelpPage"
        }
    }

    MessagePop {
        id: pop
    }

}
