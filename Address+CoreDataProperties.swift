//
//  Address+CoreDataProperties.swift
//  CoreDataBG
//
//  Created by Ashutosh Kumar Jha on 5/12/16.
//  Copyright © 2016 Ashutosh Kumar Jha. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Address {

    @NSManaged var city: String?
    @NSManaged var country: String?
    @NSManaged var persons: Person?

}
