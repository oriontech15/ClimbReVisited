//
//  TaskController.swift
//  Climb
//
//  Created by Justin Smith on 2/2/16.
//  Copyright © 2016 Justin Smith. All rights reserved.
//

import Foundation
import CoreData

class TaskController
{
    static func insertTaskIntoContext(context: NSManagedObjectContext) -> Task
    {
        return NSEntityDescription.insertNewObjectForEntityForName(Task.className, inManagedObjectContext: context) as! Task
    }
    
    static func removeTask(task: Task, context: NSManagedObjectContext) -> Bool
    {
        context.deleteObject(task)
        
        if task.managedObjectContext == nil
        {
            return true
        }
        else
        {
            return false
        }
    }
    
    static func allTasksForGoal(goal: Goal) -> [Task]?
    {
        let request = NSFetchRequest(entityName: "Task")
        request.relationshipKeyPathsForPrefetching = ["Tasks"]
        
        var tasks = [Task]()
        do
        {
            tasks = try goal.managedObjectContext!.executeFetchRequest(request) as! [Task]
            print("Tasks Fetch Succeeded! \(tasks)")
        }
        catch let error as NSError
        {
            print("Tasks Fetch Failed: -- \(error.localizedDescription) in \(#function)")
            return nil
        }
        
        return tasks
    }
    
    static func finishedTasksForGoal(goal: Goal) -> [Task]?
    {
        let request = NSFetchRequest(entityName: "Task")
        request.relationshipKeyPathsForPrefetching = ["tasks"]
        let finishedGoalPredicate = NSPredicate(format: "finished = 1")
        request.predicate = finishedGoalPredicate
        
        var finishedTasks = [Task]()
        do
        {
            finishedTasks = try goal.managedObjectContext!.executeFetchRequest(request) as! [Task]
            print("Finished Tasks Fetch Succeeded!")
        }
        catch let error as NSError
        {
            print("Finished Tasks Fetch Failed: -- \(error.localizedDescription) in \(#function)")
            return nil
        }
        
        return finishedTasks
    }
    
    static func unfinishedTasksForGoal(goal: Goal) -> [Task]?
    {
        let request = NSFetchRequest(entityName: "Task")
        request.relationshipKeyPathsForPrefetching = ["tasks"]
        let finishedGoalPredicate = NSPredicate(format: "finished = 0")
        request.predicate = finishedGoalPredicate
        
        var unfinishedTasks = [Task]()
        do
        {
            unfinishedTasks = try goal.managedObjectContext!.executeFetchRequest(request) as! [Task]
            print("Unfinished Tasks Fetch Succeeded!")
        }
        catch let error as NSError
        {
            print("Unfinished Tasks Fetch Failed: -- \(error.localizedDescription) in \(#function)")
            return nil
        }
        
        return unfinishedTasks
    }
}