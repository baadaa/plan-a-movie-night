//
//  FriendsListCell.swift
//  Plan a Movie Night
//
//  Created by Bumhan Yu on 3/14/15.
//  Copyright (c) 2015 Angel, Bumhan, Matthew, and Vishnu. All rights reserved.
//

import UIKit

class FriendsListCell: UITableViewCell {

    @IBOutlet weak var friendHeadshot: UIImageView!
    @IBOutlet weak var friendName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
