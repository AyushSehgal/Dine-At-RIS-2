//
//  AsianFoodTableViewController.swift
//  DineRIS
//
//  Created by Ayush Sehgal on 20/12/17.
//  Copyright © 2017 Ayush Sehgal. All rights reserved.
//

import UIKit
import CloudKit
import os.log

enum selectedScopeAsian: Int {
    case mealsName = 0
}

class AsianFoodTableViewController: UITableViewController, UISearchBarDelegate  {
    
    static let MealCell = "MealCell"
    let RecordTypeMeals = "Meals"
    
    //var meals = [CKRecord]()
    
    var MealsList = [Meals]()
    var stallmeal: Meals?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // fetchMeals()
        loadMeals()
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
            loadMeals()
            self.tableView.reloadData()
        } else {
            filterTableView(ind: searchBar.selectedScopeButtonIndex, text: searchText)
        }
        
    }
    
    func filterTableView(ind: Int, text: String) {
        switch ind {
        case selectedScopeAsian.mealsName.rawValue:
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
        
        let Meals = MealsList[indexPath.row]
        cell.mealsImage.image = Meals.mealsImage
        cell.mealsName.text = Meals.mealsName
        //cell.mealsDescription.text = Meals.mealsDescription
        
        
        return cell
    }
    
    
    
    
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
    
    private func loadMeals() {
        let meal1 = UIImage(named: "Congee")
        let meal2 = UIImage(named: "Dumpling")
        let meal3 = UIImage(named: "Gyoza")
        let meal4 = UIImage(named: "Takaoyaki")
        
        guard let Congee = Meals(mealsName: "Pork Congee", mealsPrice: "Price: 35 baht", mealsDescription: "Rice Porridge with Minced Pork, Egg optional", mealsImage: meal1, rating: 0)
            else {
                fatalError("Unable to load meal")
        }
        guard let Dumpling = Meals(mealsName: "Pork Dumpling", mealsPrice: "Price: 35 baht", mealsDescription: "Chinese Style Steamed Dumpling stuffed with minced pork", mealsImage: meal2, rating: 0)
            else {
                fatalError("Unable to load meal.")
        }
        guard let Gyoza = Meals(mealsName: "Chicken Gyoza", mealsPrice: "Price: 35 baht", mealsDescription: "Chinese Style Steamed Dumpling stuffed with minced chicken", mealsImage: meal3, rating: 0)
            else {
                fatalError("Unable to load meal.")
        }
        guard let Takaoyaki = Meals(mealsName: "Takoyaki", mealsPrice: "Price: 25 baht", mealsDescription: "Breaded fried ball-shaped snack stuffed with seafood and seafood", mealsImage: meal4, rating: 0)
            else {
                fatalError("Unable to load meal.")
        }
        
        MealsList += [Congee, Dumpling, Gyoza, Takaoyaki]
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
