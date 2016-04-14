//
//  GoalListViewController.swift
//  Climb
//
//  Created by Justin Smith on 2/2/16.
//  Copyright © 2016 Justin Smith. All rights reserved.
//

import UIKit
import Foundation

class GoalListViewController: UIViewController
{
    @IBOutlet weak var tableView: UITableView!
    
    var headerLabel = UILabel()
    var currentHeaderNumGoalsLabel = UILabel()
    var finishedHeaderNumGoalsLabel = UILabel()
    
    var currentGoalsCount = 0
    var unfinishedGoalsCount = 0
    var finishedGoalsCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Goal List"
        self.parentViewController?.tabBarItem.image = UIImage(named: "tabBarButtonList")?.imageWithRenderingMode(.Automatic)
        self.parentViewController?.tabBarItem.selectedImage = UIImage(named: "tabBarButtonList")?.imageWithRenderingMode(.AlwaysOriginal)
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(true)
        tableView.reloadData()
    }
}


extension GoalListViewController: UITableViewDataSource, UITableViewDelegate
{
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        if let unfinishedGoalCount = GoalController.unfinishedGoalsInContext(Stack.sharedStack.managedObjectContext)?.count,
            let finishedGoalCount = GoalController.finishedGoalsInContext(Stack.sharedStack.managedObjectContext)?.count
        {
            if unfinishedGoalCount > 0 && finishedGoalCount > 0
            {
                return 2
            }
            else if (unfinishedGoalCount > 0 && finishedGoalCount == 0) || (finishedGoalCount > 0 && unfinishedGoalCount == 0)
            {
                return 1
            }
            else
            {
                return 0
            }
        }
        else
        {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        return 65
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 75
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 8
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if let unfinishedGoalCount = GoalController.unfinishedGoalsInContext(Stack.sharedStack.managedObjectContext)?.count,
            let finishedGoalCount = GoalController.finishedGoalsInContext(Stack.sharedStack.managedObjectContext)?.count
        {
            if unfinishedGoalCount > 0 && section == 0
            {
                self.unfinishedGoalsCount = unfinishedGoalCount
                return unfinishedGoalCount
            }
            else if unfinishedGoalCount == 0 && finishedGoalCount > 0 && section == 0
            {
                self.finishedGoalsCount = finishedGoalCount
                return finishedGoalCount
            }
            else if unfinishedGoalCount > 0 && finishedGoalCount > 0 && section == 0
            {
                self.unfinishedGoalsCount = unfinishedGoalCount
                return unfinishedGoalCount
            }
            else if unfinishedGoalCount > 0 && finishedGoalCount > 0 && section == 1
            {
                self.finishedGoalsCount = finishedGoalCount
                return finishedGoalCount
            }
            else
            {
                return 0
            }
        }
        else
        {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section
        {
        case 0:
            return "Current Goals"
        case 1:
            return "Finished Goals"
        default:
            return ""
        }
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath)
    {
        if editingStyle == .Delete
        {
            if let unfinishedGoals = GoalController.unfinishedGoalsInContext(Stack.sharedStack.managedObjectContext),
                let finishedGoals = GoalController.finishedGoalsInContext(Stack.sharedStack.managedObjectContext)
            {
                if indexPath.section == 0
                {
                    if unfinishedGoals.count == 0 && finishedGoals.count > 0
                    {
                        if finishedGoals.count == 1
                        {
                            GoalController.removeGoalFromContext(finishedGoals[indexPath.row], context: Stack.sharedStack.managedObjectContext)
                            GoalController.saveGoalInContext(Stack.sharedStack.managedObjectContext)
                            tableView.deleteSections(NSIndexSet(index: indexPath.section), withRowAnimation: .Middle)
                            finishedHeaderNumGoalsLabel.text = "\(finishedGoals.count)"
                        }
                        else
                        {
                            GoalController.removeGoalFromContext(finishedGoals[indexPath.row], context: Stack.sharedStack.managedObjectContext)
                            GoalController.saveGoalInContext(Stack.sharedStack.managedObjectContext)
                            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Middle)
                            finishedHeaderNumGoalsLabel.text = "\(finishedGoals.count)"
                        }
                    }
                    else
                    {
                        if unfinishedGoals.count == 1
                        {
                            GoalController.removeGoalFromContext(unfinishedGoals[indexPath.row], context: Stack.sharedStack.managedObjectContext)
                            GoalController.saveGoalInContext(Stack.sharedStack.managedObjectContext)
                            tableView.deleteSections(NSIndexSet(index: indexPath.section), withRowAnimation: .Middle)
                            finishedHeaderNumGoalsLabel.text = "\(unfinishedGoals.count)"
                        }
                        else
                        {
                            GoalController.removeGoalFromContext(unfinishedGoals[indexPath.row], context: Stack.sharedStack.managedObjectContext)
                            GoalController.saveGoalInContext(Stack.sharedStack.managedObjectContext)
                            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Middle)
                            finishedHeaderNumGoalsLabel.text = "\(unfinishedGoals.count)"
                        }
                    }
                }
                else
                {
                    if finishedGoals.count == 1
                    {
                        GoalController.removeGoalFromContext(finishedGoals[indexPath.row], context: Stack.sharedStack.managedObjectContext)
                        GoalController.saveGoalInContext(Stack.sharedStack.managedObjectContext)
                        tableView.deleteSections(NSIndexSet(index: indexPath.section), withRowAnimation: .Middle)
                        finishedHeaderNumGoalsLabel.text = "\(finishedGoals.count)"
                    }
                    else
                    {
                        GoalController.removeGoalFromContext(finishedGoals[indexPath.row], context: Stack.sharedStack.managedObjectContext)
                        GoalController.saveGoalInContext(Stack.sharedStack.managedObjectContext)
                        tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Middle)
                        finishedHeaderNumGoalsLabel.text = "\(finishedGoals.count)"
                    }
                }
            }
        }
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        let headerView = HeaderForGoalList(frame: CGRectMake(0, 0, self.view.frame.width, 85))
        
        if let unfinishedGoals = GoalController.unfinishedGoalsInContext(Stack.sharedStack.managedObjectContext),
            let finishedGoals = GoalController.finishedGoalsInContext(Stack.sharedStack.managedObjectContext)
        {
        if section == 0
        {
            if unfinishedGoals.count == 0 && finishedGoals.count > 0
            {
                headerView.lineColor = UIColor(red: 0.110, green: 0.816, blue: 1.000, alpha: 1.00)
                
                headerLabel = UILabel(frame: CGRectMake(0, 0, self.view.frame.width, 35))
                headerLabel.text = "Finished Goals"
                headerLabel.textAlignment = .Center
                headerLabel.font = UIFont(name: "HelveticaNeue-Medium", size: 22)
                headerLabel.textColor = .lightGrayColor()
                headerLabel.textColor = UIColor(red: 0.110, green: 0.816, blue: 1.000, alpha: 1.00)
                
                currentHeaderNumGoalsLabel = UILabel(frame: CGRectMake(0, headerLabel.frame.origin.y + 42, self.view.frame.width, 50))
                currentHeaderNumGoalsLabel.text = "\(finishedGoals.count)"
                currentHeaderNumGoalsLabel.textAlignment = .Center
                currentHeaderNumGoalsLabel.font = UIFont(name: "HelveticaNeue-Medium", size: 30)
                currentHeaderNumGoalsLabel.textColor = UIColor(red: 0.110, green: 0.816, blue: 1.000, alpha: 1.00)
                headerView.backgroundColor = .clearColor()
                
                headerView.addSubview(headerLabel)
                
                headerView.addSubview(currentHeaderNumGoalsLabel)
            }
            else
            {
                headerView.lineColor = UIColor(red: 1.000, green: 0.914, blue: 0.290, alpha: 1.00)
                
                headerLabel = UILabel(frame: CGRectMake(0, 0, self.view.frame.width, 35))
                headerLabel.text = "Current Goals"
                headerLabel.textAlignment = .Center
                headerLabel.font = UIFont(name: "HelveticaNeue-Medium", size: 22)
                headerLabel.textColor = .lightGrayColor()
                headerLabel.textColor = UIColor(red: 1.000, green: 0.914, blue: 0.290, alpha: 1.00)
                
                finishedHeaderNumGoalsLabel = UILabel(frame: CGRectMake(0, headerLabel.frame.origin.y + 42, self.view.frame.width, 50))
                finishedHeaderNumGoalsLabel.text = "\(unfinishedGoals.count)"
                finishedHeaderNumGoalsLabel.textAlignment = .Center
                finishedHeaderNumGoalsLabel.font = UIFont(name: "HelveticaNeue-Medium", size: 30)
                finishedHeaderNumGoalsLabel.textColor = UIColor(red: 1.000, green: 0.914, blue: 0.290, alpha: 1.00)
                headerView.backgroundColor = .clearColor()
                
                headerView.addSubview(headerLabel)
                
                headerView.addSubview(finishedHeaderNumGoalsLabel)
            }
        }
        else
        {
            headerView.lineColor = UIColor(red: 0.110, green: 0.816, blue: 1.000, alpha: 1.00)
            
            headerLabel = UILabel(frame: CGRectMake(0, 0, self.view.frame.width, 35))
            headerLabel.text = "Finished Goals"
            headerLabel.textAlignment = .Center
            headerLabel.font = UIFont(name: "HelveticaNeue-Medium", size: 22)
            headerLabel.textColor = .lightGrayColor()
            headerLabel.textColor = UIColor(red: 0.110, green: 0.816, blue: 1.000, alpha: 1.00)
            
            finishedHeaderNumGoalsLabel = UILabel(frame: CGRectMake(0, headerLabel.frame.origin.y + 42, self.view.frame.width, 50))
            finishedHeaderNumGoalsLabel.text = "\(finishedGoals.count)"
            finishedHeaderNumGoalsLabel.textAlignment = .Center
            finishedHeaderNumGoalsLabel.font = UIFont(name: "HelveticaNeue-Medium", size: 30)
            finishedHeaderNumGoalsLabel.textColor = UIColor(red: 0.110, green: 0.816, blue: 1.000, alpha: 1.00)
            headerView.backgroundColor = .clearColor()
            
            headerView.addSubview(headerLabel)
            
            headerView.addSubview(finishedHeaderNumGoalsLabel)
        }
        }
        
        return headerView
    }
    
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView?
    {
        let view = UIView(frame: CGRectMake(0, 0, self.view.frame.size.width, 8))
        let seperatorView = UIView(frame: CGRectMake(0, 0, self.view.frame.size.width, 2))
        
        if let unfinishedGoals = GoalController.unfinishedGoalsInContext(Stack.sharedStack.managedObjectContext),
            let finishedGoals = GoalController.finishedGoalsInContext(Stack.sharedStack.managedObjectContext)
        {
            if section == 0
            {
                if unfinishedGoals.count == 0 && finishedGoals.count > 0
                {
                    seperatorView.backgroundColor = UIColor(red: 0.110, green: 0.816, blue: 1.000, alpha: 1.00)
                }
                else
                {
                    seperatorView.backgroundColor = UIColor(red: 1.000, green: 0.914, blue: 0.290, alpha: 1.00)
                }
            }
            else
            {
                seperatorView.backgroundColor = UIColor(red: 0.110, green: 0.816, blue: 1.000, alpha: 1.00)
            }
        }
        
        view.addSubview(seperatorView)
        return view
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("goalListCell", forIndexPath: indexPath)
        
        if let unfinishedGoals = GoalController.unfinishedGoalsInContext(Stack.sharedStack.managedObjectContext),
            let finishedGoals = GoalController.finishedGoalsInContext(Stack.sharedStack.managedObjectContext)
        {
            switch indexPath.section
            {
            case 0:
                if unfinishedGoals.count == 0 && finishedGoals.count > 0
                {
                    let goal = finishedGoals[indexPath.row]
                    cell.textLabel?.text = goal.title
                    
                    cell.detailTextLabel?.text = String.shortDateForCollectionView(goal.date!)
                    cell.textLabel?.textColor = UIColor(red: 0.110, green: 0.816, blue: 1.000, alpha: 1.00)
                    cell.detailTextLabel?.textColor = UIColor(red: 0.110, green: 0.816, blue: 1.000, alpha: 1.00)
                }
                else
                {
                    print("UNFINISHED GOALS -- \(unfinishedGoals)")
                    let goal = unfinishedGoals[indexPath.row]
                    cell.textLabel?.text = goal.title
                    cell.detailTextLabel?.text = String.shortDateForCollectionView(goal.date!)
                    cell.textLabel?.textColor = UIColor(red: 1.000, green: 0.914, blue: 0.290, alpha: 1.00)
                    cell.detailTextLabel?.textColor = UIColor(red: 1.000, green: 0.914, blue: 0.290, alpha: 1.00)
                }
                
            case 1:
                print("FINISHED GOALS -- \(finishedGoals)")
                let goal = finishedGoals[indexPath.row]
                cell.textLabel?.text = goal.title
                
                cell.detailTextLabel?.text = String.shortDateForCollectionView(goal.date!)
                cell.textLabel?.textColor = UIColor(red: 0.110, green: 0.816, blue: 1.000, alpha: 1.00)
                cell.detailTextLabel?.textColor = UIColor(red: 0.110, green: 0.816, blue: 1.000, alpha: 1.00)
                
            default:
                break
            }
        }
        return cell
    }
}

extension NSDate
{
    static func updateCountdownWithGoal(date: NSDate) -> [[String: Int]]
    {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd"
        let startingDate = NSDate()
        let endingDate = date
        
        let calendar = NSCalendar.currentCalendar()
        let unitFlags: NSCalendarUnit = [.Year, .Month, .Day, .Hour, .Minute, .Second]
        let dateComponents: NSDateComponents = calendar.components(unitFlags, fromDate: startingDate, toDate: endingDate, options: [])
        let years = dateComponents.year
        let months = dateComponents.month
        let days = dateComponents.day
        let hours = dateComponents.hour
        let minutes = dateComponents.minute
        let seconds = dateComponents.second
        
        print("\(years) YEARS - \(months) MONTHS - \(days) DAYS - \(hours) HOURS - \(minutes) MINUTES - \(seconds) SECONDS")
        
        if years > 0 {
            return [["Years": years], ["Months": months], ["Days": days]]
        }
        else if years == 0 && months > 0 {
            return [["Months": months], ["Days": days], ["Hours": hours]]
        }
        else if years == 0 && months == 0 && days > 0 {
            return [["Days": days], ["Hours":  hours], ["Minutes": minutes]]
        }
        else {
            return [["Hours": hours], ["Minutes": minutes], ["Seconds": seconds]]
        }
    }
}

extension String
{
    static func shortDateForTableView(date: NSDate) -> [String]
    {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = NSDateFormatterStyle.LongStyle
        let timeFormatter = NSDateFormatter()
        timeFormatter.timeStyle = NSDateFormatterStyle.ShortStyle
        let dateString = dateFormatter.stringFromDate(date)
        let timeString = timeFormatter.stringFromDate(date)
        return [dateString, timeString]
    }
    
    static func shortDateForCollectionView(date: NSDate) -> String
    {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = NSDateFormatterStyle.LongStyle
        let timeFormatter = NSDateFormatter()
        timeFormatter.timeStyle = NSDateFormatterStyle.ShortStyle
        let dateString = dateFormatter.stringFromDate(date)
        return dateString
    }
}
