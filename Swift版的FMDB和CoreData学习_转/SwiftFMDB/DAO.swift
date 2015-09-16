//
//  DAO.swift
//  SwiftFMDBDemo
//
//  Created by Du Limin on 11/15/14.
//  Copyright (c) 2014 GoldenFire.Do. All rights reserved.
//

import Foundation

class DAO {
    var db:FMDatabase
    var tableName:String
    
    init () {
        db = DB.sharedInstance.getDatabase()!
        tableName = DB.tableName
    }
    
    func getRecordSet()->[Entry] {
        
        var result:[Entry] = []
        
        var sql = "SELECT * FROM \(tableName)"
        println("\(sql)")
        
        var rs = db.executeQuery(sql, withArgumentsInArray: nil)
        while (rs.next()) {
            var entry = Entry()
            var id = rs.intForColumn("id")
            var name = rs.stringForColumn("name")
            var desc = rs.stringForColumn("description")
            entry.id = id
            entry.name = name
            entry.description = desc
            
            println("id:\(id), name:\(name), desc:\(desc)")
            
            result.append(entry)
        }
        
        rs.close()
        
        return result
    }
    
    func query(name:String, description:String)->Entry? {
        var result:Entry?
        
        var sql = "SELECT * FROM \(tableName) where name= ? and description = ?"
        var args = [name, description]
        println("\(sql)")
        
        var rs = db.executeQuery(sql, withArgumentsInArray: args)
        if (rs.next()) {
            result = Entry()
            var id = rs.intForColumn("id")
            var name = rs.stringForColumn("name")
            var desc = rs.stringForColumn("description")
            result!.id = id
            result!.name = name
            result!.description = desc
        }
    
        return result
    }
    
    func insert(name:String, description:String)->Bool {
        var sql = "INSERT INTO \(tableName) (name, description) VALUES (?, ?)"
        var args = [name, description]
        println("\(sql)")
        
        db.executeUpdate(sql, withArgumentsInArray: args)
        
        if db.hadError() {
            print("error:\(db.lastErrorMessage())")
            return false
        }
        
        return true
    }
    
    func delete(name:String, description:String)->Bool {
        var sql = "DELETE FROM \(tableName) where name= ? and description = ?"
        var args = [name, description]
        println("\(sql)")
        
        db.executeUpdate(sql, withArgumentsInArray: args)
        
        if db.hadError() {
            print("error:\(db.lastErrorMessage())")
            return false
        }
        
        return true
    }
    
    deinit {
       //DB.sharedInstance.closeDatabase()
    }
}
