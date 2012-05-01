/*
 * File:
 * Description:
 * Author: dyoung24
 * Instructor: Johnson
 * Course: CS 422
 * Date: 5-2-2012
 */

import QtQuick 1.1

Item {
    id: container


    /* Properties
     */

    property string productDataSource: "../models/ProductsModel.qml"
    property string machineDataSource: "../models/MachinesModel.qml"
    property string currencyDataSource: "../models/CurrenciesModel.qml"

    property string dbName: settings.appName + "DB"
    property string dbVer: "1.0"
    property string dbDesc: ""
    property int dbSize: 10000

    property bool alwaysReset: true
    property bool initialized: false

    /* Functions
     */

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
                            tx.executeSql("DROP TABLE IF EXISTS Products");
                            tx.executeSql("DROP TABLE IF EXISTS Machines");
                            tx.executeSql("DROP TABLE IF EXISTS Currencies");
                            tx.executeSql("DROP TABLE IF EXISTS Settings");
                            tx.executeSql("DROP TABLE IF EXISTS History");
                        } catch(error) {
                            console.log("resetDB: " + error);
                        }
                    });
    }

    function doSql(sql) {
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
                            console.log("doSql: " + error);
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


        /* Load products into the database
         */
        component = Qt.createComponent(productDataSource);
        if (component.status !== Component.Ready) {
            console.log("initialize: Product data source didn't load");
            return;
        } else {

            sqlStatement = "CREATE TABLE IF NOT EXISTS Products(id INTEGER PRIMARY KEY, name TEXT, price REAL, image TEXT, category TEXT, favorite TEXT, allergens TEXT, machines TEXT)";
            result = doSql(sqlStatement);

            model = component.createObject(null);

            for (i = 0; i < model.count; ++i) {
                sqlStatement = "INSERT INTO Products(name,price,image,category,favorite,allergens,machines) VALUES('" +
                        model.get(i).name + "'," +
                        model.get(i).price + ",'" +
                        model.get(i).image + "','" +
                        model.get(i).category + "','" +
                        model.get(i).favorite+ "','" +
                        model.get(i).allergens + "','" +
                        model.get(i).machines + "')";
                doSql(sqlStatement);
            }
        }


        /* Load vending machines into the database
         */
        component = Qt.createComponent(machineDataSource);
        if (component.status !== Component.Ready) {
            console.log("initialize: Machine data source didn't load");
            return;
        } else {

            sqlStatement = "CREATE TABLE IF NOT EXISTS Machines(id INTEGER PRIMARY KEY, map TEXT)";
            result = doSql(sqlStatement);

            model = component.createObject(null);

            for (i = 0; i < model.count; ++i) {
                sqlStatement = "INSERT INTO Machines(map) VALUES('" +
                        model.get(i).map + "')";
                doSql(sqlStatement);
            }
        }


        /* Load currencies into the database
         */
        component = Qt.createComponent(currencyDataSource);
        if (component.status !== Component.Ready) {
            console.log("initialize: Currency data source didn't load");
            return;
        } else {

            sqlStatement = "CREATE TABLE IF NOT EXISTS Currencies(id INTEGER PRIMARY KEY, name TEXT, rate REAL, code TEXT)";
            result = doSql(sqlStatement);

            model = component.createObject(null);

            for (i = 0; i < model.count; ++i) {
                sqlStatement = "INSERT INTO Currencies(name, rate, code) VALUES('" +
                        model.get(i).name + "'," +
                        model.get(i).rate + ",'" +
                        model.get(i).code + "')";
                doSql(sqlStatement);
            }
        }


        /* Create the settings table
         */
        sqlStatement = "CREATE TABLE IF NOT EXISTS Settings(key TEXT, val TEXT)";
        result = doSql(sqlStatement);


        /* Create the history table
         */
        sqlStatement = "CREATE TABLE IF NOT EXISTS History(id INT, timestamp TEXT)";
        result = doSql(sqlStatement);

        initialized = true;
    } // initialize()



    function setSetting(key, val) {
        var sqlStatement = "REPLACE INTO Settings(key, val) VALUES('" +
                key + "', '" + val + "')";
        var result = doSql(sqlStatement);


        if (result.rowsAffected !== 1) {
            console.log(result.rowsAffected);
            console.log(result.insertId);
            return false;
        } else {
            return true;
        }
    }

    function getSetting(key) {
        var sqlStatement = "SELECT val FROM Settings WHERE key = '" + key + "'";
        var result = doSql(sqlStatement);

        if (result.rows.length !== 1) {
            console.log("getSetting: no results!");
            return "";
        } else {
            return result.rows.item(0).val;
        }
    }


    // type is All, Favorites or Category
    function importProducts(model, type, category) {

        var sqlStatement;
        if (type === "Favorites")
            sqlStatement = "SELECT * FROM Products WHERE favorite <> ''";
        else if (type === "All")
            sqlStatement = "SELECT * FROM Products";
        else if (type === "Category")
            sqlStatement = "SELECT * FROM Products WHERE category = '" + category + "'";
        var results = doSql(sqlStatement);

        var r = results.rows;

        if (r.length === 0) {
            console.log("importProducts: no results");
        }

        model.clear();
        reload(model, r);
        return true;

    }



    function importCategories(model) {

        var sqlStatement = "SELECT DISTINCT category FROM Products";
        var results = doSql(sqlStatement);

        var r = results.rows;

        if (r.length === 0) {
            console.log("importByCategory: no results");
        }

        model.clear();

        for (var i = 0; i < r.length; i++) {
            model.append({"name": r.item(i).category});
        }

        return true;
    }


    function importCartItems(model, itemsString) {

        model.clear();
        var sqlStatement;
        var result;

        if (itemsString === "") {
            console.log("importCartItems: itemsString was empty");
            return;
        }

        // Trim followed by squish followed by split
        var items = itemsString.replace(/^\s/,"").replace(/\s+/g," ").split(" ");

        for (var i = 0; i < items.length; ++i) {
            sqlStatement = "SELECT * FROM Products WHERE id = " + items[i];
            result = doSql(sqlStatement);
            reload(model, result.rows);
        }

        return true;
    }

    function reload(model, r) {

        for (var i = 0; i < r.length; i++) {
            model.append({
                             "id": r.item(i).id,
                             "name": r.item(i).name,
                             "price": r.item(i).price,
                             "image": r.item(i).image,
                             "category": r.item(i).category,
                             "favorite": r.item(i).favorite,
                             "allergens": r.item(i).allergens,
                             "machines": r.item(i).machines
                         });

        }
    }

    function currencyExchange(price, currencyCode) {

        if (price === 0) {
            return "0"
        }

        var sqlStatement = "SELECT rate FROM Currencies WHERE code = '" + currencyCode + "'";
        var result = doSql(sqlStatement);

        if (result.rows.length !== 1) {
            console.log("currencyExchange: no results");
            return 0;
        }

        var rate = result.rows.item(0).rate;
        var exchange = price * rate;

        // Returns string representation of float with decimal precision of 2
        return parseFloat(exchange).toFixed(2);
    }

    function addFavorite(id) {
        var sqlStatement = "UPDATE Products SET favorite='Yes' WHERE id=" + id + "";
        var result = doSql(sqlStatement);

        if (result === undefined || result.rowsAffected !== 1) {
            console.log("addFavorite: Incorrect rows affected: " +  result.rowsAffected);
        }
    }

    function removeFavorite(id) {
        var sqlStatement = "UPDATE Products SET favorite='' WHERE id=" + id;
        var result = doSql(sqlStatement);

        if (result.rowsAffected !== 1) {
            console.log("removeFavorite: Incorrect rows affected: " +  result.rowsAffected);
        }
    }


    function getProductInfo(id) {
        var sqlStatement = "SELECT * FROM Products WHERE id = " + id;
        var result = doSql(sqlStatement);

        if (result.rows.length !== 1) {
            console.log("getProductInfo: Incorrect row length: " +  result.rows.length);
        }

        return result.rows.item(0);

    }



    function addToHistory(itemsString) {
        // Trim followed by squish followed by split
        var items = itemsString.replace(/^\s/,"").replace(/\s+/g," ").split(" ");

        var sqlStatement;
        var result;
        var d = new Date();

        var timestamp = d.toLocaleString();

        for (var i = 0; i < items.length; ++i) {
            sqlStatement = "INSERT INTO History (id, timestamp) VALUES (" + items[i] + ", '" + timestamp + "')";
            result = doSql(sqlStatement);
        }

    }
}
