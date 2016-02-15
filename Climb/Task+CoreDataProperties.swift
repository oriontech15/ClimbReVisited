//
//  Task+CoreDataProperties.swift
//  Climb
//
//  Created by Justin Smith on 2/10/16.
//  Copyright © 2016 Justin Smith. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Task {

    @NSManaged var finished: NSNumber?
    @NSManaged var title: String?
    @NSManaged var goal: Goal?

}
