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
    var Creator: User?
    var invitees: [Invitee] = []
    var movie_list: [MovieLineUp] = []
    
    //this init has all params; mostly used when fetching from db
    init(
        id: String,
        title: String,
        body: String,
        location: String,
        event_date: String,
        creator_id: String,
        invitees: [Invitee],
        movie_list: [MovieLineUp]
        ) {
            self.title = title
            self.body = body
            self.location = location
            self.event_date = event_date
            self.creator_id = creator_id
            self.Creator = nil
            self.invitees = invitees
            self.movie_list = movie_list
            super.init(id: id)
    }
    //create a new event with date being an nsobject
    class func createNew(
        title: String,
        body: String,
        location: String,
        event_date: NSDate,
        creator_id: String
        ) -> Event {
            let dateString = Event.nsdateToString(event_date)
            return Event.createNew(title, body: body, location: location, event_date: dateString, creator_id: creator_id)
    }
    
    //create a new event with date being s tring
    class func createNew(
        title: String,
        body: String,
        location: String,
        event_date: String,
        creator_id: String
        ) -> Event {
            let event_id = NSUUID().UUIDString
            let invite = Invitee(event_id: event_id, user_id: creator_id, status: Attendance.Going)
            let newEvent = Event(id:  event_id,
                title: title,
                body: body,
                location: location,
                event_date: event_date,
                creator_id: creator_id,
                invitees: [invite],
                movie_list: []
            )
            
            return newEvent
    }
    
    class func fetchAll(completion: ([Event]) -> ()) {
        // Get a reference to our posts
        var ref = Firebase(url:"https://pamn.firebaseio.com/events")
        
        ref.observeSingleEventOfType(.Value, withBlock: { snapshot in
            var events: [Event] = []
            for childSnap in snapshot.children.allObjects as [FDataSnapshot]{
                if let event_title = childSnap.value["title"] as? NSString {
                    if let event_description = childSnap.value["body"] as? NSString {
                        if let event_location = childSnap.value["location"] as? NSString {
                            if let event_date = childSnap.value["event_date"] as? NSString {
                                if let creator_id = childSnap.value["creator_id"] as? NSString {
                                    let newEvent = Event.createNew(event_title, body: event_description, location: event_location, event_date: event_date, creator_id: creator_id)
                                    
                                        events.append(newEvent)
                                }
                            }
                        }
                    }
                }
            }
            
            completion(events)
        })
    }
    //
//    func addInvite(user_id: String) {
//        var invite = Invitee(event_id: self.id, user_id: user_id, status: .Pending)
//        self.invitees[user_id] = invite
//    }
//    
//    func delInvite(user_id: String) {
//        self.invitees[user_id] = nil
//    }
//    
//    func updateInvite(user_id: String, status: Attendance) {
//        var invite = Invitee(event_id: self.id, user_id: user_id, status: status)
//        self.invitees[user_id] = invite
//    }
    
    override func toDictionary() -> NSMutableDictionary {
        let dict = super.toDictionary()
        //invitees
        dict.removeObjectForKey("invitees")
        for invite in self.invitees {
            invite.save()
        }
        return dict
    }
    
    override func getDbname() -> String{
        return "events"
    }
    
}

//folowing singleton implementation http://stackoverflow.com/a/24073016/372875
class CurrentEvent {
    var event: Event?
    
    init(){}
    
    func getData() -> Event? {
        return self.event
    }
    
    func setData(event: Event) {
        self.event = event
    }
    
    class var sharedInstance: CurrentEvent {
        struct Singleton {
            static let instance = CurrentEvent()
        }
        return Singleton.instance
    }
    
}

