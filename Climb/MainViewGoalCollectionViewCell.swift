//
//  MainViewGoalCollectionViewCell.swift
//  Climb
//
//  Created by Justin Smith on 2/3/16.
//  Copyright © 2016 Justin Smith. All rights reserved.
//

import UIKit

class MainViewGoalCollectionViewCell: UICollectionViewCell
{
    @IBOutlet weak var goalTitleLabel: UILabel!
    @IBOutlet weak var goalDateLabel: UILabel!
    @IBOutlet weak var tasksLabel: UILabel!
    @IBOutlet weak var hoursLabel: UILabel!
    @IBOutlet weak var minutesLabel: UILabel!
    @IBOutlet weak var secondsLabel: UILabel!
    @IBOutlet weak var hLabel: UILabel!
    @IBOutlet weak var mLabel: UILabel!
    @IBOutlet weak var sLabel: UILabel!
    @IBOutlet weak var timerBackgroundImageView: UIImageView!
    @IBOutlet weak var tasksTableView: UITableView!
    @IBOutlet weak var taskPercentageLabel: UILabel!
    
    var goalDate = NSDate()
    var timerBackgroundViewOriginalHeight: CGFloat = 0.0
    let pastDueLabel = UILabel()
    var goalPastDue = false
    
    override func awakeFromNib()
    {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(updateTimeLabels), name: "updateTimerLabels", object: nil)

        timerBackgroundImageView.layer.borderWidth = 1
        timerBackgroundImageView.layer.borderColor = UIColor.lightGrayColor().CGColor
        timerBackgroundImageView.layer.cornerRadius = 12
        timerBackgroundImageView.layer.masksToBounds = true
        timerBackgroundViewOriginalHeight = timerBackgroundImageView.frame.height
//        addLayerProperties(hLabel)
//        addLayerProperties(mLabel)
//        addLayerProperties(sLabel)
        
        addShadowProperties(goalDateLabel)
        addShadowProperties(goalTitleLabel)
        addShadowProperties(tasksLabel)
        
        tasksTableView.reloadData()
    }
    
    func addLayerProperties(label: UILabel)
    {
        label.layer.borderColor = UIColor(red: 0.110, green: 0.816, blue: 1.000, alpha: 1.00).CGColor
        label.layer.borderWidth = 1
        label.layer.cornerRadius = label.frame.height / 2
        label.layer.masksToBounds = true
    }
    
    func updateTimeLabels()
    {
        let timeLeftArray = NSDate.updateCountdownWithGoal(goalDate)
        
        var keysArray: [String] = []
        for dictionary in timeLeftArray
        {
            for key in dictionary.keys
            {
                keysArray.append(key)
            }
        }
        
        print(keysArray)
        
        let keyOne = keysArray[0]
        let keyTwo = keysArray[1]
        let keyThree = keysArray[2]
        
        hLabel.text = keyOne
        mLabel.text = keyTwo
        sLabel.text = keyThree
        
        
        if keyOne == "Hours" && keyTwo == "Minutes" && keyThree == "Seconds"
        {
            if timeLeftArray[0][keyOne]! <= 0 && timeLeftArray[1][keyTwo] <= 0 && timeLeftArray[2][keyThree] <= 0
            {
                GoalController.timer.invalidate()
                UIView.animateKeyframesWithDuration(0.8, delay: 0, options: [], animations: { () -> Void in
                    self.timerBackgroundImageView.frame = CGRectMake(self.timerBackgroundImageView.frame.origin.x, self.timerBackgroundImageView.frame.origin.y, self.timerBackgroundImageView.frame.size.width, 0)
                    self.hLabel.hidden = true
                    self.mLabel.hidden = true
                    self.sLabel.hidden = true
                    self.hoursLabel.hidden = true
                    self.minutesLabel.hidden = true
                    self.secondsLabel.hidden = true
                    self.goalPastDue = true
                    }, completion: { (_) -> Void in
                        UIView.animateKeyframesWithDuration(0.8, delay: 0.0, options: [], animations: { () -> Void in
                            self.pastDueLabel.frame = CGRectMake(self.timerBackgroundImageView.frame.origin.x + 15, self.timerBackgroundImageView.frame.origin.y, self.timerBackgroundImageView.frame.width - 30, 70)
                            self.pastDueLabel.font = UIFont(name: "Helvetica-Bold", size: 40)
                            self.pastDueLabel.text = "Past Due"
                            self.pastDueLabel.textAlignment = .Center
                            self.pastDueLabel.layer.borderWidth = 3
                            self.pastDueLabel.layer.borderColor = UIColor(red: 0.110, green: 0.816, blue: 1.000, alpha: 1.00).CGColor
                            self.pastDueLabel.textColor = UIColor(red: 0.110, green: 0.816, blue: 1.000, alpha: 1.00)
                            self.pastDueLabel.alpha = 0.0
                            self.addSubview(self.pastDueLabel)
                            self.pastDueLabel.alpha = 1.0
                            }, completion: nil)
                })
            }
            else
            {
                self.timerBackgroundImageView.frame = CGRectMake(self.timerBackgroundImageView.frame.origin.x, self.timerBackgroundImageView.frame.origin.y, self.timerBackgroundImageView.frame.size.width, timerBackgroundViewOriginalHeight)
                self.hLabel.hidden = false
                self.mLabel.hidden = false
                self.sLabel.hidden = false
                self.hoursLabel.hidden = false
                self.minutesLabel.hidden = false
                self.secondsLabel.hidden = false
                self.goalPastDue = false
                self.pastDueLabel.removeFromSuperview()
                hoursLabel.text = "\(timeLeftArray[0][keyOne]!)"
                minutesLabel.text = "\(timeLeftArray[1][keyTwo]!)"
                secondsLabel.text = "\(timeLeftArray[2][keyThree]!)"
            }
        }
        else
        {
            self.timerBackgroundImageView.frame = CGRectMake(self.timerBackgroundImageView.frame.origin.x, self.timerBackgroundImageView.frame.origin.y, self.timerBackgroundImageView.frame.size.width, timerBackgroundViewOriginalHeight)
            self.hLabel.hidden = false
            self.mLabel.hidden = false
            self.sLabel.hidden = false
            self.hoursLabel.hidden = false
            self.minutesLabel.hidden = false
            self.secondsLabel.hidden = false
            self.goalPastDue = false
            self.pastDueLabel.removeFromSuperview()
            hoursLabel.text = "\(timeLeftArray[0][keyOne]!)"
            minutesLabel.text = "\(timeLeftArray[1][keyTwo]!)"
            secondsLabel.text = "\(timeLeftArray[2][keyThree]!)"
        }
        
        
    }
    
    func addShadowProperties(label: UILabel)
    {
        label.layer.shadowOffset = CGSize(width: 0, height: 18)
        label.layer.shadowOpacity = 0.4
        label.layer.shadowRadius = 3
    }    
}
