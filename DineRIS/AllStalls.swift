//
//  AllStalls.swift
//  DineRIS
//
//  Created by Ayush Sehgal on 29/10/17.
//  Copyright © 2017 Ayush Sehgal. All rights reserved.
//

import Foundation
import UIKit

//modal class
class AllStalls {
    
    //sets the variables the view controller will deal with 
    var stallName: String
    var allStallPhoto: UIImage?
    
    //MARK: Archiving Paths
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("meals")
    

    
    //MARK: Initialization
    
    init?(stallName: String, allStallPhoto: UIImage?) {
        
        // The name must not be empty
        guard !stallName.isEmpty else {
            return nil
        }
 
        //Initialize stored properties.
        self.stallName = stallName
        self.allStallPhoto = allStallPhoto
    }
    
}

