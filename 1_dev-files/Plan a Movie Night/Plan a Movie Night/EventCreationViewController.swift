//
//  EventCreationViewController.swift
//  Plan a Movie Night
//
//  Created by Bumhan Yu on 3/11/15.
//  Copyright (c) 2015 Angel, Bumhan, Matthew, and Vishnu. All rights reserved.
//

import UIKit

class EventCreationViewController: UIViewController {

    
    
    @IBOutlet weak var inviteButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func cancelEvent(sender: AnyObject) {
        
        self.dismissViewControllerAnimated(true, completion: { () -> Void in
            //
        })
    }
    
    @IBAction func inviteButtonTapped(sender: AnyObject) {
        
        //
        //
        //
        // Code block for persisting user input goes here. When "Invite" button is tapped, make sure to store event title/description/location/time
        //
        //
        //
    shouldPerformSegueWithIdentifier("inviteFriendsWhenCreatingEvent", sender: nil)
        
    }
}
