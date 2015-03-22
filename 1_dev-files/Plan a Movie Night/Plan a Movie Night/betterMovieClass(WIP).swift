
/*
//
//  betterMovieClass(WIP).swift
//  Plan a Movie Night
//
//  Created by Matt Miller on 3/21/15.
//  Copyright (c) 2015 Angel, Bumhan, Matthew, and Vishnu. All rights reserved.
//

import Foundation


// TODO just call single movie and make array of movies as long as everyhting is in details that is in main       var test = movieArray[2].id

// returns empty string

class func getMovies(completion: (movieArray: [Movie]) ->Void) {
    var movieArray = [Movie] ()
    
    //var key = "0e7e1de1caeef3e82f74e1096b77f839"   // (?!) dont know how to access this from class func if outside
    
    Alamofire.request(.GET, "https://api.themoviedb.org/3/movie/upcoming?", parameters: ["api_key": key]).responseJSON {(request, reponse, data, error) -> Void in
        
        if let myData: AnyObject = data {
            var rawMovies = myData["results"] as NSArray?
            
            if let movieData = rawMovies {
                
                for var i = 0; i < movieData.count; ++i {
                    
                    var lookupID = toString(movieData[i]["id"])
                    
                    println(lookupID)
                    
                    Movie.getOneMovie(lookupID, completion: { (singleMovie) -> Void in
                        
                        println("wham")
                        
                        
                        println(singleMovie.title)
                        
                        
                    })
                    
                    
                    
                }
                
                
            }
            
            completion(movieArray: movieArray)
        }
        
        
    }
    
    
    
}
*/