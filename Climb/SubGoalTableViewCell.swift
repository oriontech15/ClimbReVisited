//
//  SubGoalTableViewCell.swift
//  Climb
//
//  Created by Justin Smith on 2/9/16.
//  Copyright © 2016 Justin Smith. All rights reserved.
//

import UIKit

protocol UpdateSubGoalTextFieldDelegate
{
    func updateSubGoalTextField(subGoalCell: SubGoalTableViewCell)
}

class SubGoalTableViewCell: UITableViewCell, UITextFieldDelegate
{
    @IBOutlet weak var subGoalTitleTextField: UITextField!
    @IBOutlet weak var taskNumberLabel: UILabel!

    var titleTextFieldDelegate: UpdateSubGoalTextFieldDelegate?
    var taskNumber = 1
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //NewGoalViewController.subGoalDateDelegate = self
        subGoalTitleTextField.delegate = self
        
        subGoalTitleTextField.textColor = UIColor(red: 0.691, green: 0.976, blue: 1.000, alpha: 1.00)
        
        taskNumberLabel.layer.borderColor = UIColor(red: 0.110, green: 0.816, blue: 1.000, alpha: 1.00).CGColor
        taskNumberLabel.layer.borderWidth = 1
        taskNumberLabel.layer.cornerRadius = taskNumberLabel.frame.height / 2
        taskNumberLabel.layer.masksToBounds = true
        taskNumberLabel.text = "\(taskNumber)"
    }
    
    func textFieldDidEndEditing(textField: UITextField)
    {
        self.titleTextFieldDelegate?.updateSubGoalTextField(self)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool
    {
        self.titleTextFieldDelegate?.updateSubGoalTextField(self)
        textField.resignFirstResponder()
        return true
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
