//
//  BakedFreshTableViewController.swift
//  DineRIS
//
//  Created by Ayush Sehgal on 27/12/17.
//  Copyright © 2017 Ayush Sehgal. All rights reserved.
//

import UIKit
import CloudKit
import os.log

enum selectedScope: Int {
    case mealsName = 0
}

class BakedFreshTableViewController: UITableViewController, UISearchBarDelegate {
    
    static let MealCell = "MealCell"
    let RecordTypeMeals = "Meals"
    
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
        case selectedScope.mealsName.rawValue:
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
       // cell.mealsDescription.text = Meals.mealsDescription
        
        
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
   
    private func loadMeals() {
        let meal1 = UIImage(named: "ChickenPie")
        let meal2 = UIImage(named: "SausagePie")
        let meal3 = UIImage(named: "BlueberryPie")
        let meal4 = UIImage(named: "ChocolatePie")
        let meal5 = UIImage(named: "ChickenSandwich")
        let meal6 = UIImage(named: "ChocChipCookie")
        let meal7 = UIImage(named: "Waffles")
        
        guard let ChickenPie = Meals(mealsName: "Chicken Pie", mealsPrice: "Price: 25 baht", mealsDescription: "Chicken with Tomato Sauce Stuffed in Puff Pastry", mealsImage: meal1, rating: 0)
            else {
                fatalError("Unable to load meal")
        }
        guard let SausagePie = Meals(mealsName: "Sausage Pie", mealsPrice: "Price: 25 baht", mealsDescription: "Steamed Chorizo Stuffed in Puff Pastry", mealsImage: meal2, rating: 0)
            else {
                fatalError("Unable to load meal")
        }
        guard let BlueberryPie = Meals(mealsName: "Blueberry Pie", mealsPrice: "Price: 25 baht", mealsDescription: "Blueberry Compote Stuffed in Puff Pastry", mealsImage: meal3, rating: 0)
            else {
                fatalError("Unable to load meal")
        }
        guard let ChocolatePie = Meals(mealsName: "Chocolate Pie", mealsPrice: "Price: 25 baht", mealsDescription: "Hershey's Chocolate Chips Stuffed in Puff Pastry", mealsImage: meal4, rating: 0)
            else {
                fatalError("Unable to load meal")
        }
        guard let ChickenSandwich = Meals(mealsName: "Chicken Sandwich", mealsPrice: "Price: 25 baht", mealsDescription: "Chicken Margherita with White Bread heated in Pie Iron", mealsImage: meal5, rating: 0)
            else {
                fatalError("Unable to load meal.")
        }
        guard let ChocChipCookie = Meals(mealsName: "Chocolate Chip Cookie", mealsPrice: "Price: 15 baht", mealsDescription: "Classic Hershey's Chocolate Chips mixed in classic cookie batter", mealsImage: meal6, rating: 0)
            else {
                fatalError("Unable to load meal.")
        }
        guard let Waffles = Meals(mealsName: "Chocolate Chip Waffle", mealsPrice: "Price: 25 baht", mealsDescription: "Classic Hershey's Chocolate Chips mixed in Classic Waffle Batter", mealsImage: meal7, rating: 0)
            else {
                fatalError("Unable to load meal.")
        }
        
        MealsList += [ChickenPie, SausagePie, BlueberryPie, ChocolatePie, ChickenSandwich, ChocChipCookie, Waffles]
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
