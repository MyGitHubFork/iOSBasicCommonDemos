//
//  CoreDataDAL.swift
//
//
//  Created by Limin Du on 1/22/15.
//  Copyright (c) 2015 . All rights reserved.
//

import Foundation

class CoreDataDAL {
    var dao:CoreDataDAO!
    
    init() {
        dao = CoreDataDAO()
    }
    
    func getAllPersons()->[PersonModal] {
        var people = [PersonModal]()
        
        people = dao.getEntities() as [PersonModal]
        
        return people
    }
    
    func savePerson(name:String)->PersonModal? {
        if let person = dao.saveEntity(name) {
            return person as? PersonModal
        }
        
        return nil
    }
 
    func deletePerson(name:String)->Bool {
        return dao.deleteEntity(name)
    }
    
    func saveContext() {
        dao.saveContext()
    }
}