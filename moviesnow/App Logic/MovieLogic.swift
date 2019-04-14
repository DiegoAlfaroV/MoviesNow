//
//  MovieLogic.swift
//  moviesnow
//
//  Created by Alfaro, Diego on 8/04/19.
//  Copyright © 2019 IQVIA. All rights reserved.
//

import UIKit
import SwiftyJSON

class MovieLogic: NSObject {
    static func createMovie(jsonObject: JSON) -> Movie {
        var title = ""
        var year = ""
        var overview = ""
        
        if let titleString = jsonObject["title"].string {
            title = titleString
        }
        if let yearString = jsonObject["year"].int {
            year = "\(yearString)"
        }
        if let overviewString = jsonObject["overview"].string {
            overview = overviewString
        }
        
        return Movie(title: title, year: year, overview: overview, pictureUrl: "")
    }
    
    static func listar(completion: @escaping (_ result: [Movie]?) -> Void) {
        let page = UserSettings.getPageNumber()
        let limit = UserSettings.getPageLimit()
        
        //Make request
        MovieWorker.getMovies(keyword: "", page: page, limit: limit) { result in
            if result != nil {
                var movies: [Movie] = []
                
                for item in (result?.array)! {
                    let movie = createMovie(jsonObject: item)
                    movies.append(movie)
                }
                
                UserSettings.addPageNumber()
                completion(movies)
            } else {
                completion(nil)
            }
            
        }
    }
    
    static func buscar(keyword: String, completion: @escaping (_ result: [Movie]) -> Void) {
        let page = UserSettings.getPageNumber()
        let limit = UserSettings.getPageLimit()
        
        //Cancel requests
        MovieWorker.cancelRequests()
        UserSettings.clearPageNumber()
        
        //Make request
        MovieWorker.getMovies(keyword: keyword, page: page, limit: limit) { result in
            if result != nil {
                var movies: [Movie] = []
                
                for item in (result?.array)! {
                    let movie = createMovie(jsonObject: item["movie"])
                    movies.append(movie)
                }
                
                UserSettings.addPageNumber()
                completion(movies)
            } else {
                completion([Movie]())
            }
        }
    }
}
