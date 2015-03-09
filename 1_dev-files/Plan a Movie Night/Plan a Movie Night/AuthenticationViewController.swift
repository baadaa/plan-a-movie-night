//
//  AuthenticationViewController.swift
//  Plan a Movie Night
//
//  Created by Bumhan Yu on 3/8/15.
//  Copyright (c) 2015 Angel, Bumhan, Matthew, and Vishnu. All rights reserved.
//

import UIKit

class AuthenticationViewController: UIViewController {
    
    @IBOutlet weak var authenticationButton: UIButton!
        // This is only for corner radius. All other button properties are set in storyboard.
    
    override func viewDidLoad() {
        super.viewDidLoad()
        authenticationButton.layer.cornerRadius = 5
            // change the corner radius
    }
    
    
    @IBAction func didTapAuthenticationButton(sender: AnyObject) {
        
        //
        //
        //
        //
        //
        // Facebook Authentication process code goes here
        //
        //
        //
        //
        //
        //
        
        shouldPerformSegueWithIdentifier("authenticationSegue", sender: nil)
            // After successful authentication, this will perform segue to main app screen
        
    }
    
}