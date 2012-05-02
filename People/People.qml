/*
 * Project: PeopleFinder
 * Author: dyoung24
 * Instructor: Johnson
 * Course: CS 422
 * Date: 5-2-2012
 */

import QtQuick 1.1
import "components/common"
import "components/pages"

SimplePage {
    id: people

    //width: 1000
    //height: 650

    width: 1024
    height: 768

    DefaultSettings { id: settings }
    DBIntegration { id: dbi }
    Helper { id: helper }
    Main { id: main }

}
