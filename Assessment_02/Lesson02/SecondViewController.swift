//
//  SecondViewController.swift
//  Lesson02
//
//  Created by Rudd Taylor on 9/28/14.
//  Copyright (c) 2014 General Assembly. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    //TODO five: Display the cumulative sum of all numbers added every time the ‘add’ button is pressed. Hook up the label, text box and button to make this work.

    // connect the text boxes and labels to this View Controller

    @IBOutlet weak var secondViewNumber: UITextField!
    @IBOutlet weak var secondViewLabel: UILabel!

    // define variables used
    
    var cumulativeValue: Int = 0
    
    // connect the button to this View Controller

    @IBAction func secondViewButton(sender: AnyObject) {
        
        // if there is a value in the secondViewNumber field
        // add value to the cumulativeValue variable
        if secondViewNumber.text != "" {
            cumulativeValue += secondViewNumber.text.toInt()!
            secondViewNumber.text = ""
            self.view.endEditing(true)
        }
        
        // change the value of the secondViewLabel
        // to the cumulativeValue integer
        secondViewLabel.text = "\(cumulativeValue)"
    }
    
    // hide the keyboard if the user taps on any other part of the screen
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        self.view.endEditing(true)
    }

}
