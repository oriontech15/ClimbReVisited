//
//  GoalDescriptionTableViewCell.swift
//  Climb
//
//  Created by Justin Smith on 2/4/16.
//  Copyright © 2016 Justin Smith. All rights reserved.
//

import UIKit

class GoalDescriptionTableViewCell: UITableViewCell, UITextViewDelegate, DismissKeyBoard, GetGoalDescriptionDelegate {

    @IBOutlet weak var goalDescriptionTextView: UITextView!
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        
        NewGoalTableViewController.dismissKeyboardDelegate = self
        NewGoalTableViewController.getGoalDescriptionDelegate = self
        
        goalDescriptionTextView.delegate = self
        goalDescriptionTextView.text = "Enter Goal Description here"
        goalDescriptionTextView.textColor = UIColor(red: 0.689, green: 0.689, blue: 0.689, alpha: 0.50)
        goalDescriptionTextView.font = UIFont(name: "HelveticaNeue", size: 15)
        goalDescriptionTextView.layer.cornerRadius = 6
        goalDescriptionTextView.layer.masksToBounds = true
    }
    
    func textViewDidBeginEditing(textView: UITextView) {
        if textView.textColor == UIColor(red: 0.689, green: 0.689, blue: 0.689, alpha: 0.50) {
            textView.text = nil
            //lightblue
            textView.textColor = UIColor(red: 0.691, green: 0.976, blue: 1.000, alpha: 1.00)
            textView.font = UIFont(name: "HelveticaNeue", size: 17)
        }
    }
    
    func getGoalDescriptionText() -> String
    {
        return goalDescriptionTextView.text
    }
    
    func dismissKeyboardForDescription()
    {
        goalDescriptionTextView.resignFirstResponder()
    }
    
    func textViewDidEndEditing(textView: UITextView) {
        
        self.resignFirstResponder()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
