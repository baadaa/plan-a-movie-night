//
//  EventListViewController.swift
//  Plan a Movie Night
//
//  Created by Bumhan Yu on 3/11/15.
//  Copyright (c) 2015 Angel, Bumhan, Matthew, and Vishnu. All rights reserved.
//

import UIKit

class EventListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    let items = [1,2,3,4,5,6]
    // arrays of events to be displayed in the table.
    
    let cellReuseID = "cell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.registerNib(UINib(nibName: "EventListCell", bundle: nil), forCellReuseIdentifier: cellReuseID)
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellReuseID, forIndexPath: indexPath) as EventListCell
        
        
        //-------------------------------------
        //
        // This code block displays movie list in a TableCell
        //
        
        cell.RSVPStatus.text = "GOING"
        cell.RSVPStatus.backgroundColor = UIColor(red: 122/255, green: 184/255, blue: 0, alpha: 1)
        
        cell.RSVPStatus.text = "NOT\nGOING"
        cell.RSVPStatus.backgroundColor = UIColor(red: 220/255, green: 80/255, blue: 52/255, alpha: 1)
        
        cell.RSVPStatus.text = "RSVP\nNOW"
        cell.RSVPStatus.backgroundColor = UIColor(red: 242/255, green: 175/255, blue: 0, alpha: 1)
            // RSVP status is color coded as well as text-labeled. Depending on given event's RSVP status, choose one of the three above for text and background color
        
        
        cell.eventTitle.text = "Angel's Birthday Night"
        cell.dateAndTime.text = "March 7 at 20:00"
        cell.eventLocation.text = "Bronx Somewhere"
        
        //
        //
        // Back-end data access code goes here.
        // Retrieve movie data and update code block above.
        //
        //-------------------------------------
        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 135
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        //
        //
        // This code runs when user selects a movie.
        //
        // Back-end data access code goes here.
        // Detailed information selected movie to be displaed after segue
        //
        //
        //
        
        performSegueWithIdentifier("eventDetailsFromList", sender: nil)
    }
}

