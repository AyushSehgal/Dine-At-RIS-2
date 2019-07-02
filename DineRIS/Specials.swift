//
//  Specials.swift
//  DineRIS
//
//  Created by Ayush Sehgal on 12/2/18.
//  Copyright © 2018 Ayush Sehgal. All rights reserved.
//

import Foundation
import UIKit

class Specials {
    
    var specialsMealsName: String
    var specialsMealsImage: UIImage?
    var specialsMealsDescription: String
    
    init?(specialsMealsName: String, specialsMealsDescription: String, specialsMealsImage: UIImage?) {
        
        guard !specialsMealsName.isEmpty else {
            return nil
        }
        
        guard !specialsMealsDescription.isEmpty else {
            return nil
        }
    
        
        //Initialize stored properties.
        self.specialsMealsName = specialsMealsName
        self.specialsMealsDescription = specialsMealsDescription
        self.specialsMealsImage = specialsMealsImage
    }
    
    
    
}

