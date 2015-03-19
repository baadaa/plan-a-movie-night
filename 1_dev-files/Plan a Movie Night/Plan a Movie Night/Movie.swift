//
//  Movie.swift
//  Plan a Movie Night
//
//  Created by Angel S. Moreno on 3/11/15.
//  Copyright (c) 2015 Angel, Bumhan, Matthew, and Vishnu. All rights reserved.
//


import Foundation
import SwiftyJSON
import Alamofire

class Movie: Serializable {
    class var key: String { return "0e7e1de1caeef3e82f74e1096b77f839" }
    
    var title = ""
    var releaseDate = ""
    var posterImageURL = ""
    var id = ""
    
    init(movieDict: NSDictionary) {
        
        let createMovieData = JSON(movieDict)
        self.title = createMovieData["title"].stringValue
        self.releaseDate = createMovieData["release_date"].stringValue
        self.posterImageURL = "http://image.tmdb.org/t/p/w500" + createMovieData["poster_path"].stringValue
        self.id = createMovieData["id"].stringValue
        
    }
    
    
    class func getMovies(completion: (movieArray: [Movie]) ->Void) {
        var movieArray = [Movie] ()
        //var key = "0e7e1de1caeef3e82f74e1096b77f839"   // (?!) dont know how to access this from class func if outside
        
        Alamofire.request(.GET, "https://api.themoviedb.org/3/movie/upcoming?", parameters: ["api_key": key]).responseJSON {(request, reponse, data, error) -> Void in
            
            if let myData: AnyObject = data {
                var rawMovies = myData["results"] as NSArray?
                
                if let movieData = rawMovies {
                    for var i = 0; i < movieData.count; ++i {
                        
                        movieArray.append(Movie(movieDict: movieData[i] as NSDictionary))
                    }
                    
                    completion(movieArray: movieArray)
                }
            }
        }
    }
    
    
    class func getOneMovie (id: String, completion: (Movie) ->Void) {
        
        // var key = "0e7e1de1caeef3e82f74e1096b77f839"
        
        Alamofire.request(.GET, "https://api.themoviedb.org/3/movie/\(id)?", parameters: ["api_key": key]).responseJSON {(request, reponse, data, error) -> Void in
            
            if let myData: AnyObject = data {
                
                var rawMovieData: AnyObject = myData
                
                var newMovie = Movie(movieDict: myData as NSDictionary)
                
                completion(newMovie)
            }
            
        }
        
        
        
        
    }
    
    
}
