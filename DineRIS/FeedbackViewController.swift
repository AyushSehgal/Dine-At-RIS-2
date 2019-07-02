//
//  FeedbackViewController.swift
//  DineRIS
//
//  Created by Ayush Sehgal on 18/3/18.
//  Copyright © 2018 Ayush Sehgal. All rights reserved.
//

import UIKit
import MessageUI

class FeedbackViewController: UIViewController, MFMailComposeViewControllerDelegate {
    
    //MARK: Outlets that connect to the UIElements on the Page
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var messageField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: Send Button's Actions
    @IBAction func send(_ sender: Any) {
        
        let toRecipients = ["canteenmanager@rism.ac.th", "ayushs18@rism.ac.th"] //sets the recipients to the string values entered in the tuple/array
        
        let feedmessage: MFMailComposeViewController = MFMailComposeViewController() // inherits from the Mail Composition Framework in XCode
        
        feedmessage.mailComposeDelegate = self // composes a mail message for you
        
        feedmessage.setToRecipients(toRecipients) //sets the recipients to the emails stated in the toRecipients string array/tuple
        feedmessage.setSubject(nameField.text!) //sets the subject of the message to the name entered
        
        feedmessage.setMessageBody("Name: \(nameField.text!) \n\nEmail: \(emailField.text!) \n\nMessage: \(messageField.text!)", isHTML: false)
        self.present(feedmessage, animated: true, completion: nil) // show the UI elements in the view controller
    }
    
    //MARK: Cancel Feedback Form

    /*
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) { // Dismisses the FeedbackViewController and deletes the message
        
        
        switch MFMailComposeResult: Int {
        case cancelled:
            print("cancelled") //will print in the debug area of XCode
        default:
            break //ends the feedback processes
        }

        self.dismiss(animated: true, completion: nil) //dismisses the view controller
    }
 */
    
    //make sure in ios 7 or older, the keyboard is dismissed (it is automatic in 8 onwards) 
    
    @IBAction func dismissKeyboard(_ sender: Any) {
        self.resignFirstResponder() //will respond to the user's touch and will dismiss upon that initial interaction with the screen
    }
    
}
