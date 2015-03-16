//
//  Event.swift
//  Plan a Movie Night
//
//  Created by Angel S. Moreno on 3/11/15.
//  Copyright (c) 2015 Angel, Bumhan, Matthew, and Vishnu. All rights reserved.
//

import UIKit

class Event: Serializable {
    var id: String
    var title: String
    var body: String
//    var location: Location
    var event_date: String
    var creator_id: String
    var invitees: [String:Invitee] = [:]
    var movie_list: [MovieLineUp] = []
    
    //this init has all params; mostly used when fetching from db
    init(
        id: String,
        title: String,
        body: String,
        event_date: String,
        creator_id: String,
        invitees: [String:Invitee],
        movie_list: [MovieLineUp]
        ) {
   
        self.id = id
        self.title = title
        self.body = body
        self.event_date = event_date
        self.creator_id = creator_id
        self.invitees = invitees
        self.movie_list = movie_list
    }
    
    //this init is mostly used for creating
    init(
        title: String,
        body: String,
        event_date: String,
        creator_id: String
        ) {
            self.id = NSUUID().UUIDString
            self.title = title
            self.body = body
            self.event_date = event_date
            self.creator_id = creator_id
    }
    
    func addInvite(user_id: String) {
        var invite = Invitee(event_id: self.id, user_id: user_id, status: .Pending)
        self.invitees[user_id] = invite
    }
    
    func delInvite(user_id: String) {
        self.invitees[user_id] = nil
    }
    
    func updateInvite(user_id: String, status: Attendance) {
        var invite = Invitee(event_id: self.id, user_id: user_id, status: status)
        self.invitees[user_id] = invite
    }
    
    override func toDictionary() -> NSMutableDictionary {
        let dict = super.toDictionary()
        //invitees
        var invite_dict = NSMutableDictionary()
        for (invited_user_id, invite) in self.invitees {
            invite_dict[invited_user_id] = invite.toDictionary()
        }
        dict["invitees"] = invite_dict
        return dict
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
        return "events"
    }
    
}
