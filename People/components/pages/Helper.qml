/*
 * Project: PeopleFinder
 * Author: dyoung24
 * Instructor: Johnson
 * Course: CS 422
 * Date: 5-2-2012
 */

import QtQuick 1.1

Item {

    /* Helper functions
     */

    function trim(str) {

        str = str.replace(/^\s/,"").replace(/\s+/g," ").replace(/ +$/,"");

        return str;
    }


    function quote(str) {
        var spl = trim(str).split(" ");
        var result = "";
        for (var i = 0; i < spl.length; ++i) {
            result += "\'" + spl[i] + "\'";
            if (i + 1 < spl.length) {
                result += ",";
            }
        }

        return result;
    }



}
