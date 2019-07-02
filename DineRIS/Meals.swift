//
//  Meals.swift
//  DineRIS
//
//  Created by Ayush Sehgal on 22/11/17.
//  Copyright © 2017 Ayush Sehgal. All rights reserved.
//

import Foundation
import UIKit
import os.log

//MARK: Modal Class
class Meals {
    
    //Setting Variables to Store Data from Cloudkit
    var mealsName: String
    var mealsImage: UIImage?
    var mealsPrice: String
    var mealsDescription: String
    var rating: Int
    

  
    //Initializing all variables to ensure they are ready to accept data values
    //Ensures the values return empty if they do not have data within them 
    init?(mealsName: String, mealsPrice: String, mealsDescription: String, mealsImage: UIImage?, rating: Int) {
        
        guard !mealsName.isEmpty else {
            return nil
        }
        
        guard !mealsPrice.isEmpty else {
            return nil
        }
        
        guard !mealsDescription.isEmpty else {
            return nil
        }
        
        // The rating must be between 0 and 5 inclusively
        guard (rating >= 0) && (rating <= 5) else {
            return nil
        }
        
        //Initialize stored properties.
        self.mealsName = mealsName
        self.mealsPrice = mealsPrice
        self.mealsDescription = mealsDescription
        self.mealsImage = mealsImage
        self.rating = rating
    }
   

    
    
}
