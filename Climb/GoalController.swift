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
            print("Goal Did NOT Save: -- \(error.localizedDescription) in \(__FUNCTION__)")
            return false
        }
    }
    
    static func removeGoalFromContext(goal: Goal, context: NSManagedObjectContext) -> Bool
    {
        print("GOAL BEFORE DELETED: \(goal.managedObjectContext)")
        goal.managedObjectContext?.deleteObject(goal)
        print("GOAL AFTER DELETED: \(goal.managedObjectContext)")
        
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
        request.relationshipKeyPathsForPrefetching = ["tasks"]
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
            print("Goal Fetch Failed: -- \(error.localizedDescription) in \(__FUNCTION__)")
            return nil
        }
        
        return goals
    }
    
    static func finishedGoalsInContext(context: NSManagedObjectContext) -> [Goal]?
    {
        let request = NSFetchRequest(entityName: "Goal")
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
            print("Finished Goals Fetch Failed: -- \(error.localizedDescription) in \(__FUNCTION__)")
            return nil
        }
        
        return finishedGoals
    }
    
    static func unfinishedGoalsInContext(context: NSManagedObjectContext) -> [Goal]?
    {
        let request = NSFetchRequest(entityName: "Goal")
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
            print("Unfinished Goals Fetch Failed: -- \(error.localizedDescription) in \(__FUNCTION__)")
            return nil
        }
        
        return unfinishedGoals
    }
}