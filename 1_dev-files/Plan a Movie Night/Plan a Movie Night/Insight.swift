//
//  Insight.swift
//  Plan a Movie Night
//
//  Created by Angel S. Moreno on 3/11/15.
//  Copyright (c) 2015 Angel, Bumhan, Matthew, and Vishnu. All rights reserved.
//

import UIKit

class Insight: Serializable {
    var id: String {
        get {
            return "\(user_id)-\(movie_id)"
        }
    }
    var user_id: String
    var movie_id: String
    var is_seen: Bool
    var would_see: Bool
    var interest_level: Int
    
    init(user_id: String, movie_id: String, is_seen: Bool, would_see: Bool, interest_level: Int) {
        self.user_id = user_id
        self.movie_id = movie_id
        self.is_seen = is_seen
        self.would_see = would_see
        self.interest_level = interest_level
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
