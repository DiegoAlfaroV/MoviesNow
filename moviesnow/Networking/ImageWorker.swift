//
//  ImageWorker.swift
//  moviesnow
//
//  Created by Diego on 14/04/19.
//  Copyright © 2019 IQVIA. All rights reserved.
//

import UIKit

import Alamofire
import SwiftyJSON
import Alamofire_SwiftyJSON

class ImageWorker: NSObject {
    static let apiKey = "23b72ec7f0a08152b3c4262c83d37dd3"
    static let apiPath = "https://api.themoviedb.org/3/movie/"

    static func getImage(id: String, completion: @escaping (_ result: JSON?) -> Void) {
        let requestString = apiPath + "\(id)/images?api_key=\(apiKey)&language=en,null"
        
        let url = URL(string: requestString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)
        
        let headers = [
            "api_key": apiKey
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
