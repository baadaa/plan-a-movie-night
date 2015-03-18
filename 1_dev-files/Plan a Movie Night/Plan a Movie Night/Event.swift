//
//  Event.swift
//  Plan a Movie Night
//
//  Created by Angel S. Moreno on 3/11/15.
//  Copyright (c) 2015 Angel, Bumhan, Matthew, and Vishnu. All rights reserved.
//

import UIKit

class Event: BasePAMNModel {
    var title: String
    var body: String
    var location: String
    var event_date: String
    var creator_id: String
    var invitees: [String:Invitee] = [:]
    var movie_list: [MovieLineUp] = []
    
    //this init has all params; mostly used when fetching from db
    init(
        id: String,
        title: String,
        body: String,
        location: String,
        event_date: String,
        creator_id: String,
        invitees: [String:Invitee],
        movie_list: [MovieLineUp]
        ) {
            
            self.title = title
            self.body = body
            self.location = location
            self.event_date = event_date
            self.creator_id = creator_id
            self.invitees = invitees
            self.movie_list = movie_list
            super.init(id: id)
    }
    
    //this init is mostly used for creating
    init(
        title: String,
        body: String,
        location: String,
        event_date: String,
        creator_id: String
        ) {
            self.title = title
            self.body = body
            self.location = location
            self.event_date = event_date
            self.creator_id = creator_id
            super.init(id: NSUUID().UUIDString)
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
        dict.removeObjectForKey("invitees")
        for (invited_user_id, invite) in self.invitees {
            invite.save()
        }
        return dict
    }
    
    override func getDbname() -> String{
        return "events"
    }
    
}
