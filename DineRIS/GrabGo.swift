//
//  GrabGo.swift
//  DineRIS
//
//  Created by Ayush Sehgal on 29/10/17.
//  Copyright © 2017 Ayush Sehgal. All rights reserved.
//

import Foundation
import UIKit

//modal class
class GrabGo {

    // sets the variables the view controller will use 
    var grabStallName: String
    var grabGoStallPhoto: UIImage?
    
    //MARK: Initialization
    
    init?(grabStallName: String, grabGoStallPhoto: UIImage?) {
        
        guard !grabStallName.isEmpty else {
            return nil
        }
        
        
        //Initialize stored properties.
        self.grabStallName = grabStallName
        self.grabGoStallPhoto = grabGoStallPhoto
    }
    
}

