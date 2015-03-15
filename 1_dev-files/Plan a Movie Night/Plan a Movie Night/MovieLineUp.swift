//
//  MovieLineUp.swift
//  Plan a Movie Night
//
//  Created by Angel S. Moreno on 3/11/15.
//  Copyright (c) 2015 Angel, Bumhan, Matthew, and Vishnu. All rights reserved.
//

import UIKit

class MovieLineUp: Serializable {
    var event_id: String
    var movie_id: String
    var score: Float {
        get {
            return self.calculateScore()
        }
    }
    
    //@todo make these non optionals fetch in the init
    private var event: Event?
    private var movie: Movie?
    
    init(event_id: String, movie_id: String) {
        self.event_id = event_id
        self.movie_id = movie_id
    }
    
    private func calculateScore() -> Float {
        return Float(0);
    }
    
    
}
