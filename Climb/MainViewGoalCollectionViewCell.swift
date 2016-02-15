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
    
    override func awakeFromNib()
    {
        timerBackgroundImageView.layer.borderWidth = 1
        timerBackgroundImageView.layer.borderColor = UIColor.lightGrayColor().CGColor
        timerBackgroundImageView.layer.cornerRadius = 12
        timerBackgroundImageView.layer.masksToBounds = true
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
    
    func addShadowProperties(label: UILabel)
    {
        label.layer.shadowOffset = CGSize(width: 0, height: 18)
        label.layer.shadowOpacity = 0.4
        label.layer.shadowRadius = 3
    }
    
}
