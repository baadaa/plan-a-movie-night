//
//  FriendsViewController.swift
//  Plan a Movie Night
//
//  Created by Bumhan Yu on 3/11/15.
//  Copyright (c) 2015 Angel, Bumhan, Matthew, and Vishnu. All rights reserved.
//

import UIKit
import Social

class FriendsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
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
    
    
    
    @IBAction func facebookButtonTapped(sender: AnyObject) {
        
        //
        //
        //
        //
        // Code here: sharing on user Facebook wall
        //
        //
        //
        //
        var shareToFacebook : SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
        self.presentViewController(shareToFacebook, animated: true, completion: nil)
    }
    
}

