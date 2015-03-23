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
    @IBOutlet weak var NavBar: UINavigationItem!
    var activInd: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRectMake(0,0, 50, 50)) as UIActivityIndicatorView
    var selectedCell: NSIndexPath?
    var items = [Movie]() // MM change to array of movies
    var toPass = ""  // ID to pass to detail VC
    
    let cellReuseID = "cell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showSpinner()

        self.tableView.registerNib(UINib(nibName: "MovieListCell", bundle: nil), forCellReuseIdentifier: self.cellReuseID)
        
        

        Movie.getMovies { (movieArray) -> Void in
            self.items = movieArray
            dispatch_async(dispatch_get_main_queue(), {
                self.tableView.reloadData()
                self.activInd.stopAnimating()
                self.activInd.hidden = true
            })
        }
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
        
        cell.movieChecked = UIImage(named:"movie_unchecked.png")!
        //cell.movieChecked = UIImage(named:"movie_checked.png")!
        
        
        return cell
    }
    
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 128
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        
        toPass = self.items[indexPath.row].id
        performSegueWithIdentifier("movieDetailsFromList", sender: nil)
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        
        if segue.identifier == "movieDetailsFromList" {
            
            let destinationVc = segue.destinationViewController as MovieDetailsViewController
            
            destinationVc.movieID = toPass
            
            //TODO: all data is already available. Because of change to movielistvc, what we should be doing now is passing all the data to the detail view that we captured with getMovies.
        }
    }
    
    func showSpinner(){

        activInd.center = self.view.center
        activInd.hidesWhenStopped = true
        activInd.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
        view.addSubview(activInd)
        activInd.startAnimating()
        
    }
    
    
}






