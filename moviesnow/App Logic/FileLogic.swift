//
//  FileLogic.swift
//  moviesnow
//
//  Created by Alfaro, Diego on 10/04/19.
//  Copyright © 2019 IQVIA. All rights reserved.
//

import UIKit

class FileLogic: NSObject {
    private static func getDocumentDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    static func getFile(from url: String, completion: @escaping (_ result: String) -> Void) {
        let filePath = getDocumentDirectory().appendingPathComponent(url).absoluteString
        
        if FileManager.default.fileExists(atPath: filePath) {
            completion(filePath)
        } else {
            FileWorker.downloadFile(fileUrl: url) { result in
                if result != nil {
                    do {
                        try result?.write(to: URL(fileURLWithPath: filePath))
                        completion(filePath)
                    } catch {
                        completion("")
                    }
                } else {
                    completion("")
                }
            }
        }
    }
}
