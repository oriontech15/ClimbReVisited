//
//  MainViewTasksTableViewCell.swift
//  Climb
//
//  Created by Justin Smith on 2/11/16.
//  Copyright © 2016 Justin Smith. All rights reserved.
//

import UIKit

class MainViewTasksTableViewCell: UITableViewCell {

    @IBOutlet weak var taskTitleLabel: UILabel!
    @IBOutlet weak var taskCompleteButton: UIButton!
    
    var complete = false
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        // Initialization code
        
        taskCompleteButton.setImage(UIImage(named: "GoalDoneCircleButtonUnSelected"), forState: .Normal)
        taskTitleLabel.textColor = UIColor(red: 1.000, green: 0.914, blue: 0.290, alpha: 1.00)
        taskTitleLabel.font = UIFont(name: "HelveticaNeue", size: 19)
        
    }

    @IBAction func taskCompleteButtonTapped(sender: AnyObject)
    {
        if !complete
        {
            taskCompleteButton.setImage(UIImage(named: "GoalDoneCircleButtonSelected"), forState: .Normal)
            complete = true
        }
        else
        {
            taskCompleteButton.setImage(UIImage(named: "GoalDoneCircleButtonUnSelected"), forState: .Normal)
            complete = false
        }
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
