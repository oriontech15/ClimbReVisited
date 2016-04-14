//
//  MainViewTasksTableViewCell.swift
//  Climb
//
//  Created by Justin Smith on 2/11/16.
//  Copyright © 2016 Justin Smith. All rights reserved.
//

import UIKit

protocol UpdatedTaskCompletionDelegate
{
    
}

class MainViewTasksTableViewCell: UITableViewCell {

    @IBOutlet weak var taskTitleLabel: UILabel!
    @IBOutlet weak var taskCompleteButton: UIButton!
    
    var taskDelegate: UpdatedTaskCompletionDelegate?
    var currentGoal: Goal?
    var task: Task?
    var complete = false
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        // Initialization code
        
        taskCompleteButton.setImage(UIImage(named: "GoalDoneCircleButtonUnSelected"), forState: .Normal)
        taskTitleLabel.textColor = UIColor(red: 1.000, green: 0.914, blue: 0.290, alpha: 1.00)
        taskTitleLabel.font = UIFont(name: "HelveticaNeue", size: 19)
        
    }
    
    func update()
    {
        if let boolVal = task?.finished?.boolValue
        {
            complete = boolVal
            if complete
            {
                taskCompleteButton.setImage(UIImage(named: "GoalDoneCircleButtonSelected"), forState: .Normal)
            }
            else
            {
                taskCompleteButton.setImage(UIImage(named: "GoalDoneCircleButtonUnSelected"), forState: .Normal)
            }
        }
    }

    @IBAction func taskCompleteButtonTapped(sender: AnyObject)
    {
        if complete == false
        {
            taskCompleteButton.setImage(UIImage(named: "GoalDoneCircleButtonSelected"), forState: .Normal)
            complete = true
            if let task = task
            {
                task.finished = true
                GoalController.saveGoalInContext(Stack.sharedStack.managedObjectContext)
            }
        }
        else
        {
            taskCompleteButton.setImage(UIImage(named: "GoalDoneCircleButtonUnSelected"), forState: .Normal)
            complete = false
            if let task = task
            {
                task.finished = false
                GoalController.saveGoalInContext(Stack.sharedStack.managedObjectContext)
            }
        }
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
