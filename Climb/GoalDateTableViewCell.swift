//
//  SubGoalTableViewCell.swift
//  Climb
//
//  Created by Justin Smith on 2/4/16.
//  Copyright © 2016 Justin Smith. All rights reserved.
//

import UIKit

protocol PresentDateViewDelegate
{
    func presentView()
}

class SubGoalTableViewCell: UITableViewCell, UpdateSubGoalDateTextField {

    @IBOutlet weak var subGoalTextField: UITextField!
    @IBOutlet weak var calendarButton: UIButton!
    
    var delegate: PresentDateViewDelegate?
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        
        NewGoalViewController.subGoalDateDelegate = self
        
        subGoalTextField.textColor = UIColor(red: 0.691, green: 0.976, blue: 1.000, alpha: 1.00)
        
        configureDateButton()
    }
    
    func configureDateButton()
    {
        calendarButton.setImage(UIImage(named: "AddDateForGoalButton"), forState: .Normal)
        calendarButton.setImage(UIImage(named: "AddDateForGoalHighlightButton"), forState: .Highlighted)
    }

    @IBAction func addDateToSubGoalButtonTapped(sender: AnyObject)
    {
        self.delegate?.presentView()
    }
    
    func updateTextFieldWithDate(date: NSDate)
    {
        self.subGoalTextField.text = String.shortDateForCollectionView(date)
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
