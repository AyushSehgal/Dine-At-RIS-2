//
//  SpecialsBackUpTableViewController.swift
//  DineRIS
//
//  Created by Ayush Sehgal on 12/2/18.
//  Copyright © 2018 Ayush Sehgal. All rights reserved.
//

import UIKit
import os.log

class SpecialsBackUpTableViewController: UITableViewController {
    
    //declare the cells for each meal
    static let MealCell = "MealCell"
    
    //create array for meals to be stored in
    var SpecialsMealsList = [Specials]()
    //allow each meal to inherit from the array above
    var Specialsstallmeal: Specials?
    
    
    //function that displays data in view controller
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Load the sample data.
        loadMeals()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return SpecialsMealsList.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "SpecialsTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? SpecialsTableViewCell
            else {
                fatalError("The dequeued cell is not an instance of SpecialsTableViewCell.")
        }
        
        let Special = SpecialsMealsList[indexPath.row]
        cell.specialsMealsImage.image = Special.specialsMealsImage
        cell.specialsMealsName.text = Special.specialsMealsName
        cell.specialsMealsDescription.text = Special.specialsMealsDescription
        
        
        return cell
    }
        
    
    private func loadMeals()  {
        let specialsMeal1 = UIImage(named: "RedPork")
        let specialsMeal2 = UIImage(named: "Brownie")
        let specialsMeal3 = UIImage(named: "FruitPunch")
        let specialsMeal4 = UIImage(named: "OreoSmoothie")
        
        guard let RedPork = Specials(specialsMealsName: "Red Pork with Rice", specialsMealsDescription: "Red Pork mixed with Sweet Chinese Sauce and Rice", specialsMealsImage: specialsMeal1)
            else {
                fatalError("Unable to load meal")
        }
        guard let Brownie = Specials(specialsMealsName: "Classic Brownie", specialsMealsDescription: "Fudge made with melted milk chocolate", specialsMealsImage: specialsMeal2)
            else {
                fatalError("Unable to load meal")
        }
        guard let FruitPunch = Specials(specialsMealsName: "Fruit Punch", specialsMealsDescription: "Tropic punch mixed with pineapple, apples, watermelon, and mango", specialsMealsImage: specialsMeal3)
            else {
                fatalError("Unable to load meal")
        }
        guard let OreoSmoothie = Specials(specialsMealsName: "Oreo Smoothie", specialsMealsDescription: "Oreo cookies blended with milk and chocolate sauce", specialsMealsImage: specialsMeal4)
            else {
                fatalError("Unable to load meal")
        }
        
        SpecialsMealsList += [RedPork, Brownie, FruitPunch, OreoSmoothie]
    }
    
   
    
    
    
    
    
}

