//
//  FriendsViewController.swift
//  Plan a Movie Night
//
//  Created by Bumhan Yu on 3/11/15.
//  Copyright (c) 2015 Angel, Bumhan, Matthew, and Vishnu. All rights reserved.
//

import UIKit
import Social
import FacebookSDK

class FriendsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
 
    var message: String = ""

    @IBOutlet weak var tableView: UITableView!
    
    let items = [1,2,3,4,5,6,7,8,9,10]
    // array of friends to be displayed in the table.
    // CODE HERE
    
    let cellReuseID = "cell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.registerNib(UINib(nibName: "FriendsListCell", bundle: nil), forCellReuseIdentifier: cellReuseID)
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellReuseID, forIndexPath: indexPath) as FriendsListCell
        
        cell.selectionStyle = .None // disable cell highlight when selecting a cell
        
        //-------------------------------------
        //
        //
        //
        
        cell.friendHeadshot.image = UIImage(named: "seol.png")!
        cell.friendName.text = "Seol Park"
        
        //
        //
        // Back-end data access code goes here.
        // Retrieve the list of friends using the app and display data.
        //
        //
        //-------------------------------------
        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 65
    }
    
    func loginViewFetchedUserInfo(loginView : FBLoginView!, user: FBGraphUser) {
        
        
        println("User: \(user)")
        println("User ID: \(user.objectID)")
        println("User Name: \(user.name)")
        var userEmail = user.objectForKey("email") as String
        println("User Email: \(userEmail)")
        
        self.message = user.objectID
    }
    
    
    @IBAction func facebookButtonTapped(sender: AnyObject) {
        
        //
        //
        //
        //
        // Code here: sharing on user Facebook wall
        //
        //
        //
        // post the message on Facebook
 
        //println(self.message)
        var friendNameList : [String] = []
        //var url: String = ""
        //var me:  FBGraphUser
        
        var friendsRequest : FBRequest = FBRequest.requestForMyFriends()
        friendsRequest.startWithCompletionHandler{(connection:FBRequestConnection!, result:AnyObject!, error:NSError!) -> Void in
            if (error == nil) {
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
                
                // form the message here
                if self.message == "" {
                    self.message = name
                } else {
                    self.message = self.message + ", " + name
                }
             
                //println("friendNameList \(friendNameList) friends")
                var friends = resultdict.objectForKey("data") as NSArray
                //println("Found \(friends.count) friends")
             }
                self.message = self.message + " invited to watch the movie"                
            }
            println("\(friendNameList)")
            println("self.message = \(self.message)")
            
            if SLComposeViewController.isAvailableForServiceType(SLServiceTypeFacebook){
                
                var facebookSheet:SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
                facebookSheet.setInitialText("\(self.message)")
                self.presentViewController(facebookSheet, animated: true, completion: nil)
                
            } else {
                
                var alert = UIAlertController(title: "Accounts", message: "Please login to a Facebook account to share.", preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                self.presentViewController(alert, animated: true, completion: nil)
            }

         
        }
    } // end of
    
}  //end of facebookButtonTapped

