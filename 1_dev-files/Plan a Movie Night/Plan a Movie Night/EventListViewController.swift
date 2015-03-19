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
    
    var items: [Event] = []

    let cellReuseID = "cell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.registerNib(UINib(nibName: "EventListCell", bundle: nil), forCellReuseIdentifier: cellReuseID)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        Event.fetchAll({ (events: [Event]) in
            self.items = events
            self.tableView.reloadData()
        })
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellReuseID, forIndexPath: indexPath) as EventListCell
        
        cell.selectionStyle = .None // disable cell highlight when selecting a cell
        
        //-------------------------------------
        //
        // This code block displays movie list in a TableCell
        //
        let event = items[indexPath.row]
        
        
        
            // RSVP status is color coded as well as text-labeled. Depending on given event's RSVP status, choose one of the three above for text and background color
        
        
        cell.eventTitle.text = event.title
        cell.dateAndTime.text = event.event_date
        cell.eventLocation.text = event.location
        cell.creatorName.text = event.creator_id
        
        var status = "going"
        
        switch status {
        case "going":
            
            cell.RSVPStatus.text = "GOING"
            cell.RSVPStatus.backgroundColor = UIColor(red: 122/255, green: 184/255, blue: 0, alpha: 1)

            case "not going":
            
                cell.RSVPStatus.text = "NOT\nGOING"
                cell.RSVPStatus.backgroundColor = UIColor(red: 220/255, green: 80/255, blue: 52/255, alpha: 1)
            
            case "maybe":
            
                cell.RSVPStatus.text = "MAYBE"
                cell.RSVPStatus.backgroundColor = UIColor(red: 220/255, green: 80/255, blue: 52/255, alpha: 1)
            
            case "":
                
                cell.RSVPStatus.text = "RSVP\nNOW"
                cell.RSVPStatus.backgroundColor = UIColor(red: 242/255, green: 175/255, blue: 0, alpha: 1)
        default:
            
            cell.RSVPStatus.text = "IDK"
            cell.RSVPStatus.backgroundColor = UIColor(red: 242/255, green: 175/255, blue: 0, alpha: 1)
            break
        }
        //
        //
        // Back-end data access code goes here.
        // Retrieve movie data and update code block above.
        //
        //-------------------------------------
        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 116
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
    
    func testStuff() {
        Event.fetchAll(printstuff)
    }
    
    func printstuff(events: [Event]){
        for event in events {
            println(event.title)
        }
        println(events)
    }

}

