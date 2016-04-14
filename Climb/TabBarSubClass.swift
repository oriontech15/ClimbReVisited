//
//  TabBarSubClass.swift
//  Climb
//
//  Created by Justin Smith on 2/2/16.
//  Copyright © 2016 Justin Smith. All rights reserved.
//

import UIKit

protocol UpdateNewGoalSwitch
{
    func updateNewGoalSwitchWithState(state: Bool)
}

class TabBarSubClass: UITabBarController //ToggleNewGoalButton
{
    var holdTimer = NSTimer()
    var timeCount = NSTimeInterval()
    var addGoalButton = UIButton()
    var buttonImage = UIImage(named: "SmallAddSubGoalButtonCircle")
    var highlightImage = UIImage(named: "SmallAddSubGoalHighlightButtonCircle")
    
    static var switchStateDelegate: UpdateNewGoalSwitch?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        //addCenterButtonAndTabBarLines()
        
        //ProfileViewController.delegate = self

        // Do any additional setup after loading the view.
    }
    
//    func addCenterButtonAndTabBarLines()
//    {
//        addGoalButton = UIButton(type: .Custom)
//        
//        //let topTabBarView = UIView(frame: CGRectMake(0.0, 0.0, self.tabBar.frame.size.width, 2))
//        //topTabBarView.backgroundColor = .lightGrayColor()
//        
//        if let buttonImage = buttonImage
//        {
//            addGoalButton.frame = CGRectMake(0.0, 0.0, buttonImage.size.width, buttonImage.size.height)
//            addGoalButton.setBackgroundImage(buttonImage, forState: .Normal)
//            addGoalButton.setBackgroundImage(highlightImage, forState: .Highlighted)
//            
//            let heightDifference = buttonImage.size.height - self.tabBar.frame.size.height
//            print(heightDifference)
//            let buttonCenter = CGPoint(x: self.tabBar.center.x + ((self.view.frame.size.width / 2) - 35), y: self.tabBar.center.y - 60)
//            //let viewCenter = CGPoint(x: self.tabBar.center.x, y: self.tabBar.center.y - 26)
//            addGoalButton.center = buttonCenter
//            //topTabBarView.center = viewCenter
//        }
//        
//        let blueLine1 = UIView(frame: CGRectMake(self.tabBar.center.x - 63, self.tabBar.frame.origin.y + 5, 1, self.tabBar.frame.height - 10))
//        let blueLine2 = UIView(frame: CGRectMake(self.tabBar.center.x + 63, self.tabBar.frame.origin.y + 5, 1, self.tabBar.frame.height - 10))
//        
//        blueLine1.backgroundColor = UIColor(red: 0.110, green: 0.816, blue: 1.000, alpha: 1.00)
//        blueLine2.backgroundColor = UIColor(red: 0.110, green: 0.816, blue: 1.000, alpha: 1.00)
//        
//        self.view.addSubview(blueLine1)
//        self.view.addSubview(blueLine2)
//        self.view.addSubview(addGoalButton)
//        //self.view.addSubview(topTabBarView)
//        
//        addGoalButton.addTarget(self, action: "holdRelease", forControlEvents: .TouchUpInside)
//        addGoalButton.addTarget(self, action: "heldDown", forControlEvents: .TouchDown)
//    }
//
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//    
//    func toggleNewGoalButton()
//    {
//        if addGoalButton.hidden == false
//        {
//            hideShowNewGoalButton()
//        }
//        else
//        {
//            hideShowNewGoalButton()
//        }
//    }
//    
//    //target functions
//    func heldDown()
//    {
//        print("hold down")
//        timeCount = 0
//        holdTimer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: "timeCountUp", userInfo: nil, repeats: true)
//    }
//    
//    func timeCountUp()
//    {
//        timeCount++
//        if timeCount == 2
//        {
//            holdTimer.invalidate()
//            
//            let holdAlert = UIAlertController(title: "New  Goal Button Held", message: "Would you like to hide this button?", preferredStyle: .Alert)
//            
//            let holdActionYes = UIAlertAction(title: "Yes", style: .Default, handler: { (_) -> Void in
//                self.toggleNewGoalButton()
//            })
//            
//            let holdActionNo = UIAlertAction(title: "No", style: .Cancel, handler: nil)
//            
//            holdAlert.addAction(holdActionYes)
//            holdAlert.addAction(holdActionNo)
//            
//            self.presentViewController(holdAlert, animated: true, completion: nil)
//        }
//    }
//    
//    func holdRelease()
//    {
//        holdTimer.invalidate()
//        self.performSegueWithIdentifier("AddGoalSegue", sender: nil)
//        print("YOU TAPPED THE BUTTON")
//        print("hold release")
//    }
//    
//    func hideShowNewGoalButton()
//    {
//        if addGoalButton.hidden == false
//        {
//            UIView.animateWithDuration(0.7, animations: { () -> Void in
//                self.addGoalButton.alpha = 0
//                TabBarSubClass.switchStateDelegate?.updateNewGoalSwitchWithState(false)
//                }, completion: { (_) -> Void in
//                    self.addGoalButton.hidden = true
//            })
//        }
//        else
//        {
//            UIView.animateWithDuration(0.7, animations: { () -> Void in
//                self.addGoalButton.hidden = false
//                TabBarSubClass.switchStateDelegate?.updateNewGoalSwitchWithState(true)
//                self.addGoalButton.alpha = 1.0
//                }, completion: { (_) -> Void in
//            })
//        }
//        
//    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
