//
//  GrabGoTableViewController.swift
//  DineRIS
//
//  Created by Ayush Sehgal on 29/10/17.
//  Copyright © 2017 Ayush Sehgal. All rights reserved.
//

import UIKit
import os.log
import CloudKit

class GrabGoTableViewController: UITableViewController {
    
    //MARK: Initial data loading and set up
    var grabGoStallsList = [GrabGo]()
    var identities = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()

        loadGrabGoStalls() //loads the method with the data below 
        identities = ["Baked","Be","Asian"] //allow instantiations from stall images to appropriate view controllers
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return grabGoStallsList.count //makes sure the rows are not finite and will expand with the array
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier1 = "GrabGoTableViewCell" //inherits from the designs specified in the AllStallsTableViewCell file
        
        guard let cell1 = tableView.dequeueReusableCell(withIdentifier: cellIdentifier1, for: indexPath) as? GrabGoTableViewCell
            else {
                fatalError("The dequeued cell is not an instance of GrabGoTableViewCell.")
        }
        
        let grabStall = grabGoStallsList[indexPath.row] //allows the row elements to be queriable
        
        cell1.grabStallImage.image = grabStall.grabGoStallPhoto //makes sure the images are displayed in the rows
        
        return cell1
    }
    
    //makes sure the stall images are clickable and will instantiate appropriate viewcontrollers
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let grabMealLists = identities[indexPath.row]
        let grabMealDisplay = storyboard?.instantiateViewController(withIdentifier: grabMealLists)
        self.navigationController?.pushViewController(grabMealDisplay!, animated: true)
        
    }
    
   
    //MARK: Private Methods
    
    private func loadGrabGoStalls() { // connects the variables to the images in assets page
        let grabStall1 = UIImage(named: "bakedFresh")
        let grabStall2 = UIImage(named: "beChoices")
        let grabStall3 = UIImage(named: "asianFood")
        
        // connects each asset to a name and image defined above
        guard let bakedFresh = GrabGo(grabStallName: "Baked Fresh", grabGoStallPhoto: grabStall1) else {
            fatalError("Unable to load meal") //sets failure message for developer
        }
        guard let beChoices = GrabGo(grabStallName: "Be Choices", grabGoStallPhoto: grabStall2) else {
            fatalError("Unable to load meal")
        }
        guard let asianFood = GrabGo(grabStallName: "Asian Food", grabGoStallPhoto: grabStall3) else {
            fatalError("Unable to load meal")
        }
        
        grabGoStallsList += [bakedFresh, beChoices, asianFood] // adds all the values to the overarching array
        
    }

    

    
}


