//
//  EventListCell.swift
//  Plan a Movie Night
//
//  Created by Bumhan Yu on 3/11/15.
//  Copyright (c) 2015 Angel, Bumhan, Matthew, and Vishnu. All rights reserved.
//

import UIKit

class EventListCell: UITableViewCell {

    @IBOutlet weak var RSVPStatus: UILabel!
    @IBOutlet weak var eventTitle: UILabel!
    @IBOutlet weak var dateAndTime: UILabel!
    @IBOutlet weak var eventLocation: UILabel!
    @IBOutlet weak var creatorName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
