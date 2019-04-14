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
        
            FileLogic.getFile(from: movie.pictureUrl!) { filePath in
                if filePath != "" {
                    cell.imgMovie.image = UIImage(named: filePath)
                }
            }
            
            cell.lblTitle.text = "\(movie.title!) (\(movie.year!))"
            cell.lblOverview.text = movie.overview
            
            return cell
        }
        
        return UITableViewCell()
    }
}
