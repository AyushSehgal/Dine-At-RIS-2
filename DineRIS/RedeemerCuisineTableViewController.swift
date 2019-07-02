//
//  RedeemerCuisineTableViewController.swift
//  DineRIS
//
//  Created by Ayush Sehgal on 11/11/17.
//  Copyright © 2017 Ayush Sehgal. All rights reserved.
//

import UIKit
import os.log

enum selectedScopeRedeemer: Int {
    case mealsName = 0
}

class RedeemerCuisineTableViewController: UITableViewController, UISearchBarDelegate {
    
    //declare the cells for each meal
    static let MealCell = "MealCell"
    
    //create array for meals to be stored in
    var MealsList = [Meals]()
    //allow each meal to inherit from the array above
    var stallmeal: Meals?
    
    
    //function that displays data in view controller
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadRedeemerMeals()
        self.searchBarSetup()
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
            loadRedeemerMeals()
            self.tableView.reloadData()
        } else {
            filterTableView(ind: searchBar.selectedScopeButtonIndex, text: searchText)
        }
        
    }
    
    func filterTableView(ind: Int, text: String) {
        switch ind {
        case selectedScopeRedeemer.mealsName.rawValue:
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
  
   
    private func loadRedeemerMeals()  {
        let meal1 = UIImage(named: "Bolo")
        let meal2 = UIImage(named: "Carbonara")
        let meal3 = UIImage(named: "Seafood")
        let meal4 = UIImage(named: "Ceasar")
        let meal5 = UIImage(named: "Tuna")
        
        guard let Bolo = Meals(mealsName: "Spaghetti Bolognese", mealsPrice: "Price: 45 baht", mealsDescription: "Chicken mixed with Tomato Sauce and Linguine Pasta", mealsImage: meal1, rating: 0)
            else {
                fatalError("Unable to load meal")
        }
        guard let Carbonara = Meals(mealsName: "Spaghetti Carbonara", mealsPrice: "Price: 85", mealsDescription: "Ham mixed with Cream Sauce, Mushrooms, and Linguine Pasta", mealsImage: meal2, rating: 0)
            else {
                fatalError("Unable to load meal.")
        }
        guard let Seafood = Meals(mealsName: "Spaghetti Seafood", mealsPrice: "Price: 85", mealsDescription: "Shrimp and Squid mixed with Cream Sauce, Mushrooms, and Linguine Pasta", mealsImage: meal3, rating: 0)
            else {
                fatalError("Unable to load meal.")
        }
        guard let Ceasar = Meals(mealsName: "Ceasar Salad", mealsPrice: "Price: 75", mealsDescription: "Lettuce, Tomato, Crouton, Feta Cheese, Rocket Leaves and Ceasar Dressing", mealsImage: meal4, rating: 0)
            else {
                fatalError("Unable to load meal.")
        }
        guard let Tuna = Meals(mealsName: "Tuna Salad", mealsPrice: "Price: 75", mealsDescription: "Lettuce, Tomato, Crouton, Feta Cheese, Rocket Leaves, Minced Tuna, and Italian Dressing", mealsImage: meal5, rating: 0)
            else {
                fatalError("Unable to load meal.")
        }
        
        MealsList += [Bolo, Carbonara, Seafood, Ceasar, Tuna]
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


