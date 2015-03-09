//
//  MovieDetailsViewController.swift
//  Plan a Movie Night
//
//  Created by Bumhan Yu on 3/8/15.
//  Copyright (c) 2015 Angel, Bumhan, Matthew, and Vishnu. All rights reserved.
//

import UIKit

class MovieDetailsViewController: UIViewController {
    
    @IBOutlet weak var moviePoster: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieDirector: UILabel!
    @IBOutlet weak var runningTimeAndGenre: UILabel!
    @IBOutlet weak var movieSynopsis: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        moviePoster.image = UIImage(named: "chappie-poster.jpg")!
        movieTitle.text = "Chappie (2015)"
        movieDirector.text = "Director: Niel Blomkamp"
        runningTimeAndGenre.text = "120min • Action, Sci-fi"
        movieSynopsis.text = "Every child comes into the world full of promise, and none more so than Chappie: he is gifted, special, a prodigy. Like any child, Chappie will come under the influence of his surroundings—some good, some bad—and he will rely on his heart and soul to find his way in the world and become his own man. But there's one thing that makes Chappie different from any one else: he is a robot."
    
    }
    
    
}

