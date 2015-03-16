//
//  MovieForEventCell.swift
//  Plan a Movie Night
//
//  Created by Bumhan Yu on 3/15/15.
//  Copyright (c) 2015 Angel, Bumhan, Matthew, and Vishnu. All rights reserved.
//

import UIKit

class MovieForEventCell: UITableViewCell {

    @IBOutlet weak var movieThumbnail: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!

    @IBOutlet weak var runningTimeAndGenre: UILabel!
    @IBOutlet weak var movieIsChecked: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
