//
//  SpecialsTableViewCell.swift
//  DineRIS
//
//  Created by Ayush Sehgal on 7/2/18.
//  Copyright © 2018 Ayush Sehgal. All rights reserved.
//

import UIKit

class SpecialsTableViewCell: UITableViewCell {
   
    @IBOutlet weak var specialsMealsName: UILabel!
    @IBOutlet weak var specialsMealsImage: UIImageView!
    @IBOutlet weak var specialsMealsDescription: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
