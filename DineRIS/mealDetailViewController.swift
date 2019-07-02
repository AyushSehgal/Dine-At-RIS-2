//
//  mealDetailViewController.swift
//  DineRIS
//
//  Created by Ayush Sehgal on 20/12/17.
//  Copyright © 2017 Ayush Sehgal. All rights reserved.
//

import UIKit
import os.log

class mealDetailViewController: UIViewController {

    //variable inherits from the Meals Modal Class
    var meal: Meals?
    
    //MARK: UI Elements
    @IBOutlet weak var mealTitle: UILabel!
    @IBOutlet weak var mealDescriptor: UILabel!
    @IBOutlet weak var mealImage: UIImageView!
    @IBOutlet weak var Ratings: Ratings!
    @IBOutlet weak var saveMeal: UIBarButtonItem!
    @IBOutlet weak var mealPrice: UILabel!
    @IBOutlet weak var Order: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let meal = meal { // equates and transfers the values stored in the cloudkit variables to those that will show in the mealDetailViewController
            mealTitle.text = meal.mealsName
            mealPrice.text = meal.mealsPrice
            mealDescriptor.text = meal.mealsDescription
            mealImage.image = meal.mealsImage
            Ratings.rating = meal.rating
        }
        //Sets the accessibility of the mealTitles for VoiceOver to Use
        if mealTitle.text == "" {
            mealTitle.isAccessibilityElement = true
            mealTitle.accessibilityLabel = "Title of Meal"
            mealTitle.accessibilityTraits = UIAccessibilityTraitHeader
            mealTitle.accessibilityLanguage = "พายไก่"
        }
        
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        // Configure the destination view controller only when the save button is pressed.
        guard let button = sender as? UIBarButtonItem, button === saveMeal else {
            os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
            return
        }
        
        // makes sure the values are transfered from cloudkit variables to the UI variables
        let mealsName = mealTitle.text ?? ""
        let mealsPrice = mealPrice.text ?? ""
        let mealsDescription = mealDescriptor.text ?? ""
        let mealsImage = mealImage.image
        let rating = Ratings.rating
        
        // Set the meal to be passed to MealTableViewController after the unwind segue.
        meal = Meals(mealsName: mealsName, mealsPrice: mealsPrice, mealsDescription: mealsDescription, mealsImage: mealsImage, rating: rating)
    }
    
    //Connects the UIButton to a URL opener
    @IBAction func Order(_ sender: UIButton) {
        if let url = NSURL(string: "https://mail.google.com/mail/?view=cm&fs=1&to=canteenmanager@rism.ac.th&su=SUBJECT&body=BODY") {
            UIApplication.shared.openURL(url as URL)
        }
    }
    
    //MARK: Cancel Button
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        // Depending on style of presentation (modal or push presentation), this view controller needs to be dismissed in two different ways.
        let isPresentingInAddMealMode = presentingViewController is UINavigationController
        
        if isPresentingInAddMealMode {
            dismiss(animated: true, completion: nil)
        }
        else if let owningNavigationController = navigationController{
            owningNavigationController.popViewController(animated: true)
        }
        else {
            fatalError("The MealViewController is not inside a navigation controller.")
        }
    

    }
    
    

    
    
   

    
}
