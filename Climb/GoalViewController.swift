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
    var currentGoal: Goal?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        if let goals = GoalController.allGoalsInContext(Stack.sharedStack.managedObjectContext)
        {
            for goal in goals
            {
                
                print("GOAL --> \n\(goal)\n\(goal.title)\n\(goal.date)\n\(goal.finished)\n")
                for task in goal.tasks!
                {
                    print("TASK --> \n\(task)\n")
                }
            }
        }
        
        self.title = "Goals"
        self.parentViewController?.tabBarItem.image = UIImage(named: "tabBarButtonMain")?.imageWithRenderingMode(.Automatic)
        self.parentViewController?.tabBarItem.selectedImage = UIImage(named: "tabBarButtonMain")?.imageWithRenderingMode(.AlwaysOriginal)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(animated: Bool)
    {
        if let goalCount = GoalController.allGoalsInContext(Stack.sharedStack.managedObjectContext)?.count
        {
            self.goalPageController.numberOfPages = goalCount
        }
        
        self.collectionView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension GoalViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout
{
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        if let goalCount = GoalController.allGoalsInContext(Stack.sharedStack.managedObjectContext)?.count
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
        
        if let goals = GoalController.allGoalsInContext(Stack.sharedStack.managedObjectContext)
        {
            let goal = goals[indexPath.row]
            cell.goalDateLabel.text = String.shortDateForCollectionView(goal.date!)
            cell.goalTitleLabel.text = goal.title!
            currentCell = indexPath.row
        }
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize
    {
        if let size = collectionView.superview?.bounds.size
        {
            print("SIZE -- \(size)")
            
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
        if let task = self.currentGoal?.tasks?[indexPath.row]
        {
            cell.taskTitleLabel.text = task.title
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
}







