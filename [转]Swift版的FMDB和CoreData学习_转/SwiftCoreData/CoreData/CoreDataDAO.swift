//
//  CoreDataDAO.swift
//
//
//  Created by Limin Du on 1/22/15.
//  Copyright (c) 2015 . All rights reserved.
//

import Foundation
import CoreData

class CoreDataDAO {
    var context:CoreDataContext!
    
    init() {
        context = CoreDataContext()
    }
    
    func getEntities()->[NSManagedObject] {
        var entity = [NSManagedObject]()
        
        let managedContext = context.managedObjectContext!
        
        let fetchRequest = NSFetchRequest(entityName:"Person")
        
        //3
        var error: NSError?
        
        let fetchedResults = managedContext.executeFetchRequest(fetchRequest, error: &error) as [NSManagedObject]?
        
        if let results = fetchedResults {
            entity = results
        } else {
            //println("Could not fetch \(error), \(error!.userInfo)")
        }
        
        return entity
    }
    
    func queryEntityByName(name:String)->NSManagedObject?{
        var entity = [NSManagedObject]()
        
        let managedContext = context.managedObjectContext!
        
        let fetchRequest = NSFetchRequest(entityName:"Person")
        let predicate = NSPredicate(format: "%K = %@", "name", name)
        fetchRequest.predicate = predicate
        
        var error: NSError?
        let fetchedResults = managedContext.executeFetchRequest(fetchRequest, error: &error) as [NSManagedObject]?
        
        if let results = fetchedResults {
            if results.count == 0 {
                return nil
            }
            
            entity = results
        } else {
            //println("Could not fetch \(error), \(error!.userInfo)")
            return nil
        }
        
        return entity[0]
    }
    
    func saveEntity(name:String)->NSManagedObject? {
        if let _ = queryEntityByName(name) {
            return nil
        }
        
        let managedContext = context.managedObjectContext!
        
        let entity =  NSEntityDescription.entityForName("Person", inManagedObjectContext:managedContext)
        
        let person = NSManagedObject(entity: entity!, insertIntoManagedObjectContext:managedContext)
        
        person.setValue(name, forKey: "name")
        
        var error: NSError?
        if !managedContext.save(&error) {
            println("Could not save \(error), \(error?.userInfo)")
            return nil
        }
        
        return person
    }
    
    func deleteEntity(name:String)->Bool {
        let managedContext = context.managedObjectContext!
        
        let entityToDelete = queryEntityByName(name)
        if let entity = entityToDelete {
            managedContext.deleteObject(entity)
            var error:NSError?
            if managedContext.save(&error) != true {
                println("Delete error: " + error!.localizedDescription)
                return false
            }
            
            return true
        }
        
        return false
    }
    
    func saveContext() {
        context.saveContext()
    }
}