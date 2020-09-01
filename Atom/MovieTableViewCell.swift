//
//  MovieTableViewCell.swift
//  Atom
//
//  Created by Mikhail Polozhaev on 31/08/2020.
//  Copyright © 2020 Mikhail Polozhaev. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    
    @IBOutlet var movieImageView: UIImageView!
    
    @IBOutlet var title: UILabel!
    
    @IBOutlet var movieDescription: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
