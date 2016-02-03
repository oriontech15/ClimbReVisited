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
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
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
            cell.goalTitleLabel.text = goal.title
            cell.goalDateLabel.text = String.shortDateForCollectionView(goal.date!)
//            cell.layer.borderColor = UIColor(red: 0.110, green: 0.816, blue: 1.000, alpha: 1.00).CGColor
//            cell.layer.borderWidth = 3
//            cell.layer.masksToBounds = true
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
