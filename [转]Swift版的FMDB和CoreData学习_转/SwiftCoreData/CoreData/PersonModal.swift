//
//  PersonModal.swift
//
//
//  Created by Limin Du on 1/22/15.
//  Copyright (c) 2015 . All rights reserved.
//

import Foundation
import CoreData

@objc(PersonModal)
class PersonModal : NSManagedObject {
    @NSManaged var name: String
}