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
        pageNumber = 0
    }
}
