//
//  MovieDetailsViewController.swift
//  Plan a Movie Night
//
//  Created by Bumhan Yu on 3/8/15.
//  Copyright (c) 2015 Angel, Bumhan, Matthew, and Vishnu. All rights reserved.
//

import UIKit

class MovieDetailsViewController: UIViewController {

    
    
   var movieID = ""
    var singleMovie = Movie(movieDict: [:])
    
  //  var singleMovie = Movie()
    
    @IBOutlet weak var moviePoster: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieReleaseDate: UILabel!
    @IBOutlet weak var movieDirector: UILabel!
    @IBOutlet weak var runningTimeAndGenre: UILabel!
    @IBOutlet weak var movieSynopsis: UITextView!
    
    // Reference Outlets for movie information
    

    
    @IBOutlet weak var didYouWatchThis: UISegmentedControl!
    @IBOutlet weak var wantToWatchThis: UISegmentedControl!
    @IBOutlet weak var wantThisRating: UISegmentedControl!
    @IBOutlet weak var saveMyInsight: UIButton!
        // Reference Outlets for user insight
    
    
    
    override func viewWillAppear(animated: Bool) {
        
        println(movieID)
        println("details")

        
        Movie.getOneMovie(movieID) { (singleMovie) -> Void in
            
            self.singleMovie = singleMovie
            
            println("title" + singleMovie.title)
            
            
            self.movieTitle.text = singleMovie.title
            self.movieReleaseDate.text = singleMovie.releaseDate
            self.movieDirector.text = "Niel Blomkamp1234"
            self.runningTimeAndGenre.text = "\(singleMovie.runtime) • \(singleMovie.genre)"
            self.movieSynopsis.text = singleMovie.summary
            
            if let myPosterURL = NSURL(string: self.singleMovie.posterImageURL) {
                Movie.downloadImage(myPosterURL) {image, error in
                    self.moviePoster.image = image
                }
            }
  
        
        // Back-end data access code goes here.
        // Retrieve movie data and update code block above.
 
// end view will appear
}
    
    }
    
    @IBAction func didYouWatchThisFilm(sender: UISegmentedControl) {
        switch sender
        {
        case didYouWatchThis:
            switch sender.selectedSegmentIndex
            {
            case 0:
                // "YES"
                // CODE HERE
                println("yes")
            case 1:
                // "NO"
                // CODE HERE
                println("no")
            default:
                break;
            }
        case wantToWatchThis:
            switch sender.selectedSegmentIndex
            {
            case 0:
                // "YES"
                // CODE HERE
                println("yes")
                wantThisRating.setEnabled(true, forSegmentAtIndex: 0)
                wantThisRating.setEnabled(true, forSegmentAtIndex: 1)
                wantThisRating.setEnabled(true, forSegmentAtIndex: 2)
            case 1:
                // "NO"
                // CODE HERE
                println("no")
                wantThisRating.setEnabled(false, forSegmentAtIndex: 0)
                wantThisRating.setEnabled(false, forSegmentAtIndex: 1)
                wantThisRating.setEnabled(false, forSegmentAtIndex: 2)
            default:
                break;
            }
        case wantThisRating:
            switch sender.selectedSegmentIndex
            {
            case 0:
                // "NEVER"
                // CODE HERE
                println("never")
            case 1:
                // "MAYBE"
                // CODE HERE
                println("maybe")
            case 2:
                // "NEVER"
                // CODE HERE
                println("absolutely")
            default:
                break;
            }

        
        default:
            break;
        }
        
    }
    
    @IBAction func watchTrailerButtonTapped(sender: AnyObject) {
        
        //-------------------------------
        //
        //
        // CODE HERE: Launch movie trailer in web view
        //
        //
        //-------------------------------
        
        
        
        
        
    }
    
    @IBAction func saveInsightButtonTapped(sender: AnyObject) {
        
        let userDidWatchThis = didYouWatchThis.selectedSegmentIndex
        // 0 for yes, 1 for no
        
        let userWantToWatchThis = wantToWatchThis.selectedSegmentIndex
        // 0 for yes, 1 for no
        
        let userWantRating = wantThisRating.selectedSegmentIndex
        // 0 for never, 1 for maybe, 2 for absolutely
        
        // This is the final value for user input.
        
        
        
    //--------------------------
    //
    //
    //
    // Getting user insight code block needs to be written.
    //
    //
    //
    //
    //--------------------------
    }
}

