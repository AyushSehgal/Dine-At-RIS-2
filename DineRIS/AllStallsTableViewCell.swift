//
//  AllStallsTableViewCell.swift
//  DineRIS
//
//  Created by Ayush Sehgal on 29/10/17.
//  Copyright © 2017 Ayush Sehgal. All rights reserved.
//

import Foundation
import UIKit

class AllStallsTableViewCell: UITableViewCell {
    
    //MARK: Storyboard Connections
    @IBOutlet weak var photoImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        //sets asseccibility for the image view so that it can be read by voiceover
        photoImageView.isAccessibilityElement = true
        //photoImageView.accessibilityLabel = photoImageView.rawValue
        photoImageView.accessibilityTraits = UIAccessibilityTraitImage
    }
    
}




