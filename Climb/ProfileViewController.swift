//
//  UserViewController.swift
//  Climb
//
//  Created by Justin Smith on 2/2/16.
//  Copyright © 2016 Justin Smith. All rights reserved.
//

import UIKit

protocol ToggleNewGoalButton
{
    func toggleNewGoalButton()
}

class ProfileViewController: UIViewController, UpdateNewGoalSwitch {

    @IBOutlet weak var newGoalSwitch: UISwitch!
    @IBOutlet weak var newGoalToggleLabel: UILabel!
    @IBOutlet weak var onOffLabel: UILabel!
    
    static var delegate: ToggleNewGoalButton?
    static var newGoalButtonState: Int?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        TabBarSubClass.switchStateDelegate = self

        self.parentViewController?.tabBarItem.image = UIImage(named: "tabBarButtonProfile")?.imageWithRenderingMode(.Automatic)
        self.parentViewController?.tabBarItem.selectedImage = UIImage(named: "tabBarButtonProfile")?.imageWithRenderingMode(.AlwaysOriginal)
        // Do any additional setup after loading the view.
    }
    
    func updateNewGoalSwitchWithState(state: Bool)
    {
        if state == false
        {
            newGoalSwitch.setOn(state, animated: true)
            onOffLabel.text = "Off"
        }
        else
        {
            newGoalSwitch.setOn(state, animated: true)
            onOffLabel.text = "On"
        }
    }
    
    @IBAction func enableNewGoalButtonToggled(sender: AnyObject)
    {
        ProfileViewController.delegate?.toggleNewGoalButton()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
