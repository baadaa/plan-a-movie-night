//
//  User.swift
//  Plan a Movie Night
//
//  Created by Angel S. Moreno on 3/11/15.
//  Copyright (c) 2015 Angel, Bumhan, Matthew, and Vishnu. All rights reserved.
//

import UIKit

class User: Serializable  {
    var id: String
    var name: String
    var facebook_id: String
    var profile_image_url: String
    var friends: [String]
    
    init(name: String, facebook_id: String, profile_image_url: String, friends: [String]) {
        self.id = facebook_id
        self.name = name
        self.facebook_id = facebook_id
        self.profile_image_url = profile_image_url
        self.friends = friends
    }
    
    func save() -> Bool {
        var data = self.toDictionary()
        data.removeObjectForKey("id")
        getFirebase().childByAppendingPath(self.id).setValue(data)
        
        //@otodo we need to return if the saving was successful or not
        return Bool()
    }
    
    private func getFirebase() -> Firebase {
        return Firebase(url: getFirebaseUrl()).childByAppendingPath(getDbname())
    }
    
    private func getFirebaseUrl() -> String {
        return "https://pamn.firebaseio.com/"
    }
    
    private func getDbname() -> String {
        return "users"
    }
    
}
