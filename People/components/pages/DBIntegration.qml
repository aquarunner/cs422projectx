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


    property string peopleDataSource: "../models/PeopleModel.qml"

    property string dbName: settings.appName + "DB"
    property string dbVer: "1.0"
    property string dbDesc: ""
    property int dbSize: 10000

    property bool alwaysReset: false
    property bool initialized: false

    function openDB() {
        try {
            return openDatabaseSync(dbName, dbVer, dbDesc, dbSize);
        } catch(error) {
            console.log("openDB: " + error);
        }
    }

    function resetDB() {
        var db = openDB();
        db.transaction(
                    function(tx) {
                        try {
                            tx.executeSql("DROP TABLE IF EXISTS People");
                        } catch(error) {
                            console.log("resetDB: " + error);
                        }
                    });
    }

    function doSql(sql) {
//        if (!container.initialized) {
//            console.log("doSql: DB is not initialized (" + sql + ")");
//            return;
//        }

        var db = openDB();

        if (db === undefined) {
            console.log("doSql: Error opening the database");
            return;
        }

        var result;
        db.transaction(
                    function(tx) {
                        try {
                            result = tx.executeSql(sql);
                        } catch(error) {
                            console.log("doSql: " + error + "(" + sql + ")");
                        }
                    })

        return result;

    }

    function initialize() {

        if (container.alwaysReset) {
            resetDB();
        }

        var component;
        var sqlStatement;
        var result;
        var model;
        var i;


        /* Load people records into the database
         */
        component = Qt.createComponent(peopleDataSource);
        if (component.status !== Component.Ready) {
            console.log("initialize: People data source didn't load");
            return;
        } else {

            sqlStatement = "CREATE TABLE IF NOT EXISTS People(id INTEGER PRIMARY KEY, lastName TEXT, firstName TEXT, fullName TEXT, image TEXT, email TEXT, room TEXT, building TEXT, office TEXT, phone TEXT, floor TEXT, dept TEXT, subdept TEXT)";
            result = doSql(sqlStatement);
            //console.log(result.);

            result = doSql("SELECT * FROM People");

            // Populate the table if and only if there isn't already data there
            if (result.rows.length === 0) {

                model = component.createObject(null);

                for (i = 0; i < model.count; ++i) {
                    sqlStatement = "INSERT INTO People(lastName,firstName,fullName,image,email,room,building,office,phone,floor,dept,subdept) VALUES('" +
                            model.get(i).lastName + "','" +
                            model.get(i).firstName + "','" +
                            model.get(i).fullName + "','" +
                            model.get(i).image + "','" +
                            model.get(i).email + "','" +
                            model.get(i).room + "','" +
                            model.get(i).building + "','" +
                            model.get(i).office + "','" +
                            model.get(i).phone + "','" +
                            model.get(i).floor + "','" +
                            model.get(i).dept + "','" +
                            model.get(i).subdept + "')";
                    doSql(sqlStatement);
                }
            }
        }


        container.initialized = true;
    } // initialize()




    function importPeople(model) {

        var sqlStatement = "SELECT * FROM People ";

        var plus = " and ";
        var whereClause = " WHERE ";
        var floorSearch = " floor IN (\'\'," + helper.quote(settings.floorSearch) + ") ";
        var deptSearch = " dept IN (\'\'," + helper.quote(settings.deptSearch) + ") ";
        var lastNameSearch = " SUBSTR(lastName, 1, 1) IN (" + helper.quote(settings.lastNameSearch) + ") ";
        var fullNameSearch = " fullName LIKE '%" + settings.fullNameSearch + "%'";
        whereClause += floorSearch + plus +
                deptSearch + plus +
                lastNameSearch +
                (settings.fullNameSearch ? plus + fullNameSearch : "");

        whereClause += "ORDER BY lastName";

        sqlStatement += whereClause;
        //console.log(sqlStatement);
        var results = doSql(sqlStatement);
        var r = results.rows;

        if (r.length === 0) {
            //console.log("importPeople: no results");
        }

        model.clear();
        reload(model, r);
        return true;

    }


    function reload(model, r) {

        for (var i = 0; i < r.length; i++) {
            model.append({
                             "id": r.item(i).id,
                             "lastName": r.item(i).lastName,
                             "firstName": r.item(i).firstName,
                             "fullName": r.item(i).fullName,
                             "image": r.item(i).image,
                             "email": r.item(i).email,
                             "room": r.item(i).room,
                             "building": r.item(i).building,
                             "office": r.item(i).office,
                             "phone": r.item(i).phone,
                             "floor": r.item(i).floor,
                             "dept": r.item(i).dept,
                             "subdept": r.item(i).subdept
                         });

        }
    }


    function getPersonDetails(id) {
        var sqlStatement = "SELECT * FROM People WHERE id = " + id;
        var result = doSql(sqlStatement);

        if (result.rows.length !== 1) {
            console.log("getProductInfo: Incorrect row length: " +  result.rows.length);
        }

        return result.rows.item(0);

    }

}
