//
//  MovieListViewController.swift
//  Plan a Movie Night
//
//  Created by Bumhan Yu on 3/7/15.
//  Copyright (c) 2015 Angel, Bumhan, Matthew, and Vishnu. All rights reserved.
//

import UIKit

class MovieListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    let items = [1,2,3,4,5,6]
        // arrays of movies to be displayed in the table.
        // CODE HERE
    
    let cellReuseID = "cell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.registerNib(UINib(nibName: "MovieListCell", bundle: nil), forCellReuseIdentifier: cellReuseID)
        
        runTestStuff()
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellReuseID, forIndexPath: indexPath) as MovieListCell
        
        cell.selectionStyle = .None // disable cell highlight when selecting a cell
        
        //-------------------------------------
        //
        // This code block displays movie list in a TableCell
        //
        
        cell.moviePoster = UIImage(named: "chappie-poster.jpg")!
        cell.movieTitle.text = "Chappie"
        cell.movieReleaseDate.text = "2015.3.10"
        cell.movieDirector.text = "Neil Blomkamp"
        cell.runningTimeAndGenre.text = "120min • Action, Sci-fi"

        
        cell.movieChecked = UIImage(named:"movie_unchecked.png")!
        cell.movieChecked = UIImage(named:"movie_checked.png")!
            // Depending on whether the user insight is already provided, display the icon here.
        
        
        
        //
        //
        // Back-end data access code goes here.
        // Retrieve movie data and update code block above.
        //
        //-------------------------------------
        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 128
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
            
        performSegueWithIdentifier("movieDetailsFromList", sender: nil)
    }
    
    func runTestStuff(){
        let current_user_id = CurrentUser.sharedInstance.getData()!.id
        //create an event
        let event1 = Event(title: "Angel's Horror Movie Night", body: "We will be watching 6 horror flicks overnight.", event_date: "2015-03-25 at 6:00 PM", creator_id: current_user_id)
        event1.addInvite(current_user_id)
        event1.save()
    }
}

