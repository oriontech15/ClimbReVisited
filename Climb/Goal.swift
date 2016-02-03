//
//  Goal.swift
//  Climb
//
//  Created by Justin Smith on 2/2/16.
//  Copyright © 2016 Justin Smith. All rights reserved.
//

import Foundation
import CoreData


class Goal: NSManagedObject {

// Insert code here to add functionality to your managed object subclass
    
    static let className = "Goal"

    convenience init(subGoals: NSOrderedSet, title: String, goalDescription: String, date: NSDate, finished: Bool = false)
    {
        self.init()
        self.goalDescription = goalDescription
        self.title = title
        self.date = date
        self.subGoals = subGoals
        self.finished = finished
    }
}
