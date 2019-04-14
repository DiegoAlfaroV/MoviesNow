//
//  FileWorker.swift
//  moviesnow
//
//  Created by Alfaro, Diego on 10/04/19.
//  Copyright © 2019 IQVIA. All rights reserved.
//

import UIKit

class FileWorker: NSObject {
    static func downloadFile(fileUrl: String, completion: @escaping (_ result: Data?) -> Void) {
        let url = URL(fileURLWithPath: fileUrl)
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            completion(data)
        }
    }
}
