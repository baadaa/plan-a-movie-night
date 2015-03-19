//
//  Invitee.swift
//  Plan a Movie Night
//
//  Created by Angel S. Moreno on 3/11/15.
//  Copyright (c) 2015 Angel, Bumhan, Matthew, and Vishnu. All rights reserved.
//

import UIKit

enum Attendance: Printable {
    case Pending, Going, NotGoing, MaybeGoing
    
    var description : String {
        switch self {
        case .Pending: return "Pending";
        case .Going: return "Going";
        case .NotGoing: return "NotGoing";
        case .MaybeGoing: return "MaybeGoing";
        }
    }
}
class Invitee: Serializable {
    var id: String {
        get {
            return "\(event_id)-\(user_id)"
        }
    }
    var event_id: String
    var user_id: String
    var status: String
    
    //@todo make these non optionals fetch in the init
    private var user: User?
    private var event: Event?
    
    init(event_id: String, user_id: String, status: Attendance){
        self.event_id = event_id
        self.user_id = user_id
        self.status = status.description
    }
    
    
}
