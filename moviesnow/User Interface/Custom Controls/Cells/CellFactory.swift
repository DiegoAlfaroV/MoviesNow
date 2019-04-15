//
//  CellFactory.swift
//  moviesnow
//
//  Created by Alfaro, Diego on 9/04/19.
//  Copyright © 2019 IQVIA. All rights reserved.
//

import UIKit

class CellFactory: NSObject {
    static func createMovieCell(tableView: UITableView, indexPath: IndexPath, movie: Movie) -> UITableViewCell {
        if let cell: MovieCell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as? MovieCell {
        
            //TODO: optimize Image Logic
            ImageWorker.getImage(id: movie.imageId!) { result in
                if let jsonResult = result {
                    let posters = jsonResult["posters"]
                    
                    if let jsonResults = posters.array {
                        for item in jsonResults {
                            let aspectRatio = "\(item["aspect_ratio"].float!)"
                            
                            if aspectRatio.contains("0.66666") {
                                movie.pictureUrl = UserSettings.getImageBaseUrl() + item["file_path"].string!
                                if let url = URL(string: movie.pictureUrl!) {
                                    do {
                                        let pictureData = try Data(contentsOf: url)
                                        cell.imgMovie.image = UIImage(data: pictureData)
                                    } catch {
                                    }
                                }
                                
                                break
                            }
                        }
                    }
                }
            }
            
            cell.lblTitle.text = "\(movie.title!) (\(movie.year!))"
            cell.lblOverview.text = movie.overview
            cell.lblOverview.animate()
            
            return cell
        }
        
        return UITableViewCell()
    }
    
    static func createLoadingCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "loadingCell", for: indexPath)
        return cell
    }
}
