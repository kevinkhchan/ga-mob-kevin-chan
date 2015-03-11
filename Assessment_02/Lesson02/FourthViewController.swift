//
//  FourthViewController.swift
//  Lesson02
//
//  Created by Rudd Taylor on 9/28/14.
//  Copyright (c) 2014 General Assembly. All rights reserved.
//

import UIKit

class FourthViewController: UIViewController {
/*
    TODO seven: Hook up the text input box, label and and a ‘calculate’ button. Create a ‘fibonacci adder’ class with a method ‘fibonacciNumberAtIndex' which takes indexOfFibonacciNumber (an integer).  When the button is pressed, create an instance of that class, call the method, and print out the appropriate fibonacci number of an inputted integer.
    The first fibonacci number is 0, the second is 1, the third is 1, the fourth is two, the fifth is 3, the sixth is 5, etc. The Xth fibonacci number is the sum of the X-1th fibonacci number and the X-2th fibonacci number.
*/
    
    // connect the text boxes and labels to this View Controller
    
    @IBOutlet weak var fourthViewNumber: UITextField!
    @IBOutlet weak var fourthViewLabel: UILabel!
    
    // define variables used

    var indexNumber: Int = 0
    
    // connect the button to this View Controller
    
    @IBAction func fourthViewButton(sender: AnyObject) {
        
        /*
        Use if statement to check if either fourthViewNumber
        field is empty. Request user to provide details if required. 
        Use .becomeFirstResponder() to focus on the appropriate field.
        */
        if fourthViewNumber.text.isEmpty {
            fourthViewLabel.text = "Please enter a number"
            fourthViewNumber.becomeFirstResponder()
        }
        else {
            // allocate the value from fourthViewNumber
            // to the variable indexNumber as an integer
            indexNumber = fourthViewNumber.text.toInt()!
            
            // declare a new variabel fibonacciNumber and allocate
            // the value determined by the class FibonacciAdder using
            // the value of indexNumber
            var fibonacciNumber = FibonacciAdder(indexOfFibonacciNumber: indexNumber)
            
            // change the value of the fourthViewLabel to display
            // the Fibonacci number matching the index value provided
            fourthViewLabel.text = "The Fibonacci number is \(fibonacciNumber.fibonacciNumberAtIndex)"
        }
        
    }
    
    // hide the keyboard if the user taps on any other part of the screen
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        self.view.endEditing(true)
    }

}
