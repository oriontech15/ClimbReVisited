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
    var headerNumGoalsLabel = UILabel()
    
    var currentGoalsCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Your Goals"
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
        if let goalCount = GoalController.allGoalsInContext(Stack.sharedStack.managedObjectContext)?.count
        {
            if goalCount > 0
            {
                return 2
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
        if let goalCount = GoalController.allGoalsInContext(Stack.sharedStack.managedObjectContext)?.count
        {
            self.currentGoalsCount = goalCount
            return goalCount
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
            if let goals = GoalController.allGoalsInContext(Stack.sharedStack.managedObjectContext)
            {
                if indexPath.section == 0
                {
                    if goals.count == 1
                    {
                        print(goals)
                        print(indexPath.row)
                        print(goals[indexPath.row])
                        let deleted = GoalController.removeGoalFromContext(goals[indexPath.row], context: Stack.sharedStack.managedObjectContext)
                        GoalController.saveGoalInContext(Stack.sharedStack.managedObjectContext)
                        print(deleted)
                        tableView.deleteSections(NSIndexSet(index: indexPath.section), withRowAnimation: .Fade)
                        headerNumGoalsLabel.text = "\(currentGoalsCount)"
                    }
                    else
                    {
                        print(goals)
                        print(indexPath.row)
                        print(goals[indexPath.row])
                        let deleted = GoalController.removeGoalFromContext(goals[indexPath.row], context: Stack.sharedStack.managedObjectContext)
                        GoalController.saveGoalInContext(Stack.sharedStack.managedObjectContext)
                        print(deleted)
                        tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
                        headerNumGoalsLabel.text = "\(currentGoalsCount)"
                    }
                }
            }
        }
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        let headerView = HeaderForGoalList(frame: CGRectMake(0, 0, self.view.frame.width, 85))
        
        if section == 0
        {
            headerView.lineColor = UIColor(red: 1.000, green: 0.914, blue: 0.290, alpha: 1.00)

            headerLabel = UILabel(frame: CGRectMake(0, 0, self.view.frame.width, 35))
            headerLabel.text = "Current Goals"
            headerLabel.textAlignment = .Center
            headerLabel.font = UIFont(name: "HelveticaNeue-Medium", size: 22)
            headerLabel.textColor = .lightGrayColor()
            headerLabel.textColor = UIColor(red: 1.000, green: 0.914, blue: 0.290, alpha: 1.00)
            
            headerNumGoalsLabel = UILabel(frame: CGRectMake(0, headerLabel.frame.origin.y + 42, self.view.frame.width, 50))
            headerNumGoalsLabel.text = "\(currentGoalsCount)"
            headerNumGoalsLabel.textAlignment = .Center
            headerNumGoalsLabel.font = UIFont(name: "HelveticaNeue-Medium", size: 30)
            headerNumGoalsLabel.textColor = UIColor(red: 1.000, green: 0.914, blue: 0.290, alpha: 1.00)
            headerView.backgroundColor = .clearColor()
            
            headerView.addSubview(headerLabel)

            headerView.addSubview(headerNumGoalsLabel)
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
            
            headerNumGoalsLabel = UILabel(frame: CGRectMake(0, headerLabel.frame.origin.y + 42, self.view.frame.width, 50))
            headerNumGoalsLabel.text = "\(currentGoalsCount)"
            headerNumGoalsLabel.textAlignment = .Center
            headerNumGoalsLabel.font = UIFont(name: "HelveticaNeue-Medium", size: 30)
            headerNumGoalsLabel.textColor = UIColor(red: 0.110, green: 0.816, blue: 1.000, alpha: 1.00)
            
            headerView.backgroundColor = .clearColor()
            
            headerView.addSubview(headerLabel)
            headerView.addSubview(headerNumGoalsLabel)
        }
        
        return headerView
    }
    
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView?
    {
        let view = UIView(frame: CGRectMake(0, 0, self.view.frame.size.width, 8))
        let seperatorView = UIView(frame: CGRectMake(0, 0, self.view.frame.size.width, 2))
        
        if section == 0
        {
            seperatorView.backgroundColor = UIColor(red: 1.000, green: 0.914, blue: 0.290, alpha: 1.00)
        }
        else
        {
            seperatorView.backgroundColor = UIColor(red: 0.110, green: 0.816, blue: 1.000, alpha: 1.00)
        }
        
        view.addSubview(seperatorView)
        return view
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("goalListCell", forIndexPath: indexPath)
        
        if let goals = GoalController.allGoalsInContext(Stack.sharedStack.managedObjectContext)
        {
            switch indexPath.section
            {
            case 0:
                print("GOALS -- \(goals)")
                let goal = goals[indexPath.row]
                cell.textLabel!.text = goal.title
                cell.detailTextLabel!.text = String.shortDateForTableView(goal.date!)
                cell.textLabel!.textColor = UIColor(red: 1.000, green: 0.914, blue: 0.290, alpha: 1.00)
                cell.detailTextLabel!.textColor = UIColor(red: 1.000, green: 0.914, blue: 0.290, alpha: 1.00)
                
            case 1:
                print("GOALS -- \(goals)")
                let goal = goals[indexPath.row]
                cell.textLabel!.text = goal.title
                
                cell.detailTextLabel!.text = String.shortDateForTableView(goal.date!)
                cell.textLabel!.textColor = UIColor(red: 0.110, green: 0.816, blue: 1.000, alpha: 1.00)
                cell.detailTextLabel!.textColor = UIColor(red: 0.110, green: 0.816, blue: 1.000, alpha: 1.00)
                
            default:
                break
            }
        }
        return cell
    }
}

extension NSDate
{
    static func updateCountdownWithGoal(date: NSDate)
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
    }
}

extension String
{
    static func shortDateForTableView(date: NSDate) -> String
    {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = NSDateFormatterStyle.LongStyle
        let timeFormatter = NSDateFormatter()
        timeFormatter.timeStyle = NSDateFormatterStyle.ShortStyle
        let dateString = dateFormatter.stringFromDate(date)
        let timeString = timeFormatter.stringFromDate(date)
        return "\(dateString) \t\t\t\t\t\t\t  - \(timeString)"
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
