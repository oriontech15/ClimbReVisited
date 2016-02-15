//
//  AddSubGoalTableViewCell.swift
//  Climb
//
//  Created by Justin Smith on 2/10/16.
//  Copyright © 2016 Justin Smith. All rights reserved.
//

import UIKit

protocol AddSubGoalDelegate
{
    func addSubGoal()
}

class AddSubGoalTableViewCell: UITableViewCell {

    @IBOutlet weak var addSubGoalButton: UIButton!
    
    var delegate: AddSubGoalDelegate?
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        addSubGoalButton.layer.cornerRadius = 8
        addSubGoalButton.layer.masksToBounds = true
    }

    @IBAction func addSubGoalButtonTapped(sender: AnyObject)
    {
        self.delegate?.addSubGoal()
    }
    
    override func setSelected(selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
