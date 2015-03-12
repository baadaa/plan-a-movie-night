//
//  InviteFriendsViewController.swift
//  Plan a Movie Night
//
//  Created by Bumhan Yu on 3/11/15.
//  Copyright (c) 2015 Angel, Bumhan, Matthew, and Vishnu. All rights reserved.
//

import UIKit

class InviteFriendsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var doneButton: UIButton!
        // buttons in navigation bar
    
    @IBOutlet weak var tableView: UITableView!
    
    let items = [1,2,3,4,5,6]
    // arrays of movies to be displayed in the table.
    
    let cellReuseID = "cell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.registerNib(UINib(nibName: "InviteFriendsCell", bundle: nil), forCellReuseIdentifier: cellReuseID)
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellReuseID, forIndexPath: indexPath) as InviteFriendsCell
        
        cell.selectionStyle = .None // disable cell highlight when selecting a cell

        //-------------------------------------
        //
        //
        //
        
        cell.headshot.image = UIImage(named: "seol.png")!
        cell.name.text = "Seol Park"
        
        //
        //
        // Back-end data access code goes here.
        // Retrieve the list of friends using the app and display data.
        //
        // "Checkbox" is a custom UIButton class and has "isChecked" variable for a boolean value
        //
        //-------------------------------------
        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 115
    }
    
    @IBAction func doneButtonTapped(sender: AnyObject) {
        
        //
        //
        //
        //
        // Back-end code goes here.
        // Persist the list of friends selected.
        // Use boolean value of         "cell.checkbox.isChecked" to determine selection
        
        //
        //
        //
        
        self.dismissViewControllerAnimated(true, completion: { () -> Void in
        })
        
    }
    
    
    
    @IBAction func cancelButtonTapped(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: { () -> Void in
        })
    }

    
}

