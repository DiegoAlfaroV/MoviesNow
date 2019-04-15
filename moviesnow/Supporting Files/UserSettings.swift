//
//  UserSettings.swift
//  moviesnow
//
//  Created by Alfaro, Diego on 8/04/19.
//  Copyright © 2019 IQVIA. All rights reserved.
//

import UIKit

class UserSettings: NSObject {
    private static var pageNumber: Int = 1
    private static let pageLimit: Int = 10
    private static var imageBaseUrl: String = "https://image.tmdb.org/t/p/w92"
    
    static func getPageLimit() -> Int {
        return pageLimit
    }
    
    static func getPageNumber() -> Int {
        return pageNumber
    }
    
    static func addPageNumber() {
        pageNumber += 1
    }

    static func clearPageNumber() {
        pageNumber = 1
    }
    
    static func setImageBaseUrl(baseUrl: String) {
        imageBaseUrl = baseUrl
    }
    
    static func getImageBaseUrl() -> String {
        return imageBaseUrl
    }
}
