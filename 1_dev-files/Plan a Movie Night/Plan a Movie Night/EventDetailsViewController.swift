//
//  EventDetailsViewController.swift
//  Plan a Movie Night
//
//  Created by Bumhan Yu on 3/11/15.
//  Copyright (c) 2015 Angel, Bumhan, Matthew, and Vishnu. All rights reserved.
//

import UIKit

class EventDetailsViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UITableViewDataSource, UITableViewDelegate {
    
    let friends = [1,2,3,4,5,6,7,8]
    // array of friends to be displayed in the collectionView.
    // CODE HERE
    
    let movies = [1,2,3]
    // array of movies to be displayed in the tableView.
    // CODE HERE
    
    @IBOutlet weak var tableView: UITableView!

    let cellReuseID = "tableCell"

    @IBOutlet weak var eventTitle: UILabel!
    @IBOutlet weak var eventDateAndTime: UILabel!
    @IBOutlet weak var eventLocation: UILabel!
    @IBOutlet weak var eventDescription: UILabel!
        // Referencing Outlets for event information
    
    @IBOutlet weak var inviteMoreFriends: UIButton!
    @IBOutlet weak var RSVPbutton: UISegmentedControl!
    
    @IBOutlet weak var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.registerNib(UINib(nibName: "MovieForEventCell", bundle: nil), forCellReuseIdentifier: cellReuseID)
        
        collectionView.backgroundColor = UIColor(red: 238/255, green: 238/255, blue: 238/255, alpha: 0)

        //------------------------------
        //
        // CODE HERE: display actual event data here to replace placeholder info below
        //
        
        eventTitle.text = "Angel's Birthday Night"
        eventDateAndTime.text = "Mar 7, 2015, 7:00PM"
        eventLocation.text = "Bronx Somewhere"
        eventDescription.text = "Angel becomes 35. Let's celebrate!"
        
        //
        //------------------------------
        
    }
    @IBAction func RSVPtapped(sender: UISegmentedControl) {
        
        // THIS IS TO HANDLE RSVP. Change the code block below per necessary, and persist the user input.
        
        switch RSVPbutton.selectedSegmentIndex
        {
        case 0:
            // RSVP "GOING"
            // CODE HERE
            println("going")
        case 1:
            // RSVP "MAYBE"
            // CODE HERE
            println("maybe")
        case 2:
            // RSVP "NOT GOING"
            // CODE HERE
            println("not going")

        default:
            break;
        
        }
        
        
    }
    

    
    
    
    // NOTE: UICollectionViewDataSource is responsible for friend list display
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return friends.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("collectionViewCell", forIndexPath: indexPath) as FriendsCollectionViewCell

        //------------------------------
        //
        //
        
        if let headshot = UIImage(named:"seol.png") {
            cell.imageView.image = headshot
        }
        
        //
        // CODE HERE. Pull Facebook friends' headshot and populate the imageView here.
        //
        //------------------------------
        
        return cell
    }

    @IBAction func inviteMoreFriendsTapped(sender: AnyObject) {
        
        //
        //
        // CODE here if necessary
        //
        //
        

        performSegueWithIdentifier("inviteFriendsFromEventDetail", sender: self)

    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "inviteFriendsFromEventDetail" {
            var destination = segue.destinationViewController as InviteFriendsViewController
            destination.eventDetailViewController = self
        }
    }

    
    
    
    // NOTE: tableView displays the movies
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellReuseID, forIndexPath: indexPath) as MovieForEventCell
        
        cell.selectionStyle = .None // disable cell highlight when selecting a cell
        
        //-------------------------------------
        //
        //
        //
        
        cell.movieThumbnail.image = UIImage(named: "chappie-poster.jpg")!
        cell.movieTitle.text = "Chappie (2015)"
        cell.runningTimeAndGenre.text = "120min • Action, Sci-fi"
        cell.movieIsChecked.image = UIImage(named:"movie_unchecked.png")
        cell.movieIsChecked.image = UIImage(named:"movie_checked.png")
        
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
        
        performSegueWithIdentifier("movieDetailFromEventDetail", sender: nil)
    }

    
}
