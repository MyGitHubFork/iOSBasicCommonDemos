//
//  DB.swift
//  SwiftFMDBDemo
//
//  Created by Limin Du on 11/15/14.
//  Copyright (c) 2014 GoldenFire.Do. All rights reserved.
//

import Foundation

class DB {
    
    class var sharedInstance: DB {
        struct Static {
            static var instance: DB?
            static var token: dispatch_once_t = 0
        }
        
        dispatch_once(&Static.token) {
            Static.instance = DB()
            
            Static.instance?.initDatabase()
        }
        
        return Static.instance!
    }
    
    class var tableName:String {
        return "table1"
    }
    
    private var db:FMDatabase?
    
    func getDatabase()->FMDatabase? {
        return db
    }
    
    private func initDatabase()->Bool {
        var result:Bool = false
        let table_name = DB.tableName
        let documentPath : AnyObject = NSSearchPathForDirectoriesInDomains(.DocumentDirectory,.UserDomainMask,true)[0]
        let dbPath:String = documentPath.stringByAppendingPathComponent("demo.db")
        
        let filemanager = NSFileManager.defaultManager()
        if !filemanager.fileExistsAtPath(dbPath) {
            result = filemanager.createFileAtPath(dbPath, contents: nil, attributes: nil)
            if !result {
                return false
            }
        }
        
        db = FMDatabase(path: dbPath)
        if db == nil {
            return false
        }
        
        db!.logsErrors = true
        if db!.open() {
            //db!.shouldCacheStatements()
            /*if db!.tableExists(table_name) {
                db!.executeUpdate("DROP TABLE \(table_name)", withArgumentsInArray: nil)
            }*/
            
            if !db!.tableExists(table_name) {
                var creat_table = "CREATE TABLE \(table_name) (id INTEGER PRIMARY KEY, name VARCHAR(80), description VARCHAR(80))"
                result = db!.executeUpdate(creat_table, withArgumentsInArray: nil)
            }
        }
        
        println("init : \(result)")
        
        return result
    }
    
    func closeDatabase() {
        db?.close()
    }
    
    
}
