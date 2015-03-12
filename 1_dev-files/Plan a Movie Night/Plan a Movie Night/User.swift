//
//  User.swift
//  Plan a Movie Night
//
//  Created by Angel S. Moreno on 3/11/15.
//  Copyright (c) 2015 Angel, Bumhan, Matthew, and Vishnu. All rights reserved.
//

import UIKit

class User: BasePAMNModel {
    var name: String
    var facebook_id: String
    var profile_image_url: String
    var profile_image: UIImage
    var friends: [User]
    
    init(data: NSDictionary) {
        if name = data.name {
            let self.name = data.name
        }
        self.facebook_id = data.id
    }

}
