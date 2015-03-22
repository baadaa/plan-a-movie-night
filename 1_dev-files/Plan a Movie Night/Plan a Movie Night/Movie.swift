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
    class var baseURL: String { return "https://api.themoviedb.org/3/movie" }
    
    
    var title = ""
    var releaseDate = ""
    var posterImageURL = ""
    var id = ""
    var summary = ""
    var movieImage = UIImage()
    var director = ""
    var genre = ""
    var runtime = ""
    var trailer: String?
    

    // should have a bunch of funcs to check
    init(movieDict: NSDictionary) {
        var dot = " • "
        
        let createMovieData = JSON(movieDict)
        
        if createMovieData["runtime"] == 0 {
            
            dot = ""
        }

        self.title = createMovieData["title"].stringValue
        self.releaseDate = createMovieData["release_date"].stringValue
        self.posterImageURL = "http://image.tmdb.org/t/p/w500" + createMovieData["poster_path"].stringValue
        self.id = createMovieData["id"].stringValue
        self.summary = createMovieData["overview"].stringValue
        
    
        // Deal with Genres
        if createMovieData["genres"][0]["name"].stringValue != "" {
        
        self.genre = dot + createMovieData["genres"][0]["name"].stringValue
        
        var movieGenre2: String = createMovieData["genres"][1]["name"].stringValue

        if movieGenre2 != "" {  //unwrapping did not work here?
            
           self.genre += ", " + movieGenre2
            
            }
            
            if createMovieData["genres"][0]["name"].stringValue == "" {
               
                self.genre = ""
                
            }
            
        }
        

        var myRuntime = createMovieData["runtime"].stringValue
        
        if myRuntime == "0" {
            
            self.runtime = ""
        }
        
        if myRuntime != "0" {
            
            self.runtime = myRuntime + " min"
        
    }
    
        // Sorry :(
        self.director = JSON("https://api.themoviedb.org/3/movie/\(id)/credits?api_key=0e7e1de1caeef3e82f74e1096b77f839" as NSString)["director"].stringValue
  
        
        //        if let myPosterURL = NSURL(string: self.posterImageURL) {   // TODO: better way is to pass UI image
        //
        //            Movie.downloadImage(myPosterURL) { image, error in
        //            self.movieImage = image
        //
        //            }
        //
        //        }
        
        
        
    }
    
    // tried to create a class (better movie class) where getMovies calls getOnce movie to fill the array of movies but coul not figur out. would have been a more elegant way, with the attibutes not in upcoming all taken care of in the get move instead of the init.
    
    class func getMovies(completion: (movieArray: [Movie]) ->Void) {
        var movieArrayToFill = [Movie] ()
        var movieIDArray = [String]()
        
        
        
        Alamofire.request(.GET, "\(baseURL)/upcoming?", parameters: ["api_key": key]).responseJSON {(request, reponse, data, error) -> Void in
            
            if let myData: AnyObject = data {
                var rawMovies = myData["results"] as NSArray?
                if let movieData = rawMovies {
                    for var i = 0; i < movieData.count; ++i {
                        
                        if let mID = movieData[i]["id"] as? Int {  //WHYYY?????? APPLE WHY?
                            
                            
                            movieIDArray.append("\(mID)")
                            
                            println(movieIDArray[i])
                        }

                        
                    }
                    
                    
                    for var j = 0; j < movieIDArray.count; ++j {
                        
                        Movie.getOneMovie(movieIDArray[j]) { (singleMovie) -> Void in
                            
                            var tempMovie = singleMovie as Movie
                            

                            println("title is" + tempMovie.title)
                        
                            
                            movieArrayToFill.append(singleMovie)
                            
                            if movieIDArray.count == movieArrayToFill.count {
                                
                                completion(movieArray: movieArrayToFill)
                                
                            }
                            
                        }
                        
                        
                    }
                }
            }
            
            
        }
    }
    
    
    //    class func getMovies(completion: (movieArray: [Movie]) ->Void) {
    //        var movieArray = [Movie] ()
    //        //var key = "0e7e1de1caeef3e82f74e1096b77f839"   // (?!) dont know how to access this from class func if
    //
    //
    //        Alamofire.request(.GET, "\(baseURL)/upcoming?", parameters: ["api_key": key]).responseJSON {(request, reponse, data, error) -> Void in
    //
    //            if let myData: AnyObject = data {
    //                var rawMovies = myData["results"] as NSArray?
    //                if let movieData = rawMovies {
    //                    for var i = 0; i < movieData.count; ++i {
    //
    //                        movieArray.append(Movie(movieDict: movieData[i] as NSDictionary))
    //
    //                        // TODO just call single movie and make array of movies as long as everyhting is in details that is in main       var test = movieArray[2].id
    //                    }
    //
    //                    completion(movieArray: movieArray)
    //                }
    //            }
    //        }
    //    }
    //

    class func getOneMovie (id: String, completion: (Movie) ->Void) {
        
//        let url = "\(baseURL)/\(id)?"
        
        Alamofire.request(.GET, "\(baseURL)/\(id)?", parameters: ["api_key": key]).responseJSON {(request, reponse, data, error) -> Void in
            
            if let myData: AnyObject = data {
                
                var rawMovieData: AnyObject = myData
                
                var newMovie = Movie(movieDict: myData as NSDictionary)
                
                completion(newMovie)
            }

        }
        
    }
    
    
    
    class func downloadImage(url: NSURL, handler: ((image: UIImage, NSError!) -> Void))
    {
        var blankImage: UIImageView
        var imageRequest: NSURLRequest = NSURLRequest(URL: url)
        NSURLConnection.sendAsynchronousRequest(imageRequest,
            queue: NSOperationQueue.mainQueue(),
            completionHandler:{response, data, error in
                
                
                if let myImage = UIImage(data: data){
                    
                    handler(image: myImage, error)
                    
                }
        })
    }
    
    
}










