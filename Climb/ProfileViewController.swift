//
//  UserViewController.swift
//  Climb
//
//  Created by Justin Smith on 2/2/16.
//  Copyright © 2016 Justin Smith. All rights reserved.
//

import UIKit
import MessageUI

protocol ToggleNewGoalButton
{
    func toggleNewGoalButton()
}

class ProfileViewController: UIViewController, UpdateNewGoalSwitch, MFMailComposeViewControllerDelegate, UINavigationControllerDelegate  {

    @IBOutlet weak var newGoalSwitch: UISwitch!
    @IBOutlet weak var newGoalToggleLabel: UILabel!
    @IBOutlet weak var onOffLabel: UILabel!
    
    static var delegate: ToggleNewGoalButton?
    static var newGoalButtonState: Int?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        TabBarSubClass.switchStateDelegate = self

        self.title = "Profile View"
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
    
    @IBAction func sendEmailButtonTapped(sender: AnyObject)
    {
        let mailComposeViewController = MFMailComposeViewController()
        mailComposeViewController.mailComposeDelegate = self
        mailComposeViewController.navigationBar.tintColor = UIColor(red: 0.110, green: 0.816, blue: 1.000, alpha: 1.00)
        
        self.presentViewController(mailComposeViewController, animated: true, completion: nil)
    }
    
    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?)
    {
        if result == MFMailComposeResultSent
        {
            let sendMailErrorAlert = UIAlertController(title: "Message Sent", message: "Message was sent to the receipent", preferredStyle: .Alert)
            self.presentViewController(sendMailErrorAlert, animated: true, completion: nil)
            controller.dismissViewControllerAnimated(true, completion: nil)
        }
        else if result == MFMailComposeResultCancelled
        {
            controller.dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
    func showSendMailErrorAlert()
    {
        let sendMailErrorAlert = UIAlertController(title: "Could Not Send Email", message: "Your device could not send e-mail.  Please check e-mail configuration and try again.", preferredStyle: .Alert)
        self.presentViewController(sendMailErrorAlert, animated: true, completion: nil)
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
