//
//  SubGoal+CoreDataProperties.swift
//  Climb
//
//  Created by Justin Smith on 2/2/16.
//  Copyright © 2016 Justin Smith. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension SubGoal {

    @NSManaged var date: NSDate?
    @NSManaged var title: String?
    @NSManaged var finished: NSNumber?
    @NSManaged var goal: Goal?

}
