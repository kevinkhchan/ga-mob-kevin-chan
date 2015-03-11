//
//  FirstViewController.swift
//  Lesson02
//
//  Created by Rudd Taylor on 9/28/14.
//  Copyright (c) 2014 General Assembly. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
    /*
    TODO one: hook up a button in interface builder to a new function (to be written) in this class. Also hook up the label to this class. When the button is clicked, the function to be written must make a label say ‘hello world!’
    
    TODO two: Connect the ‘name’ and ‘age’ text boxes to this class. Hook up the button to a NEW function (in addition to the function previously defined). That function must look at the string entered in the text box and print out “Hello {name}, you are {age} years old!”
    TODO three: Hook up the button to a NEW function (in addition to the two above). Print “You can drink” below the above text if the user is above 21. If they are above 18, print “you can vote”. If they are above 16, print “You can drive”
    TODO four: Hook up the button to a NEW function (in additino to the three above). Print “you can drive” if the user is above 16 but below 18. It should print “You can drive and vote” if the user is above 18 but below 21. If the user is above 21, it should print “you can drive, vote and drink (but not at the same time!”.
    */
    
    // connect the text boxes and labels to this View Controller
    
    @IBOutlet weak var firstViewName: UITextField!
    @IBOutlet weak var firstViewAge: UITextField!
    @IBOutlet weak var firstViewLabel: UILabel!
    
    // define variables used
    
    var userName: String = ""
    var userAge: Int = 0
    var labelOutput: String = ""

    // connect the button to this View Controller
    
    @IBAction func firstViewButton(sender: AnyObject) {
        
        // run the intitialGreeting function when the
        // firstViewButton is tapped
        
        initialGreeting()
        
        /* 
            Use if statement to check if either Name or Age
            text fields are empty. Request user to provide
            details if required. Use .becomeFirstResponder()
            to focus on the appropriate field. Use 
            self.view.endEditing(true) to hide the keyboard.
        */
        if firstViewName.text.isEmpty {
            errorMessage("Name")
            firstViewName.becomeFirstResponder()
        } else if firstViewAge.text.isEmpty {
            errorMessage("Age")
            firstViewAge.becomeFirstResponder()
        } else {
            
            // populate variables with user entry
            userName = firstViewName.text
            userAge = firstViewAge.text.toInt()!
            
            // call on the different functions matching ToDo
            userGreeting(userName, age: userAge)
            userCanDo(userAge)
            userAbleToDo(userAge)
            
            // change the value of the firstViewLabel
            // with the labelOutput string
            firstViewLabel.text = labelOutput
            self.view.endEditing(true)
        }
        
    }
    
    func initialGreeting() {
        // set the labelOutput string to "Hello, World!"
        labelOutput = "Hello, World!"
    }
    
    func errorMessage(errorField: String) {
        // set the labelOutput string to the appropriate
        // error message
        labelOutput = "Please enter your \(errorField)!"
        firstViewLabel.text = labelOutput
        initialGreeting()
    }

    func userGreeting(name: String, age: Int) {
        // append to the labelOutput string the greeting
        // using the name string and age integer
        labelOutput += "\r Hello \(name), you are \(age) years old!"
    }
    
    func userCanDo(age: Int) {
        // check the age integer and append the required comment
        // to the labelOutput string
        if age > 21 {
            labelOutput += "\r You can drink."
        } else if age > 18 {
            labelOutput += "\r You can vote."
        } else if age > 16 {
            labelOutput += "\r You can drive."
        }
    }

    func userAbleToDo(age: Int) {
        // check the age integer and append the required comment
        // to the labelOutput string
        if age > 21 {
            labelOutput += "\r You can drive, vote and drink (but not at the same time!"
        } else if age > 18 {
            labelOutput += "\r You can drive and vote."
        } else if age > 16 {
            labelOutput += "\r You can drive."
        }
    }

    // hide the keyboard if the user taps on any other part of the screen
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        self.view.endEditing(true)
    }
    
}
