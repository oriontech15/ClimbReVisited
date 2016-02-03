//
//  SubGoalController.swift
//  Climb
//
//  Created by Justin Smith on 2/2/16.
//  Copyright © 2016 Justin Smith. All rights reserved.
//

import Foundation
import CoreData

class SubGoalController
{
    static func insertSubGoalIntoContext(context: NSManagedObjectContext) -> SubGoal
    {
        return NSEntityDescription.insertNewObjectForEntityForName(SubGoal.className, inManagedObjectContext: context) as! SubGoal
    }
    
    static func removeSubGoal(subGoal: SubGoal, context: NSManagedObjectContext) -> Bool
    {
        context.deleteObject(subGoal)
        
        if subGoal.managedObjectContext == nil
        {
            return true
        }
        else
        {
            return false
        }
    }
    
    static func allSubGoalsInContext(context: NSManagedObjectContext) -> [Goal]?
    {
        let request = NSFetchRequest(entityName: "SubGoal")
        let sortDescriptor = NSSortDescriptor(key: "date", ascending: true)
        request.sortDescriptors = [sortDescriptor]
        
        var subGoals = [Goal]()
        do
        {
            subGoals = try context.executeFetchRequest(request) as! [Goal]
            print("SubGoals Fetch Succeeded!")
        }
        catch let error as NSError
        {
            print("SubGoals Fetch Failed: -- \(error.localizedDescription) in \(__FUNCTION__)")
            return nil
        }
        
        return subGoals
    }
    
    static func finishedSubGoalsInContext(context: NSManagedObjectContext) -> [Goal]?
    {
        let request = NSFetchRequest(entityName: "SubGoal")
        let finishedGoalPredicate = NSPredicate(format: "finished = 1")
        let sortDescriptor = NSSortDescriptor(key: "date", ascending: true)
        request.predicate = finishedGoalPredicate
        request.sortDescriptors = [sortDescriptor]
        
        var finishedSubGoals = [Goal]()
        do
        {
            finishedSubGoals = try context.executeFetchRequest(request) as! [Goal]
            print("Finished SubGoals Fetch Succeeded!")
        }
        catch let error as NSError
        {
            print("Finished SubGoals Fetch Failed: -- \(error.localizedDescription) in \(__FUNCTION__)")
            return nil
        }
        
        return finishedSubGoals
    }
    
    static func unfinishedSubGoalsInContext(context: NSManagedObjectContext) -> [Goal]?
    {
        let request = NSFetchRequest(entityName: "SubGoal")
        let finishedGoalPredicate = NSPredicate(format: "finished = 0")
        let sortDescriptor = NSSortDescriptor(key: "date", ascending: true)
        request.predicate = finishedGoalPredicate
        request.sortDescriptors = [sortDescriptor]
        
        var unfinishedSubGoals = [Goal]()
        do
        {
            unfinishedSubGoals = try context.executeFetchRequest(request) as! [Goal]
            print("Unfinished SubGoals Fetch Succeeded!")
        }
        catch let error as NSError
        {
            print("Unfinished SubGoals Fetch Failed: -- \(error.localizedDescription) in \(__FUNCTION__)")
            return nil
        }
        
        return unfinishedSubGoals
    }
}