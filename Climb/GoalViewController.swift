//
//  ViewController.swift
//  Climb
//
//  Created by Justin Smith on 2/2/16.
//  Copyright © 2016 Justin Smith. All rights reserved.
//

import UIKit

class GoalViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var goalPageController: UIPageControl!
    
    var currentCell = 0
    var percentageLabel = UILabel()
    var presented = false
    var pastDue = false
    
    weak var currentGoal: Goal? {
        didSet
        {
            if currentGoal?.finished == false
            {
                if pastDue == false
                {
                    GoalController.timer.invalidate()
                    GoalController.timer = NSTimer.scheduledTimerWithTimeInterval(NSTimeInterval(1.0), target: self, selector: #selector(updateCountDown), userInfo: nil, repeats: true)
                }
                else
                {
                    GoalController.timer.invalidate()
                }
            }
        }
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.title = "Goals"
        self.parentViewController?.tabBarItem.image = UIImage(named: "tabBarButtonMain")?.imageWithRenderingMode(.Automatic)
        self.parentViewController?.tabBarItem.selectedImage = UIImage(named: "tabBarButtonMain")?.imageWithRenderingMode(.AlwaysOriginal)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(animated: Bool)
    {
        if let goalCount = GoalController.unfinishedGoalsInContext(Stack.sharedStack.managedObjectContext)?.count
        {
            self.goalPageController.numberOfPages = goalCount
        }
        self.collectionView.reloadData()
    }
    
    
    @IBAction func newGoalButtonTapped(sender: AnyObject)
    {
        self.performSegueWithIdentifier("AddGoalSegue", sender: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateCountDown()
    {
        NSNotificationCenter.defaultCenter().postNotificationName("updateTimerLabels", object: nil)
        self.collectionView.reloadData()
    }
    
    func updatePercentageLabel() -> String
    {
        var percentString = ""
        
        if let currentGoal = currentGoal, allTasks = TaskController.allTasksForGoal(currentGoal),
            finishedTasks = TaskController.finishedTasksForGoal(currentGoal)
        {
            let allCount = allTasks.count
            let finishedCount = finishedTasks.count
            
            let percent = 100 * (Float(finishedCount) / Float(allCount))
            print("\(Int(percent))%")
            percentString = "\(Int(percent))%"
            
        }
        return percentString
    }
    
    @IBAction func finishedButtonTapped(sender: UIBarButtonItem)
    {
        if sender.tag == 1
        {
            if let title = currentGoal?.title
            {
                let text = "Would you like to mark this goal as finished?"
                presentFinishedAlert(title, alertText: text, presented: false)
            }
        }
    }
    
    func presentFinishedAlert(goalName: String, alertText: String, presented: Bool)
    {
        let finishedAlert = UIAlertController(title: goalName, message: alertText, preferredStyle: .Alert)
        let finishAction = UIAlertAction(title: "Yes", style: .Default) { (_) -> Void in
            print("Finished Tapped")
            self.currentGoal?.finished = true
            GoalController.saveGoalInContext(Stack.sharedStack.managedObjectContext)
            if let goalCount = GoalController.unfinishedGoalsInContext(Stack.sharedStack.managedObjectContext)?.count
            {
                self.goalPageController.numberOfPages = goalCount
                self.collectionView.reloadData()
            }
            
        }
        let cancelAction = UIAlertAction(title: "No", style: .Cancel) { (_) -> Void in
            GoalController.timer = NSTimer.scheduledTimerWithTimeInterval(NSTimeInterval(1.0), target: self, selector: #selector(self.updateCountDown), userInfo: nil, repeats: true)
            
            self.currentGoal?.finished = false
            GoalController.saveGoalInContext(Stack.sharedStack.managedObjectContext)
        }
        finishedAlert.addAction(finishAction)
        finishedAlert.addAction(cancelAction)
        self.presentViewController(finishedAlert, animated: true) { () -> Void in
            GoalController.timer.invalidate()
            self.presented = presented
        }
    }
}

extension GoalViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout
{
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        if let goalCount = GoalController.unfinishedGoalsInContext(Stack.sharedStack.managedObjectContext)?.count
        {
            return goalCount
        }
        else
        {
            print("There are no goals at this time")
            return 0
        }
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("goalCell", forIndexPath: indexPath) as! MainViewGoalCollectionViewCell
        
        if let goals = GoalController.unfinishedGoalsInContext(Stack.sharedStack.managedObjectContext)
        {
            self.currentGoal = goals[indexPath.row]
            if let currentGoal = currentGoal
            {
                    pastDue = cell.goalPastDue
                    cell.goalDateLabel.text = String.shortDateForCollectionView(currentGoal.date!)
                    
                    cell.goalDate = currentGoal.date!
                    
                    cell.goalTitleLabel.text = currentGoal.title!
                    currentCell = indexPath.row
                    cell.tasksTableView.reloadData()
            }
        }
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize
    {
        if let size = collectionView.superview?.bounds.size
        {
            let cellSize = CGSize(width: size.width, height: size.height - 50)
            return cellSize
        }
        else
        {
            return CGSize(width: 150, height: 500)
        }
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat
    {
        return 0
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView)
    {
        let pageWidth = self.collectionView.frame.size.width
        self.goalPageController.currentPage = Int(self.collectionView.contentOffset.x / pageWidth)
    }
}

extension GoalViewController: UITableViewDataSource, UITableViewDelegate
{
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let taskCount = currentGoal?.tasks?.count
        {
            return taskCount
        }
        else
        {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("taskCell", forIndexPath: indexPath) as! MainViewTasksTableViewCell
        if let task = self.currentGoal?.tasks?[indexPath.row] as? Task
        {
            cell.task = task
            cell.update()
            cell.taskTitleLabel.text = task.title
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
}







