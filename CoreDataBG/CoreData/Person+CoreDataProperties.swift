//
//  Person+CoreDataProperties.swift
//  CoreDataBG
//
//  Created by Ashutosh Kumar Jha on 5/18/16.
//  Copyright © 2016 Ashutosh Kumar Jha. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Person {

    @NSManaged var age: NSNumber?
    @NSManaged var name: String?
    @NSManaged var image: NSData?
    @NSManaged var addresses: NSSet?

}
