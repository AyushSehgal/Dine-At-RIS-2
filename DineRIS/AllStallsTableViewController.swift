//
//  AllStallsTableViewController.swift
//  DineRIS
//
//  Created by Ayush Sehgal on 29/10/17.
//  Copyright © 2017 Ayush Sehgal. All rights reserved.
//

import UIKit
import os.log
import CloudKit

class AllStallsTableViewController: UITableViewController {
    
    //MARK: Initial data loading and set up
    var allStallsList = [AllStalls]()
    var stall: AllStalls?
    var identities = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
  
        loadCanteenStalls() //loads the method with the data below 
        identities = ["Asian","Baked","Be","Danebury","Redeemer","Steak","Thai"] //allow instantiations from stall images to appropriate view controllers

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allStallsList.count //makes sure the rows are not finite and will expand with the array
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "AllStallsTableViewCell" //inherits from the designs specified in the AllStallsTableViewCell file
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? AllStallsTableViewCell
            else {
                fatalError("The dequeued cell is not an instance of AllStallsTableViewCell.")
        }
        
        let stall = allStallsList[indexPath.row] //allows the row elements to be queriable
        
        cell.photoImageView.image = stall.allStallPhoto //makes sure the images are displayed in the rows

        return cell
    }
    
    //makes sure the stall images are clickable and will instantiate appropriate viewcontrollers
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let mealLists = identities[indexPath.row]
        let mealDisplay = storyboard?.instantiateViewController(withIdentifier: mealLists)
        self.navigationController?.pushViewController(mealDisplay!, animated: true)
    }
    
    
    
    
   //MARK: Private Methods
    
    private func loadCanteenStalls() { // connects the variables to the images in assets page
        let stall1 = UIImage(named: "asianFood")
        let stall2 = UIImage(named: "bakedFresh")
        let stall3 = UIImage(named: "beChoices")
        let stall4 = UIImage(named: "danebury")
        let stall5 = UIImage(named: "redeemerCuisine")
        let stall6 = UIImage(named: "steakBooth")
        let stall7 = UIImage(named: "thaiKitchen")
        
        // connects each asset to a name and image defined above
        guard let asianFood = AllStalls(stallName: "Asian Food", allStallPhoto: stall1) else {
            fatalError("Unable to load meal") //sets failure message for developer
        }
        guard let bakedFresh = AllStalls(stallName: "Baked Fresh", allStallPhoto: stall2) else {
            fatalError("Unable to load meal")
        }
        guard let beChoices = AllStalls(stallName: "Be Choices", allStallPhoto: stall3) else {
            fatalError("Unable to load meal")
        }
        guard let danebury = AllStalls(stallName: "Danebury", allStallPhoto: stall4) else {
            fatalError("Unable to load meal")
        }
        guard let redeemerCuisine = AllStalls(stallName: "Redeemer Cuisine", allStallPhoto: stall5) else {
            fatalError("Unable to load meal")
        }
        guard let steakBooth = AllStalls(stallName: "Steak Booth", allStallPhoto: stall6) else {
            fatalError("Unable to load meal")
        }
        guard let thaiKitchen = AllStalls(stallName: "Thai Kitchen", allStallPhoto: stall7) else {
            fatalError("Unable to load meal")
        }
        
        allStallsList += [asianFood, bakedFresh, beChoices, danebury, redeemerCuisine, steakBooth, thaiKitchen] // adds all the values to the overarching array
    }
    

}
