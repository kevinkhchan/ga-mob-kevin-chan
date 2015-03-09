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
    
    
    @IBOutlet weak var firstViewName: UITextField!
    @IBOutlet weak var firstViewAge: UITextField!
    @IBOutlet weak var firstViewLabel: UILabel!
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        self.view.endEditing(true)
    }

    var userName: String = ""
    var userAge: String = ""
    var labelOutput: String = ""
    var startMessage: String = "Hello, World!"

    @IBAction func firstViewButton(sender: AnyObject) {
        
        labelOutput = startMessage
        
        if firstViewName.text.isEmpty {
            errorMessage("Name")
            firstViewName.becomeFirstResponder()
        } else if firstViewAge.text.isEmpty {
            errorMessage("Age")
            firstViewAge.becomeFirstResponder()
        } else {
            userName = firstViewName.text
            userAge = firstViewAge.text
            // --
            greetUser(userName, age: userAge)
            // --
            firstViewLabel.text = labelOutput
        }
        
    }
    
    func errorMessage(errorField: String) {
        labelOutput = "Please enter your \(errorField)!"
        firstViewLabel.text = labelOutput
        labelOutput = startMessage
    }

    func greetUser(name: String, age: String) {
        labelOutput += "\r Hello \(name), you are \(age) years old!"
    }

    
}
