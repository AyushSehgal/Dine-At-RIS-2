//
//  SpecialMealsViewController.swift
//  DineRIS
//
//  Created by Ayush Sehgal on 12/1/18.
//  Copyright © 2018 Ayush Sehgal. All rights reserved.
//

import UIKit
import CloudKit


class SpecialMealsViewController: UIViewController,  UITableViewDataSource, UITableViewDelegate{
    
    
    //Create the array and connect it to CloudKit
    static let ListCell = "ListCell"
    var Specials: Array<CKRecord> = []

    //Connect UI Elements in the Interface Builder to Code
    @IBOutlet weak var message: UILabel!
    @IBOutlet weak var specialsTable: UITableView!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    //Fetch the data from the Database
    func loadData() {
        
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
                    self.Specials.append(result)
                }
                
                OperationQueue.main.addOperation({ () -> Void in
                    self.specialsTable.reloadData()
                    self.specialsTable.isHidden = false
                })
            }
        }
    }
    
    // Display data in the table view
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SpecialsTableViewCell
        
        let noteRecord: CKRecord = Specials[indexPath.row]
        
        cell.specialsMealsName?.text = noteRecord.value(forKey: "name") as? String
        cell.specialsMealsDescription?.text = noteRecord.value(forKey: "description") as? String
        cell.specialsMealsImage.image = noteRecord.value(forKey:"image") as? UIImage
        
        return cell
    }
   
    //Make the table as large as the data values available in the array
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Specials.count
    }
    
    //Display Code/Data in the View Controller
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData() //call the private function that holds the data 

        
    }
   
   
    
}
