//
//  MealsTableViewCell.swift
//  DineRIS
//
//  Created by Ayush Sehgal on 22/11/17.
//  Copyright © 2017 Ayush Sehgal. All rights reserved.
//

import UIKit

class MealsTableViewCell: UITableViewCell {
    
    //MARK: UI Element Connections
    @IBOutlet weak var mealsImage: UIImageView!
    @IBOutlet weak var mealsName: UILabel!
    @IBOutlet weak var Ratings: Ratings!
    
    var Name = String()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
