//
//  EntryDAL.swift
//  SwiftFMDBDemo
//
//  Created by Limin Du on 11/17/14.
//  Copyright (c) 2014 GoldenFire.Do. All rights reserved.
//

import Foundation

class EntryDAL {
    let dao = DAO()
    
    func insertEntry(entry:Entry)->Bool {
        return dao.insert(entry.name, description: entry.description)
    }
    
    func deleteEntry(entry:Entry)->Bool {
        return dao.delete(entry.name, description: entry.description)
    }
    
    func getAllEntries()->[Entry] {
       return dao.getRecordSet()
    }
    
    func query(name:String,description:String)->Entry?{
        return dao.query(name, description: description)
    }
}