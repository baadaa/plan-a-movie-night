//
//  AuthenticationViewController.swift
//  Plan a Movie Night
//
//  Created by Bumhan Yu on 3/8/15.
//  Copyright (c) 2015 Angel, Bumhan, Matthew, and Vishnu. All rights reserved.
//

import UIKit
import FacebookSDK

class AuthenticationViewController: UIViewController, FBLoginViewDelegate {
    
    //var loginsuccess: Int = 0
    
    @IBOutlet var fbLoginView : FBLoginView!
    
    @IBOutlet weak var authenticationButton: UIButton!
        // This is only for corner radius. All other button properties are set in storyboard.
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.fbLoginView.delegate = self
        self.fbLoginView.readPermissions = ["public_profile", "email", "user_friends"]

        authenticationButton.layer.cornerRadius = 5
            // change the corner radius
        sendTestData()
        
    }
    
    // Facebook Delegate Methods
    
    func loginViewShowingLoggedInUser(loginView : FBLoginView!) {
        println("User Logged In")
    }
    
    func loginViewFetchedUserInfo(loginView : FBLoginView!, user: FBGraphUser) {
        println("User: \(user)")
        println("User ID: \(user.objectID)")
        println("User Name: \(user.name)")
        var userEmail = user.objectForKey("email") as String
        println("User Email: \(userEmail)")
    }
    
    
    func loginViewShowingLoggedOutUser(loginView : FBLoginView!) {
        println("User Logged Out")
    }

    func loginView(loginView : FBLoginView!, handleError:NSError) {
        println("Error: \(handleError.localizedDescription)")
    }

    
    @IBAction func didTapAuthenticationButton(sender: AnyObject) {
        
        //
        //
        //
        // This function runs when Authentication Button is tapped.
        //
        // Facebook Authentication process code goes here.
        //
        // Facebook Authentication process code goes here
        //
        //
        //
        //
        //
        //
        let user = createTestUser()
        setCurrentUser(user)
        
        shouldPerformSegueWithIdentifier("authenticationSegue", sender: nil)

    }
    
    func sendTestData(){
        // Create a reference to a Firebase location
        var myRootRef = Firebase(url:"https://pamn.firebaseio.com/opens/")
        // Write data to Firebase
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd 'at' h:mm a" // superset of OP's format
        let date_str = dateFormatter.stringFromDate(NSDate())
        var device_id: String = UIDevice.currentDevice().identifierForVendor.UUIDString
        myRootRef.childByAppendingPath(device_id).childByAutoId().setValue(["device": device_id, "time": date_str])
    }
    
    func createTestUser() -> User {
        var device_id: String = UIDevice.currentDevice().identifierForVendor.UUIDString
        var default_img: String = "https://www-techinasia.netdna-ssl.com/wp-content/uploads/2009/11/facebook-avatar.png?1cb6c9"
        var user = User(
            name: "test user \(device_id)",
            facebook_id: device_id,
            profile_image_url: default_img,
            friends: ["002","004"]
        )
        user.save()
        return user
    }
    
    func setCurrentUser(user: User){
        CurrentUser.sharedInstance.setData(user)
    }
    
}