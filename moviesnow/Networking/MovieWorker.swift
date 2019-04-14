//
//  MovieWorker.swift
//  moviesnow
//
//  Created by Alfaro, Diego on 8/04/19.
//  Copyright © 2019 IQVIA. All rights reserved.
//

import UIKit

import Alamofire
import SwiftyJSON
import Alamofire_SwiftyJSON

class MovieWorker: NSObject {
    static let clientId = "b771548496e8fd043c2276b60b202b048afc137ba17064ea683cf7f518f8de8a"
    static let apiPath = "https://api.trakt.tv/"
    
    static func cancelRequests() {
        Alamofire.SessionManager.default.session.getTasksWithCompletionHandler { (dataTask, uploadTask, downloadTask) in
            dataTask.forEach { $0.cancel() }
            uploadTask.forEach { $0.cancel() }
            downloadTask.forEach { $0.cancel() }
        }
    }

    static func getMovies(keyword: String?, page: Int, limit: Int, completion: @escaping (_ result: JSON?) -> Void) {
        var requestString = ""
        if keyword != nil && keyword! != "" {
            requestString = apiPath + "search/movie?query=\(keyword!)&type=title,tagline&extended=full&"
        } else {
            requestString = apiPath + "movies/popular?extended=full&"
        }
        
        requestString = requestString + "page=\(page)&limit=\(limit)"
        
        let url = URL(string: requestString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)
        
        let headers = [
            "Content-Type": "application/json",
            "trakt-api-version": "2",
            "trakt-api-key": clientId
        ]
        
        Alamofire.request(url!, method: .get, parameters: nil,
                          encoding: JSONEncoding.default, headers: headers).responseSwiftyJSON { (response) in
                            
                            if let error = response.error {
                                print(error.localizedDescription)
                                completion(nil)
                            } else {
                                let jsonResponse = JSON(response.result.value!)
                                completion(jsonResponse)
                            }
        }
    }
}
