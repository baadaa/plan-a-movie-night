//
//  User.swift
//  Plan a Movie Night
//
//  Created by Angel S. Moreno on 3/11/15.
//  Copyright (c) 2015 Angel, Bumhan, Matthew, and Vishnu. All rights reserved.
//

import UIKit

class User: BasePAMNModel  {
    //    var id: String
    var name: String
    var facebook_id: String
    var profile_image_url: String
    var friends: [String]
    
    init(name: String, facebook_id: String, profile_image_url: String, friends: [String]) {
        
        self.name = name
        self.facebook_id = facebook_id
        self.profile_image_url = profile_image_url
        self.friends = friends
        super.init(id: facebook_id)
    }
    
    class func fetchOne(user_id: String, completion: (User)) {
        // Get a reference to our posts
        let url = "https://pamn.firebaseio.com/users/\(user_id)"
        var ref = Firebase(url: url)
        
        ref.observeSingleEventOfType(.Value, withBlock: { snapshot in
            for childSnap in snapshot.children.allObjects as [FDataSnapshot]{
                if let user_name = childSnap.value["name"] as? NSString {
                    let newUser: User = User(name: user_name, facebook_id: user_id, profile_image_url: "", friends: [])
//                        completion(newUser)
                }
            }
        })
    }
    
    override func getDbname() -> String {
        return "users"
    }
    
}

//folowing singleton implementation http://stackoverflow.com/a/24073016/372875
class CurrentUser {
    var user: User?
    
    init(){}
    
    func getData() -> User? {
        return self.user
    }
    
    func setData(user: User) {
        self.user = user
    }
    
    class var sharedInstance: CurrentUser {
        struct Singleton {
            static let instance = CurrentUser()
        }
        return Singleton.instance
    }
    
}
