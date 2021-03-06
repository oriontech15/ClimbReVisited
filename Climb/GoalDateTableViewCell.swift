//
//  SubGoalTableViewCell.swift
//  Climb
//
//  Created by Justin Smith on 2/4/16.
//  Copyright © 2016 Justin Smith. All rights reserved.
//

import UIKit

protocol SetDateViewDelegate
{
    func setDateForGoal()
}

class GoalDateTableViewCell: UITableViewCell, UpdateGoalDateTextField {

    @IBOutlet weak var goalDateTextField: UITextField!
    @IBOutlet weak var calendarButton: UIButton!
    
    var delegate: SetDateViewDelegate?
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        
        NewGoalTableViewController.goalDateDelegate = self
        
        goalDateTextField.textColor = UIColor(red: 0.691, green: 0.976, blue: 1.000, alpha: 1.00)
        
        configureDateButton()
    }
    
    func configureDateButton()
    {
        calendarButton.setImage(UIImage(named: "AddDateForGoalButton"), forState: .Normal)
        calendarButton.setImage(UIImage(named: "AddDateForGoalHighlightButton"), forState: .Highlighted)
    }

    @IBAction func addDateToSubGoalButtonTapped(sender: AnyObject)
    {
        self.delegate?.setDateForGoal()
    }
    
    func updateTextFieldWithDate(date: NSDate)
    {
        self.goalDateTextField.text = String.shortDateForCollectionView(date)
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
