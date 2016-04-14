//
//  GoalController.swift
//  Climb
//
//  Created by Justin Smith on 2/2/16.
//  Copyright © 2016 Justin Smith. All rights reserved.
//

import Foundation
import CoreData

class GoalController
{
    
    static var timer = NSTimer()
    
    static func insertGoalIntoContext(context: NSManagedObjectContext) -> Goal
    {
        return NSEntityDescription.insertNewObjectForEntityForName(Goal.className, inManagedObjectContext: context) as! Goal
    }
    
    static func saveGoalInContext(context: NSManagedObjectContext) -> Bool
    {
        do
        {
            try context.save()
            print("Goal SAVE Attempt Succeeded!")
            return true

        }
        catch let error as NSError
        {
            print("Goal Did NOT Save: -- \(error.localizedDescription) in \(#function)")
            return false
        }
    }
    
    static func removeGoalFromContext(goal: Goal, context: NSManagedObjectContext) -> Bool
    {
        goal.managedObjectContext?.deleteObject(goal)
        do {
            GoalController.timer.invalidate()
            try context.save()
        } catch let error as NSError {
            NSLog("\(error)")
        }
        
        if goal.managedObjectContext == nil
        {
            return true
        }
        else
        {
            return false
        }
    }
    
    static func allGoalsInContext(context: NSManagedObjectContext) -> [Goal]?
    {
        let request = NSFetchRequest(entityName: "Goal")
        let sortDescriptor = NSSortDescriptor(key: "date", ascending: true)
        request.sortDescriptors = [sortDescriptor]
        
        var goals = [Goal]()
        do
        {
            goals = try context.executeFetchRequest(request) as! [Goal]
            print("Goal Fetch Succeeded!")
        }
        catch let error as NSError
        {
            print("Goal Fetch Failed: -- \(error.localizedDescription) in \(#function)")
            return nil
        }
        
        for goal in goals
        {
            if let date = goal.date
            {
                if date.compare(NSDate()) == NSComparisonResult.OrderedAscending
                {
                    goal.finished = true
                }
            }
        }
        
        return goals
    }
    
    static func finishedGoalsInContext(context: NSManagedObjectContext) -> [Goal]?
    {
        let request = NSFetchRequest(entityName: "Goal")
        request.relationshipKeyPathsForPrefetching = ["tasks"]
        let finishedGoalPredicate = NSPredicate(format: "finished = 1")
        let sortDescriptor = NSSortDescriptor(key: "date", ascending: true)
        request.predicate = finishedGoalPredicate
        request.sortDescriptors = [sortDescriptor]
        
        var finishedGoals = [Goal]()
        do
        {
            finishedGoals = try context.executeFetchRequest(request) as! [Goal]
            print("Finished Goals Fetch Succeeded!")
        }
        catch let error as NSError
        {
            print("Finished Goals Fetch Failed: -- \(error.localizedDescription) in \(#function)")
            return nil
        }
        
        return finishedGoals
    }
    
    static func unfinishedGoalsInContext(context: NSManagedObjectContext) -> [Goal]?
    {
        let request = NSFetchRequest(entityName: "Goal")
        request.relationshipKeyPathsForPrefetching = ["tasks"]
        let finishedGoalPredicate = NSPredicate(format: "finished = 0")
        let sortDescriptor = NSSortDescriptor(key: "date", ascending: true)
        request.predicate = finishedGoalPredicate
        request.sortDescriptors = [sortDescriptor]
        
        var unfinishedGoals = [Goal]()
        do
        {
            unfinishedGoals = try context.executeFetchRequest(request) as! [Goal]
            print("Unfinished Goals Fetch Succeeded!")
        }
        catch let error as NSError
        {
            print("Unfinished Goals Fetch Failed: -- \(error.localizedDescription) in \(#function)")
            return nil
        }
        
        return unfinishedGoals
    }
}