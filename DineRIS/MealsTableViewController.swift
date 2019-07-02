//
//  RedeemerCuisineTableViewController.swift
//  DineRIS
//
//  Created by Ayush Sehgal on 11/11/17.
//  Copyright © 2017 Ayush Sehgal. All rights reserved.
//
/*
import UIKit
import os.log
import CloudKit

enum selectedScopeMeals: Int {
    case mealsName = 0
}

class MealsTableViewController: UITableViewController, UISearchBarDelegate {
    
    //declare the cells for each meal
    static let MealCell = "MealCell"
    
    //Create the array and connect it to CloudKit
    var MealsList: Array<CKRecord> = []
    //allow each meal to inherit from the modal class "Meal"
    var stallmeal: Meals?
    
    
    //function that displays data in view controller
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadMealData()
        self.searchBarSetup()
    }
    
    // Develops UI for Search Bar
    func searchBarSetup() {
        let searchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: (UIScreen.main.bounds.width),height: 70)) //sets size boundaries
        searchBar.showsScopeBar = true //displays the bar
        searchBar.selectedScopeButtonIndex = 0 //connects to the enumeration
        
        searchBar.delegate = self // conforms to the framework established by UISearchBar
        self.tableView.tableHeaderView = searchBar //presents the bar in the header
        
    }
    
    //MARK - Search Bar Delegate
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            loadMealData() //load all the data values in the array if there is nothing inputted
            self.tableView.reloadData()
        } else {
            filterTableView(ind: searchBar.selectedScopeButtonIndex, text: searchText) //instantiate the filterTableView function
        }
        
    }
    
    //Will filter through the array values
    func filterTableView(ind: Int, text: String) {
        switch ind {
        case selectedScopeMeals.mealsName.rawValue: //searches the actual string entered into the mealsName defined in Modal class "Meals"
            MealsList = MealsList.filter({(mod)-> Bool in
                return mod.mealsName.lowercased().contains(text.lowercased()) //ensures search is not case sensitive
            })
            self.tableView.reloadData()
        default:
            print("no type") //mandatory fail statement
        }
        
    }


    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1 //one group of data will be displayed in the single table view
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MealsList.count //does not limit the number of rows to a finite value but to the amount of data entered into the CloudKit Array
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "MealsTableViewCell" // connects the cells to the file specified for the cell
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? MealsTableViewCell //reuses the structure created in the MealsTableViewCell file
            else {
                fatalError("The dequeued cell is not an instance of MealsTableViewCell.") //default error statement for failed case
        }
        
        //transfers what is in the variables with the cloudkit data to the variables in the UI View
        let Meal = MealsList[indexPath.row]
        cell.mealsImage.image = Meal.mealsImage
        cell.mealsName.text = Meal.mealsName
        
        return cell
    }
    // Connect and pass data between the meal table view controller and the detail view controller
    @IBAction func unwindToMealList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? mealDetailViewController, let meal = sourceViewController.meal { //set the source of the data being sent to the detail view controller as the end view controller (the reciever)
            
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
  
    //Fetch the data from the Database
    func loadMealData() {
        
        let container = CKContainer.default()
        let privateDatabase = container.privateCloudDatabase
        let predicate = NSPredicate(value: true)
        
        let query = CKQuery(recordType: "Redeemer", predicate: predicate)
        
        privateDatabase.perform(query, inZoneWith: nil) { (results, error) -> Void in
            if error != nil {
                print(error as Any)
            }
            else {
                print(results as Any)
                
                for result in results! {
                    self.Redeemer.append(result)
                }
                
                OperationQueue.main.addOperation( { () -> Void in
                    self.MealsTableViewController.reloadData()
                    self.MealsTableViewController.isHidden = false
                })
              }
            }
        }
    
    //Display Data in the Table View
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: IndexPath) as! MealsTableViewCell // makes the cell variable conform to the cell requirements specified in the MealsTableViewCell file
        
        let noteRecord: CKRecord = Redeemer[IndexPath.row] // lets the rows query the database named Redeemer
        
        // recieves the value for each particular variable that is inputted in CloudKit and stores it in the UIElement Variables
        cell.MealsName?.text = noteRecord.value(forKey: "name") as? String
        cell.MealsDescription?.text = noteRecord.value(forKey: "description") as? String
        cell.MealsImage?.image = noteRecord.value(forKey: "image") as? UIImage
        
        return cell
    }
  
    
    // MARK: - Navigation
    
    // Preparation before segues take place
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        switch(segue.identifier ?? "") {
            
        case "ShowDetails": // segue titled "ShowDetails" will send the appropriate data across the view controllers
            guard let mealDetails = segue.destination as? mealDetailViewController else { //sends the data to the meal detail view controller
                fatalError("Unexpected destination: \(segue.destination)") //default error statement in case the data cannot be sent beccause it cannot find the destination (meal detail view controller)
            }
            
            guard let selectedMealCell = sender as? MealsTableViewCell else { // the data is stored in the cells located on the MealsTableViewController so that is the container that will send the data over
                fatalError("Unexpected sender: \(String(describing: sender))")
            }
            
            guard let indexPath = tableView.indexPath(for: selectedMealCell) else { // ensures the rows can be accessed and are editable or queriable
                fatalError("The selected cell is not being displayed by the table")
            }
            
            let selectedMeal = MealsList[indexPath.row] //Queries the MealsList Data Returning from CloudKit
            mealDetails.meal = selectedMeal // transferes the data to the detail page based on the meal that is selected by the user
            
        default:
            fatalError("Unexpected Segue Identifier; \(String(describing: segue.identifier))")
        }
        
    }
        

    

}


*/
