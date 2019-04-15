//
//  MovieCell.swift
//  moviesnow
//
//  Created by Alfaro, Diego on 9/04/19.
//  Copyright © 2019 IQVIA. All rights reserved.
//

import UIKit

class MovieCell: UITableViewCell {

    //UI Controls
    @IBOutlet weak var imgMovie: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblOverview: MarqueeTextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
