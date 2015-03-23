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
        //println(user)
        //var friendAsUser = User(name: "", facebook_id: "", profile_image_url: "", friends: [])
       
        var friendsUserList: [User] = [] //[User(name: "", facebook_id: "", profile_image_url: "", friends: [])]
        var friendNameList : [String] = []
        var url: String = ""
        var me:  FBGraphUser
        var friendsRequest : FBRequest = FBRequest.requestForMyFriends()
       
        //------------------------------------        
        FBRequestConnection.startWithGraphPath("me/friends?fields=name,id,picture", completionHandler: {(connection: FBRequestConnection!, result: AnyObject!, error: NSError!) -> Void in
            if (result? != nil) {
                //println("error = \(error)")
                
                var localUser = User(name: "", facebook_id: "", profile_image_url: "", friends: [])
                var data: NSArray = result.objectForKey("data") as NSArray
                
                for i in 0..<data.count {
                    println(data[i])
                    let valueDict : NSDictionary = data[i] as NSDictionary 
                    if let friendId = valueDict.objectForKey("id") as? String {
                        localUser.facebook_id = friendId
                    }
                    if let friendName = valueDict.objectForKey("name") as? String{
                        localUser.name = friendName
                    }
                    let picture = valueDict.objectForKey("picture") as NSDictionary
                    let dataFromPicture = picture.objectForKey("data") as NSDictionary
                    if let urlForFriendImg = dataFromPicture.objectForKey("url") as? String {
                        localUser.profile_image_url = urlForFriendImg
                    }
                    friendNameList.append(localUser.name)
                    friendsUserList.append(localUser)
                    /*
                    println("*****************")
                    println(localUser.name)
                    println(picture)
                    println(dataFromPicture)
                    println(localUser.profile_image_url)
                    println("*********************")
                    */
                }
                FBRequestConnection.startWithGraphPath("me?fields=id,name,picture", completionHandler: {(connection: FBRequestConnection!, result: AnyObject!, error: NSError!) -> Void in
                    if (result? != nil) {
                        //println("error = \(error)")
                        // get login user URL
                        println("-----Login user id, name, picture")
                        println(result)
                        var localUser = User(name: "", facebook_id: "", profile_image_url: "", friends: [])
                        var picture: NSDictionary = result.objectForKey("picture") as NSDictionary
                        var data: NSDictionary = picture.objectForKey("data") as NSDictionary
                        var url: String = data.objectForKey("url") as String
                        
                        // save login user to database
                        var currentUser = User(name: user.name, facebook_id: user.objectID, profile_image_url: url, friends: friendNameList)
                        currentUser.save()
                        self.setCurrentUser(currentUser)
                        println("currentUser.profile_image_url..........")
                        println(currentUser.profile_image_url)
                        
                        var friendUser = User(name: "", facebook_id: "", profile_image_url: "", friends: [])
                        
                        //saves friend's name, id and img_url as User object
                        println("inside.....")
                        println(friendsUserList.count)
                        println("friendUser.profile_image_url..........")
                        for i in 0..<friendsUserList.count {
                            friendUser = friendsUserList[i]
                            self.setCurrentUser(friendUser)
                            println(friendUser.profile_image_url)

                        }
                        println("---------------------------------")
                    }
                } as FBRequestHandler)  // end inner call graph API
            //println("________")
            }
        } as FBRequestHandler)

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