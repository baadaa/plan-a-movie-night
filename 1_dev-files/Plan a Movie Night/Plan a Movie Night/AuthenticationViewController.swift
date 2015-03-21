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
    
   // @IBOutlet weak var authenticationButton: UIButton!
        // This is only for corner radius. All other button properties are set in storyboard.
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.fbLoginView.delegate = self
        self.fbLoginView.readPermissions = ["public_profile", "email", "user_friends"]

        //authenticationButton.layer.cornerRadius = 5
            // change the corner radius
        sendTestData()
        
    }
    
    // Facebook Delegate Methods
    
    func loginViewShowingLoggedInUser(loginView : FBLoginView!) {
        println("User Logged In")
    }
    
    func loginViewFetchedUserInfo(loginView : FBLoginView!, user: FBGraphUser) {
        
        /*
        println("User: \(user)")
        println("User ID: \(user.objectID)")
        println("User Name: \(user.name)")
        var userEmail = user.objectForKey("email") as String
        println("User Email: \(userEmail)")
        */
        
        var friendNameList : [String] = []
        var url: String = ""
        var me:  FBGraphUser
        
        var friendsRequest : FBRequest = FBRequest.requestForMyFriends()
        friendsRequest.startWithCompletionHandler{(connection:FBRequestConnection!, result:AnyObject!, error:NSError!) -> Void in
            var resultdict = result as NSDictionary
            println("Result Dict: \(resultdict)")
            var data : NSArray = resultdict.objectForKey("data") as NSArray
            
            for i in 0..<data.count {
                let valueDict : NSDictionary = data[i] as NSDictionary
                /*
                let id = valueDict.objectForKey("id") as String
                let first_name = valueDict.objectForKey("first_name") as String
                let last_name = valueDict.objectForKey("last_name") as String
                */
                
                let name = valueDict.objectForKey("name") as String
                /*
                println("the id value is \(id)")
                println("the first_name value is \(first_name)")
                println("the last_name value is \(last_name)")
                println("the name value is \(name)")
                */
                
                friendNameList.append(name)
                
                //println("friendNameList \(friendNameList) friends")
            }
            
            var friends = resultdict.objectForKey("data") as NSArray
            //println("Found \(friends.count) friends")
        }
        
        // call to get user info
        FBRequestConnection.startForMeWithCompletionHandler { (connection, me, error) -> Void in
            if (error == nil){
                url = me.objectForKey("link") as String
                println(me)
            }
        }

        let currentUser = User(name: user.name, facebook_id: user.objectID, profile_image_url: url, friends: friendNameList)
        currentUser.save()
        setCurrentUser(currentUser)
        performSegueWithIdentifier("authenticationSegue", sender: nil)
        
    }
    
    
    func loginViewShowingLoggedOutUser(loginView : FBLoginView!) {
        println("User Logged Out")
    }

    func loginView(loginView : FBLoginView!, handleError:NSError) {
        println("Error: \(handleError.localizedDescription)")
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