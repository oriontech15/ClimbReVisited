//
//  Task.swift
//  Climb
//
//  Created by Justin Smith on 2/10/16.
//  Copyright © 2016 Justin Smith. All rights reserved.
//

import Foundation
import CoreData


class Task: NSManagedObject {

// Insert code here to add functionality to your managed object subclass
    static let className = "Task"
    
    convenience init(title: String, goal: Goal, finished: Bool = false)
    {
        self.init()
        self.title = title
        self.goal = goal
        self.finished = finished
    }

}
