//
//  AddGoalTableViewController.swift
//  Climb
//
//  Created by Justin Smith on 2/2/16.
//  Copyright © 2016 Justin Smith. All rights reserved.
//

import UIKit
import CoreData

protocol UpdateGoalDateTextField
{
    func updateTextFieldWithDate(date: NSDate)
}

protocol DismissKeyBoard
{
    func dismissKeyboardForDescription()
}

protocol GetGoalDescriptionDelegate
{
    func getGoalDescriptionText() -> String
}

class NewGoalTableViewController: UITableViewController, SetDateViewDelegate, UpdateActiveTextFieldDelegate
{
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBOutlet weak var goalTitleTextField: UITextField!
    @IBOutlet weak var goalTitleLabel: UILabel!
    @IBOutlet weak var goalSaveButton: UIButton!
    //@IBOutlet weak var saveBarButtonItem: UIBarButtonItem!
    
    var blurredBackdropView = UIVisualEffectView()
    var goalDatePickerView = UIDatePicker()
    var subGoalDatePickerView = UIDatePicker()
    var setDateButton = UIButton()
    
    var subGoalsArray: [Int] = []
    var arrayCount = 0
    var taskHeight = 47
    
    var goal: Goal?
    
    var activeText: UITextField?
    var currentOffset: CGFloat = 0
    
    static var goalDateDelegate: UpdateGoalDateTextField?
    static var dismissKeyboardDelegate: DismissKeyBoard?
    static var getGoalDescriptionDelegate: GetGoalDescriptionDelegate?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        print(self.goal)
        
        self.goal = GoalController.insertGoalIntoContext(Stack.sharedStack.managedObjectContext)
        print("Goal \(self.goal) ^ CREATED ^")
        
        setRightBarButtonItemToSave()
        
        let touchAction = UITapGestureRecognizer(target: self, action: #selector(endEditing))
        view.addGestureRecognizer(touchAction)
        
        goalDatePickerView.date = NSDate()
        
        goalTitleTextField.textColor = UIColor(red: 0.691, green: 0.976, blue: 1.000, alpha: 1.00)
        goalTitleTextField.delegate = self
        goalSaveButton.layer.cornerRadius = 6
        goalSaveButton.layer.masksToBounds = true
    }
    
    override func viewWillAppear(animated: Bool) {
        self.tableView.keyboardDismissMode = UIScrollViewKeyboardDismissMode.OnDrag
        self.tableView.backgroundView = UIImageView(image: UIImage(named: "wallpaper"))
    }
    
    func updateActiveText(textField: UITextField)
    {
        currentOffset = self.tableView.contentOffset.y
        let cell = textField.superview?.superview as! SubGoalTableViewCell
        let point = cell.frame.origin
        self.tableView.setContentOffset(CGPointMake(0, point.y - 250), animated: true)
    }
    
    func endEditing()
    {
        self.view.endEditing(true)
    }
    
    @IBAction func saveGoalButtonTapped()
    {
        checkGoal()
    }
    
    func checkGoal()
    {
        if let goalDescriptionText = NewGoalTableViewController.getGoalDescriptionDelegate?.getGoalDescriptionText()
        {
            if goalTitleTextField.text == "" || goalTitleTextField.text == " "
            {
                let noGoalTitleAlert = UIAlertController(title: "No Goal Title", message: "Please enter a title for your goal", preferredStyle: .Alert)
                let okayAction = UIAlertAction(title: "Okay", style: .Cancel, handler: nil)
                
                noGoalTitleAlert.addAction(okayAction)
                
                self.presentViewController(noGoalTitleAlert, animated: true, completion: nil)
            }
            else if goalDescriptionText == "" || goalDescriptionText == "Enter Goal Description here"
            {
                let noGoalTitleAlert = UIAlertController(title: "No Description", message: "Would you like to save the goal without a description?", preferredStyle: .Alert)
                let noAction = UIAlertAction(title: "No", style: .Cancel, handler: nil)
                let yesAction = UIAlertAction(title: "Yes", style: .Default, handler: { (_) -> Void in
                    if let goal = self.goal
                    {
                        if let tasks = goal.tasks
                        {
                            for task in tasks
                            {
                                let aTask = task as! Task
                                if aTask.title == nil || aTask.title == " " || aTask.title == ""
                                {
                                    let noGoalTitleAlert = UIAlertController(title: "Task Empty", message: "A Task is empty. Please delete the task before saving", preferredStyle: .Alert)
                                    let okayAction = UIAlertAction(title: "Okay", style: .Cancel, handler: nil)
                                    
                                    noGoalTitleAlert.addAction(okayAction)
                                    
                                    self.presentViewController(noGoalTitleAlert, animated: true, completion: nil)
                                }
                            }
                        }
                        self.saveGoal()
                    }
                })
                
                noGoalTitleAlert.addAction(yesAction)
                noGoalTitleAlert.addAction(noAction)
                
                self.presentViewController(noGoalTitleAlert, animated: true, completion: nil)
            }
            else
            {
                if let goal = self.goal
                {
                    if let tasks = goal.tasks
                    {
                        for task in tasks
                        {
                            if task.title == "" || task.title == " "
                            {
                                goal.managedObjectContext?.deleteObject(task as! NSManagedObject)
                                saveGoal()
                            }
                        }
                    }
                }
                saveGoal()
            }
        }
    }
    
    func saveGoal()
    {
        if let goal = self.goal
        {
            goal.title = self.goalTitleTextField.text
            print(goal.title)
            if goal.title?.characters.first == " "
            {
                let newTitle = goal.title?.stringByTrimmingCharactersInSet(NSCharacterSet(charactersInString: " "))
                goal.title = newTitle
                print(goal.title)
            }
            
            goal.date = self.goalDatePickerView.date
            self.tableView.endEditing(true)
            self.view.endEditing(true)
            AddSubGoalTableViewCell().endEditing(true)
            GoalController.saveGoalInContext(Stack.sharedStack.managedObjectContext)
            self.dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
    @IBAction func cancelButtonTapped()
    {
        if let goal = self.goal
        {
            GoalController.removeGoalFromContext(goal, context: Stack.sharedStack.managedObjectContext)
            
            print("Goal \(self.goal) ^ DELETED ^")
            
            self.dismissViewControllerAnimated(true, completion: nil)
        }
        else
        {
            print("DID NOT CREATE GOAL")
        }
    }
    
    func setRightBarButtonItemToSave()
    {
        let saveButton = UIBarButtonItem(title: "Save", style: .Done, target: self, action: #selector(checkGoal))
        self.navigationItem.setRightBarButtonItem(saveButton, animated: true)
        self.navigationItem.rightBarButtonItem?.tintColor = UIColor(red: 0.110, green: 0.816, blue: 1.000, alpha: 1.00)
        self.navigationItem.leftBarButtonItem?.enabled = true
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor(red: 0.110, green: 0.816, blue: 1.000, alpha: 1.00)
    }
    
    func setDateForGoal()
    {
        presentGoalDateView()
        setDateButton.addTarget(self, action: #selector(addDateToGoal), forControlEvents: .TouchUpInside)
        
    }
    
    func presentGoalDateView()
    {
        let doneButton = UIBarButtonItem(title: "Done", style: .Done, target: self, action: #selector(addDateToGoal))
        self.navigationItem.setRightBarButtonItem(doneButton, animated: true)
        self.navigationItem.rightBarButtonItem?.tintColor = UIColor(red: 0.110, green: 0.816, blue: 1.000, alpha: 1.00)
        self.navigationItem.leftBarButtonItem?.enabled = false
        self.navigationItem.leftBarButtonItem?.tintColor = .darkGrayColor()
        
        NewGoalTableViewController.dismissKeyboardDelegate?.dismissKeyboardForDescription()
        
        let datePicker = UIDatePicker()
        datePicker.minimumDate = NSDate()
        datePicker.datePickerMode = UIDatePickerMode.DateAndTime
        datePicker.center = self.view.center //CGPoint(x: self.view.center.x, y: self.view.center.y - 100)
        datePicker.layer.borderWidth = 1
        datePicker.layer.borderColor = UIColor(red: 0.110, green: 0.816, blue: 1.000, alpha: 1.00).CGColor
        datePicker.layer.cornerRadius = 14
        datePicker.layer.masksToBounds = true
        datePicker.setValue(UIColor(red: 0.110, green: 0.816, blue: 1.000, alpha: 1.00), forKey: "textColor")
        
        let setDateButton = UIButton(frame: CGRectMake(0, 0, datePicker.frame.width, 50))
        setDateButton.center = CGPoint(x: self.view.center.x, y: self.view.center.y + 145)
        setDateButton.layer.cornerRadius = 14
        setDateButton.backgroundColor = UIColor(red: 0.110, green: 0.816, blue: 1.000, alpha: 1.00)
        setDateButton.setTitle("Set Date", forState: .Normal)
        setDateButton.titleLabel?.font = UIFont(name: "HelveticaNeue-Bold", size: 17)
        setDateButton.setTitleColor(UIColor.darkGrayColor(), forState: .Normal)
        
        datePicker.alpha = 0.0
        setDateButton.alpha = 0.0
        
        self.goalDatePickerView = datePicker
        self.setDateButton = setDateButton
        
        self.view.addSubview(datePicker)
        self.view.addSubview(setDateButton)
        let blurredView = addBlurredBackgroundViewToView()
        self.view.bringSubviewToFront(blurredBackdropView)
        self.view.bringSubviewToFront(datePicker)
        self.view.bringSubviewToFront(setDateButton)
        
        UIView.animateWithDuration(0.5) { () -> Void in
            datePicker.alpha = 1.0
            setDateButton.alpha = 1.0
            blurredView.alpha = 1.0
            self.goalSaveButton.alpha = 0.0
        }
    }
    
    func addDateToGoal()
    {
        //Code for setting the date on the goal
        removeGoalDateViews()
        NewGoalTableViewController.goalDateDelegate?.updateTextFieldWithDate(goalDatePickerView.date)
    }
    
    func removeGoalDateViews()
    {
        //Animates the removal of the Date Picker View
        self.setRightBarButtonItemToSave()
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            self.goalDatePickerView.alpha = 0.0
            self.setDateButton.alpha = 0.0
            self.blurredBackdropView.alpha = 0.0
            self.goalSaveButton.alpha = 1.0
        }) { (_) -> Void in
            self.goalDatePickerView.removeFromSuperview()
            self.setDateButton.removeFromSuperview()
            self.blurredBackdropView.removeFromSuperview()
            self.tableView.reloadData()
        }
    }
    
    //Adds a VisualEffectView to the Date Picker View
    func addBlurredBackgroundViewToView() -> UIVisualEffectView
    {
        let blurEffect = UIBlurEffect(style: .Dark)
        let blurredBackdropView = UIVisualEffectView(effect: blurEffect)
        
        blurredBackdropView.autoresizingMask = [UIViewAutoresizing.FlexibleHeight, UIViewAutoresizing.FlexibleWidth]
        blurredBackdropView.frame = self.view.bounds
        self.view.addSubview(blurredBackdropView)
        blurredBackdropView.alpha = 0.0
        self.blurredBackdropView = blurredBackdropView
        return blurredBackdropView
    }
}

/******************************/
/* TextField Delegate Methods */
/******************************/

extension NewGoalTableViewController: UITextFieldDelegate
{
    func textFieldDidEndEditing(textField: UITextField)
    {
        textField.resignFirstResponder()
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()
        return true
    }
}

/******************************/
/* SUBGOAL DELEGATE FUNCTIONS */
/******************************/

extension NewGoalTableViewController: AddSubGoalDelegate, UpdateSubGoalTextFieldDelegate
{
    func addSubGoal()
    {
        if let goal = self.goal
        {
            let subGoal = TaskController.insertTaskIntoContext(goal.managedObjectContext!)
            subGoal.goal = goal
            
            if let tasksCount = goal.tasks?.count
            {
                CATransaction.begin()
                CATransaction.setCompletionBlock
                    {
                        self.tableView.reloadData()
                }
                tableView.beginUpdates()
                tableView.insertRowsAtIndexPaths([NSIndexPath(forRow: tasksCount - 1, inSection: 1)], withRowAnimation: UITableViewRowAnimation.Middle)
                tableView.endUpdates()
                CATransaction.commit()
            }
        }
        
    }
    
    func updateSubGoalTextField(subGoalCell: SubGoalTableViewCell)
    {
        if let indexPath = self.tableView.indexPathForCell(subGoalCell)
        {
            if let task = self.goal?.tasks?[indexPath.row] as? Task
            {
                task.title = subGoalCell.subGoalTitleTextField.text
                subGoalCell.subGoalTitleTextField.resignFirstResponder()
                self.tableView.setContentOffset(CGPointMake(0, currentOffset), animated: true)
            }
        }
    }
}


/**************************/
/** TABLEVIEW DATASOURCE **/
/**************************/

extension NewGoalTableViewController
{
    // MARK: - Table view data source
    
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 0
        {
            return 18
        }
        else
        {
            return 0
        }
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0
        {
            return 0
        }
        else if section == 2
        {
            return 0
        }
        else
        {
            return 30
        }
    }
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        if section == 0
        {
            return UIView()
        }
        else if section == 2
        {
            return UIView()
        }
        else
        {
            let label = UILabel(frame: CGRectMake(40, 0, self.view.frame.width, 30))
            if let goal = self.goal
            {
                if let tasksCount = goal.tasks?.count
                {
                    if tasksCount == 0
                    {
                        label.text = ""
                    }
                    else if tasksCount == 1
                    {
                        label.text = "Task"
                    }
                    else
                    {
                        label.text = "Tasks"
                    }
                }
            }
            label.font = UIFont(name: "HelveticaNeue-Medium", size: 22)
            label.textAlignment = .Center
            label.textColor = UIColor(red: 0.110, green: 0.816, blue: 1.000, alpha: 1.00)
            return label
        }
    }
    
    override func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if section == 0
        {
            return UIView(frame: CGRectMake(0, 0, self.view.frame.width, 18))
        }
        else
        {
            return UIView()
        }
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 3
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        switch section
        {
        case 0:
            return 2
        case 2:
            return 1
        default:
            if let goal = self.goal
            {
                if let subGoalCount = goal.tasks?.count
                {
                    print(subGoalCount)
                    return subGoalCount
                }
                else
                {
                    return 0
                }
            }
            else
            {
                return 0
            }
            //return 1 + subGoalsArray.count
        }
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        switch indexPath.section
        {
        case 0:
            switch indexPath.row
            {
            case 0:
                return 65
            case 1:
                return 141
            default:
                return 85
            }
        case 1:
            return CGFloat(taskHeight)
        case 2:
            return 55
        default:
            return 45
        }
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        switch indexPath.section
        {
        case 1:
            return true
        default:
            return false
        }
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete
        {
            if let goal = self.goal
            {
                if let tasks = goal.tasks
                {
                    CATransaction.begin()
                    CATransaction.setCompletionBlock
                        {
                            tableView.reloadData()
                    }
                    tableView.beginUpdates()
                    let task = tasks[indexPath.row] as! Task
                    TaskController.removeTask(task, context: goal.managedObjectContext!)
                    GoalController.saveGoalInContext(Stack.sharedStack.managedObjectContext)
                    tableView.deleteRowsAtIndexPaths([NSIndexPath(forRow: indexPath.row, inSection: 1)], withRowAnimation: .Middle)
                    tableView.endUpdates()
                    CATransaction.commit()
                }
            }
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        switch indexPath.section
        {
        case 0:
            switch indexPath.row
            {
            case 0:
                let cell = tableView.dequeueReusableCellWithIdentifier("goalDateCell", forIndexPath: indexPath) as! GoalDateTableViewCell
                cell.delegate = self
                cell.goalDateTextField.text = String.shortDateForCollectionView(goalDatePickerView.date)
                cell.backgroundColor = .clearColor()
                return cell
            case 1:
                let cell = tableView.dequeueReusableCellWithIdentifier("goalDescriptionCell", forIndexPath: indexPath) as! GoalDescriptionTableViewCell
                cell.backgroundColor = .clearColor()
                return cell
            default:
                let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)
                return cell
            }
        case 1:
            let cell = tableView.dequeueReusableCellWithIdentifier("subGoalCell", forIndexPath: indexPath) as! SubGoalTableViewCell
            cell.titleTextFieldDelegate = self
            cell.activeTextFieldDelegate = self
            cell.taskNumberLabel.text = "\(indexPath.row + 1)"
            cell.backgroundColor = .clearColor()
            return cell
        case 2:
            let cell = tableView.dequeueReusableCellWithIdentifier("addSubGoalCell", forIndexPath: indexPath) as! AddSubGoalTableViewCell
            cell.delegate = self
            cell.backgroundColor = .clearColor()
            return cell
        default:
            let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)
            return cell
        }
    }
    
    
}
