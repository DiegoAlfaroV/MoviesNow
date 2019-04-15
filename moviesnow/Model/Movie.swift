//
//  Movie.swift
//  moviesnow
//
//  Created by Alfaro, Diego on 8/04/19.
//  Copyright © 2019 IQVIA. All rights reserved.
//

import UIKit

class Movie: NSObject {
    
    init(title: String, year: String, overview: String, imageId: String) {
        self.title = title
        self.year = year
        self.overview = overview
        self.imageId = imageId
    }
    
    var title: String?
    var year: String?
    var overview: String?
    var imageId: String?
    var pictureUrl: String?
}
