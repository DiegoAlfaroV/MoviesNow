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
        var imageId = ""
        
        if let titleString = jsonObject["title"].string {
            title = titleString
        }
        if let yearString = jsonObject["year"].int {
            year = "\(yearString)"
        }
        if let overviewString = jsonObject["overview"].string {
            overview = overviewString
        }
        
        if let ids = jsonObject["ids"].dictionary {
            if let id = ids["tmdb"]?.int {
                imageId = "\(id)"
            }
        }
        
        return Movie(title: title, year: year, overview: overview, imageId: imageId)
    }
    
    static func obtener(keywords: String, completion: @escaping (_ result: [Movie]) -> Void) {
        if keywords != "" {
            buscar(keyword: keywords) { movies in
                completion(movies)
            }
        } else {
            listar { movies in
                completion(movies)
            }
        }
    }
    
    private static func listar(completion: @escaping (_ result: [Movie]) -> Void) {
        let page = UserSettings.getPageNumber()
        let limit = UserSettings.getPageLimit()
        
        //Make request
        MovieWorker.getMovies(keyword: "", page: page, limit: limit) { result in
            var movies: [Movie] = []
            
            if result != nil {
                if let resultArray = result?.array {
                    for item in resultArray {
                        let movie = createMovie(jsonObject: item)
                        movies.append(movie)
                    }
                }
                
                UserSettings.addPageNumber()
            }
            
            completion(movies)
            
        }
    }
    
    private static func buscar(keyword: String, completion: @escaping (_ result: [Movie]) -> Void) {
        let page = UserSettings.getPageNumber()
        let limit = UserSettings.getPageLimit()
        
        //Cancel requests
        MovieWorker.cancelRequests()
        UserSettings.clearPageNumber()
        
        //Make request
        MovieWorker.getMovies(keyword: keyword, page: page, limit: limit) { result in
            var movies: [Movie] = []
            
            if result != nil {
                if let resultArray = result?.array {
                    for item in resultArray {
                        let movie = createMovie(jsonObject: item["movie"])
                        movies.append(movie)
                    }
                }
                
                UserSettings.addPageNumber()
            }
            
            completion(movies)
        }
    }
}
