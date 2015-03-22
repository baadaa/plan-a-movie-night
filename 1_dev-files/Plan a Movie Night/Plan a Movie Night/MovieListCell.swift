//
//  MovieListCell.swift
//  Plan a Movie Night
//
//  Created by Bumhan Yu on 3/8/15.
//  Copyright (c) 2015 Angel, Bumhan, Matthew, and Vishnu. All rights reserved.
//

import UIKit

class MovieListCell: UITableViewCell {
    
    var movieID = ""

    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieDirector: UILabel!
    @IBOutlet weak var movieReleaseDate: UILabel!
    @IBOutlet weak var runningTimeAndGenre: UILabel!
    
    @IBOutlet private weak var movieIsChecked: UIImageView!
    
    @IBOutlet private weak var moviePosterView: UIImageView!
    
    var moviePoster: UIImage? {
        get { return moviePosterView.image }
        set { moviePosterView.image = newValue }
    }
    
    var movieChecked: UIImage? {
        get { return
            movieIsChecked.image }
        set { movieIsChecked.image = newValue }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
}
