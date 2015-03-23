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
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var selectedCell: NSIndexPath?
    var items = [Movie]() // MM change to array of movies
    var toPass = ""  // ID to pass to detail VC
    
    // arrays of movies to be displayed in the table.
    // CODE HERE
    
    let cellReuseID = "cell"
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
 
        activityIndicator.center = self.view.center
        activityIndicator.alpha = 1
    
    }
    
   override func viewDidLoad() {
        super.viewDidLoad()
    
    
    
        self.tableView.registerNib(UINib(nibName: "MovieListCell", bundle: nil), forCellReuseIdentifier: self.cellReuseID)
        
        Movie.getMovies { (movieArray) -> Void in
            self.items = movieArray
            dispatch_async(dispatch_get_main_queue(), {
                self.tableView.reloadData()
                self.activityIndicator.alpha = 0  //spinner was appearing at the bottom
                //could put tableview loading into the closure
                
            })
            
    }

    
        //      runTestStuff()
        
        
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
        
        // MM  let movie = pull a movie from my array
        
        
        // handle images
        
        // replace with properties fromt he pulled movie object
        cell.movieTitle.text = self.items[indexPath.row].title
        cell.movieReleaseDate.text = self.items[indexPath.row].releaseDate
        cell.movieDirector.text = self.items[indexPath.row].director
        cell.runningTimeAndGenre.text = self.items[indexPath.row].runtime + self.items[indexPath.row].genre
        if let myPosterURL = NSURL(string: self.items[indexPath.row].posterImageURL) {
            Movie.downloadImage(myPosterURL) {image, error in
                cell.moviePoster = image
            }
        }
        cell.movieID = self.items[indexPath.row].id
        
        // TODO: specs did not have director and running time. will need to go back and change movie class to allow for this (only availble in single movie detail call)
        
        cell.movieChecked = UIImage(named:"movie_unchecked.png")!
        //cell.movieChecked = UIImage(named:"movie_checked.png")!
        
        
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
        
        
        
        toPass = self.items[indexPath.row].id
        
        performSegueWithIdentifier("movieDetailsFromList", sender: nil)
        
        
    }
    
    
    func runTestStuff(){
        
        
        
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        
        if segue.identifier == "movieDetailsFromList" {
            
            let destinationVc = segue.destinationViewController as MovieDetailsViewController
            
            destinationVc.movieID = toPass
            
            //TODO: all data is already available. Because of change to movielistvc, what we should be doing now is passing all the data to the detail view that we captured with getMovies.
            
            
        }
        
    }
    
    
}






