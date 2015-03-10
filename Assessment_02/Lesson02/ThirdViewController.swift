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
    
    @IBOutlet weak var thirdViewNumber: UITextField!
    @IBOutlet weak var thirdViewLabel: UILabel!
    
    @IBAction func thirdViewButton(sender: AnyObject) {
        if thirdViewNumber.text != "" {
            
            var numberChecked: Int = thirdViewNumber.text.toInt()!

            if numberChecked%2 == 0 {
                thirdViewLabel.text = "The number \(numberChecked) is even."
            } else {
                thirdViewLabel.text = "The number \(numberChecked) is not even."
            }
            
            thirdViewNumber.text = ""
            self.view.endEditing(true)
            
        } else {
            thirdViewLabel.text = "Please enter a number."
            thirdViewNumber.becomeFirstResponder()
        }
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        self.view.endEditing(true)
    }

}
