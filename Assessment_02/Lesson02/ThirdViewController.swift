//
//  ThirdViewController.swift
//  Lesson02
//
//  Created by Rudd Taylor on 9/28/14.
//  Copyright (c) 2014 General Assembly. All rights reserved.
//

import UIKit

class ThirdViewController: UIViewController {
/*
    TODO six: Hook up the number input text field, button and text label to this class. When the button is pressed, a message should be printed to the label indicating whether the number is even.

*/
    
    // connect the text boxes and labels to this View Controller
    
    @IBOutlet weak var thirdViewNumber: UITextField!
    @IBOutlet weak var thirdViewLabel: UILabel!
    
    // connect the button to this View Controller
    
    @IBAction func thirdViewButton(sender: AnyObject) {
        
        // if there is a value in the thirdViewNumber field
        // create a variable to store the integer to be checked
        if thirdViewNumber.text != "" {
            
            var numberChecked: Int = thirdViewNumber.text.toInt()!
            
            // check if the number is even by considering the
            // leftover value from the modulus of 2
            // change the value of the thirdViewLabel to the
            // string indicating the result

            if numberChecked%2 == 0 {
                thirdViewLabel.text = "The number \(numberChecked) is even."
            } else {
                thirdViewLabel.text = "The number \(numberChecked) is not even."
            }
            
            // clear the thirdViewNumber field and
            // hide the keyboard with self.view.endEditing(true)
            thirdViewNumber.text = ""
            self.view.endEditing(true)
            
        } else {
            
            // request a number if there is no number in thirdNumberView
            // when thirdViewButton is tapped. Bring focus to the
            // thirdNumberView with .becomeFirstResponder()
            thirdViewLabel.text = "Please enter a number."
            thirdViewNumber.becomeFirstResponder()
        }
    }
    
    // hide the keyboard if the user taps on any other part of the screen
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        self.view.endEditing(true)
    }

}
