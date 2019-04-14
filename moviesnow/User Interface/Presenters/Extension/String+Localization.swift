//
//  String+Localization.swift
//  moviesnow
//
//  Created by Alfaro, Diego on 9/04/19.
//  Copyright © 2019 IQVIA. All rights reserved.
//

import UIKit

extension String {
    static func get(key: String) -> String {
        return NSLocalizedString(key, comment: key)
    }
}
