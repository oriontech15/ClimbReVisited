//
//  GoalListViewController.swift
//  Climb
//
//  Created by Justin Smith on 2/2/16.
//  Copyright © 2016 Justin Smith. All rights reserved.
//

import UIKit

class GoalListViewController: UIViewController
{
    @IBOutlet weak var tableView: UITableView!
    
    var currentGoalsCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

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
        return 50
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 2
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
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        let headerView = UIView(frame: CGRectMake(0, 0, self.view.frame.width, 50))
        let seperatorView = UIView(frame: CGRectMake(headerView.frame.origin.x, headerView.frame.height, headerView.frame.size.width, 2))
        
        if section == 0
        {
            let label = UILabel(frame: CGRectMake(0, 0, self.view.frame.width, 50))
            label.text = "Current Goals [\(currentGoalsCount)]"
            label.textAlignment = .Center
            label.font = UIFont(name: "HelveticaNeue", size: 18)
            label.textColor = .lightGrayColor()
            
            seperatorView.backgroundColor = UIColor(red: 1.000, green: 0.914, blue: 0.290, alpha: 1.00)
            
            headerView.addSubview(seperatorView)
            headerView.addSubview(label)
        }
        else
        {
            let label = UILabel(frame: CGRectMake(0, 0, self.view.frame.width, 50))
            label.text = "Finished Goals [\(currentGoalsCount)]"
            label.textAlignment = .Center
            label.font = UIFont(name: "HelveticaNeue", size: 18)
            label.textColor = .lightGrayColor()
            
            seperatorView.backgroundColor = UIColor(red: 0.110, green: 0.816, blue: 1.000, alpha: 1.00)
            
            headerView.addSubview(seperatorView)
            headerView.addSubview(label)
        }
        
        return headerView
    }
    
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView?
    {
        let seperatorView = UIView(frame: CGRectMake(0, 0, self.view.frame.size.width, 2))
        
        if section == 0
        {
            seperatorView.backgroundColor = UIColor(red: 1.000, green: 0.914, blue: 0.290, alpha: 1.00)
        }
        else
        {
            seperatorView.backgroundColor = UIColor(red: 0.110, green: 0.816, blue: 1.000, alpha: 1.00)
        }
        
        return seperatorView
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
