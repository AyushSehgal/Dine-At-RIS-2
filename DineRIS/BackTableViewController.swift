//
//  BackTableViewController.swift
//  DineRIS
//
//  Created by Ayush Sehgal on 9/3/18.
//  Copyright © 2018 Ayush Sehgal. All rights reserved.
//

import Foundation

class BackTableViewController: UITableViewController {
    
    var TableArray = [String]()
    var identities = [String]()
    
    override func viewDidLoad() {
        TableArray = ["Hello","Second"]
        identities = ["AllStalls", "GrabGo"]
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TableArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableArray[indexPath.row], for: indexPath) as UITableViewCell
        
        cell.textLabel?.text = TableArray[indexPath.row]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let mealLists = identities[indexPath.row]
        let mealDisplay = storyboard?.instantiateViewController(withIdentifier: mealLists)
        self.navigationController?.pushViewController(mealDisplay!, animated: true)
    }
}
