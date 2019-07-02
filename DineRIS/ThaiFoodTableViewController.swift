//
//  ThaiFoodTableViewController.swift
//  DineRIS
//
//  Created by Ayush Sehgal on 11/11/17.
//  Copyright © 2017 Ayush Sehgal. All rights reserved.
//

import UIKit
import os.log

enum selectedScopeThai: Int {
    case mealsName = 0
}

class ThaiFoodTableViewController: UITableViewController, UISearchBarDelegate {
    
    //declare the cells for each meal
    static let MealCell = "MealCell"
    
    //create array for meals to be stored in
    var MealsList = [Meals]()
    //allow each meal to inherit from the array above
    var stallmeal: Meals?
    
    
    //function that displays data in view controller
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Load the sample data.
        loadMeals()
        self.searchBarSetup()
        
        // identities = ["trial","trial2","trial3"]
    }
    
    func searchBarSetup() {
        let searchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: (UIScreen.main.bounds.width),height: 70))
        searchBar.showsScopeBar = true
        searchBar.selectedScopeButtonIndex = 0
        
        searchBar.delegate = self
        self.tableView.tableHeaderView = searchBar
        
    }
    
    //MARK - Search Bar Delegate
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            loadMeals()
            self.tableView.reloadData()
        } else {
            filterTableView(ind: searchBar.selectedScopeButtonIndex, text: searchText)
        }
        
    }
    
    func filterTableView(ind: Int, text: String) {
        switch ind {
        case selectedScopeThai.mealsName.rawValue:
            MealsList = MealsList.filter({(mod)-> Bool in
                return mod.mealsName.lowercased().contains(text.lowercased())
            })
            self.tableView.reloadData()
        default:
            print("no type")
        }
        
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
        return MealsList.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "MealsTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? MealsTableViewCell
            else {
                fatalError("The dequeued cell is not an instance of MealsTableViewCell.")
        }
        
        let Meal = MealsList[indexPath.row]
        cell.mealsImage.image = Meal.mealsImage
        cell.mealsName.text = Meal.mealsName
        //cell.mealsDescription.text = Meals.mealsDescription
        
        
        return cell
    }
    
    @IBAction func unwindToMealList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? mealDetailViewController, let meal = sourceViewController.meal {
            
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                // Update an existing meal.
                MealsList[selectedIndexPath.row] = meal
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
            }
            else {
                // Add a new meal.
                let newIndexPath = IndexPath(row: MealsList.count, section: 0)
                
                MealsList.append(meal)
                tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
        }
    }
    
    private func loadMeals()  {
        let meal1 = UIImage(named: "Basil")
        let meal2 = UIImage(named: "PadThai")
        let meal3 = UIImage(named: "GarlicPork")
        let meal4 = UIImage(named: "FriedRice")
        
        guard let Basil = Meals(mealsName: "Khao Krapao", mealsPrice: "Price: 45 baht", mealsDescription: "Chicken, Pork, or Shrimp Fried with Basil Served with Rice", mealsImage: meal1, rating: 0)
            else {
                fatalError("Unable to load meal")
        }
        guard let PadThai = Meals(mealsName: "PadThai", mealsPrice: "Price: 50", mealsDescription: "Thai Style Noodles Tossed with Chicken or Shrimp", mealsImage: meal2, rating: 0)
            else {
                fatalError("Unable to load meal.")
        }
        guard let GarlicPork = Meals(mealsName: "Moo Kratium", mealsPrice: "Price: 45", mealsDescription: "Pork Mixed with Garlic Sauce Served with Rice", mealsImage: meal3, rating: 0)
            else {
                fatalError("Unable to load meal.")
        }
        guard let FriedRice = Meals(mealsName: "Classic Fried Rice", mealsPrice: "Price: 45", mealsDescription: "Rice Fried with Pork, Chicken, or Shrimp Mixed with Veggies", mealsImage: meal4, rating: 0)
            else {
                fatalError("Unable to load meal.")
        }
        
        MealsList += [Basil, PadThai, GarlicPork, FriedRice]
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        switch(segue.identifier ?? "") {
            
        case "AddItem":
            os_log("Adding a new meal.", log: OSLog.default, type: .debug)
            
        case "ShowDetails":
            guard let mealDetails = segue.destination as? mealDetailViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            
            guard let selectedMealCell = sender as? MealsTableViewCell else {
                fatalError("Unexpected sender: \(String(describing: sender))")
            }
            
            guard let indexPath = tableView.indexPath(for: selectedMealCell) else {
                fatalError("The selected cell is not being displayed by the table")
            }
            
            let selectedMeal = MealsList[indexPath.row]
            mealDetails.meal = selectedMeal
            
        default:
            fatalError("Unexpected Segue Identifier; \(String(describing: segue.identifier))")
        }
        
    }
    
    
    
    
    
}




