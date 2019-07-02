//
//  GrabMealsTableViewController.swift
//  DineRIS
//
//  Created by Ayush Sehgal on 19/11/17.
//  Copyright © 2017 Ayush Sehgal. All rights reserved.
//

import UIKit
import CloudKit

class GrabMealsTableViewController: UITableViewController {
    
    static let GrabMealCell = "GrabMealCell"
    let RecordTypeGrabMeals = "GrabMeals"
    
    var grabMeal: GrabGo?
    var grabMeals = [CKRecord]()
    
    var grabMealList = [GrabMeals]()

    override func viewDidLoad() {
        super.viewDidLoad()

        //fetchGrabMeals()
        loadGrabMeals()
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
        return grabMealList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "GrabMealsTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? GrabMealsTableViewCell
            else {
                fatalError("The dequeued cell is not an instance of GrabMealsTableViewCell.")
        }
        
        let grabMeals = grabMealList[indexPath.row]
        cell.grabMealsImage.image = grabMeals.grabMealsImage
        cell.grabMealsName.text = grabMeals.grabMealsName
        cell.grabMealsDescription.text = grabMeals.grabMealsDescription
        
        
        /*
        let cell = tableView.dequeueReusableCell(withIdentifier: GrabMealsTableViewController.GrabMealCell, for: indexPath)

        
        // Configure the cell
        cell.accessoryType = .detailDisclosureButton
        
        //Fetch Record
        let grabMeal = grabMeals[indexPath.row]
        
        if let grabMealName = grabMeal.object(forKey: "name") as? String {
            //Configure cell
            cell.textLabel?.text = grabMealName
        } else {
            cell.textLabel?.text = "-"
        }
        */

        return cell
    }
    
    /*
    //MARK: Helper Methods
    private func fetchGrabMeals() {
        let privateDatabase = CKContainer.default().privateCloudDatabase
        
        let query = CKQuery(recordType: RecordTypeGrabMeals, predicate: NSPredicate(format: "TRUEPREDICATE"))
        
        query.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        
        privateDatabase.perform(query, inZoneWith: nil) { (records, error) -> Void in
            DispatchQueue.main.async(execute: { () -> Void in
            })
        }
    }
     */
 

    private func loadGrabMeals() {
        let grabMeals1 = UIImage(named: "Fries")
        let grabMeals2 = UIImage(named: "Quesadilla")
        let grabMeals3 = UIImage(named: "MeatFries")
        
        guard let Fries = GrabMeals(grabMealsName: "French Fries", grabMealsDescription: "Price: 35 baht", grabMealsImage: grabMeals1)
            else {
                fatalError("Unable to load meal")
        }
        guard let Quesadilla = GrabMeals(grabMealsName: "Chicken Quesadilla", grabMealsDescription: "Price: 45 Baht", grabMealsImage: grabMeals2)
            else {
                fatalError("Unable to load meal")
        }
        guard let MeatFries = GrabMeals(grabMealsName: "Chicken Steak with Fries", grabMealsDescription: "Price: 50 baht", grabMealsImage: grabMeals3)
            else {
                fatalError("Unable to load meal")
        }
        
        grabMealList += [Fries, Quesadilla, MeatFries]
        
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
