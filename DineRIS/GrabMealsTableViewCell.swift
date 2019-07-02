//
//  GrabMealsTableViewCell.swift
//  DineRIS
//
//  Created by Ayush Sehgal on 22/11/17.
//  Copyright © 2017 Ayush Sehgal. All rights reserved.
//

import UIKit

class GrabMealsTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var grabMealsImage: UIImageView!
    @IBOutlet weak var grabMealsName: UILabel!
    @IBOutlet weak var grabMealsDescription: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
