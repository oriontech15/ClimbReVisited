//
//  SubGoal.swift
//  Climb
//
//  Created by Justin Smith on 2/2/16.
//  Copyright © 2016 Justin Smith. All rights reserved.
//

import Foundation
import CoreData


class SubGoal: NSManagedObject {

// Insert code here to add functionality to your managed object subclass

    static let className = "SubGoal"
    
    convenience init(title: String, goal: Goal, date: NSDate, finished: Bool = false)
    {
        self.init()
        self.title = title
        self.goal = goal
        self.date = date
        self.finished = finished
    }
}
