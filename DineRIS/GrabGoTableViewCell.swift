//
//  GrabGoTableViewCell.swift
//  DineRIS
//
//  Created by Ayush Sehgal on 12/11/17.
//  Copyright © 2017 Ayush Sehgal. All rights reserved.
//

import Foundation
import UIKit

class GrabGoTableViewCell: UITableViewCell {
    
    //MARK: Storyboard Connections
    
    @IBOutlet weak var grabStallImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        //ensures voiceover can read the stall names 
        grabStallImage.isAccessibilityElement = true
        grabStallImage.accessibilityLabel = "Canteen Banner"
        grabStallImage.accessibilityTraits = UIAccessibilityTraitImage
    }
    
}



