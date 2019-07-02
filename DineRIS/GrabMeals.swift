//
//  GrabMeals.swift
//  DineRIS
//
//  Created by Ayush Sehgal on 22/11/17.
//  Copyright © 2017 Ayush Sehgal. All rights reserved.
//

import Foundation
import UIKit

class GrabMeals {
    
    var grabMealsName: String
    var grabMealsImage: UIImage?
    var grabMealsDescription: String
    
    init?(grabMealsName: String, grabMealsDescription: String, grabMealsImage: UIImage?) {
        
        guard !grabMealsName.isEmpty else {
            return nil
        }
        
        guard !grabMealsDescription.isEmpty else {
            return nil
        }
        
        //Initialize stored properties.
        self.grabMealsName = grabMealsName
        self.grabMealsDescription = grabMealsDescription
        self.grabMealsImage = grabMealsImage
    }

}
