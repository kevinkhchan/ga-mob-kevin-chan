//
//  ViewController.swift
//  kCalc
//
//  Created by Kevin Chan on 31/03/2015.
//  Copyright (c) 2015 Kevin Chan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // Declare some variables
    
    var calcLabelValue: String! = "0" // start with no value in the label as it is 0
    var hasDecimal: Bool = false // has the decimal been pressed - start with no
    
    // Add the label as an IBOutlet

    @IBOutlet weak var resultScreen: UIView! // add resultScreen as an IBOutlet to allow for swipe gesture
    @IBOutlet weak var calcLabel: UILabel! // add calcLabe as an IBOutlet to allow changing of the label

    // Respond to the tapping of numbers
    /*
        Connect all the numeral buttons to an IBAction.
        Check if the exisiting number is 0. If so replace with the number pressed.
        If the exisiting number is not 0 then append the number pressed to the end of the string.
    */
    
    @IBAction func tapNumbers(sender: UIButton) {
        
        let tappedNumber : String! = sender.titleLabel!.text // get the value of the keypress. The number the title of the label for the button.

        if calcLabel.text == "0" {
            calcLabelValue = tappedNumber
        } else {
            calcLabelValue = calcLabelValue.stringByAppendingString(tappedNumber)
        }
        calcLabel.text = calcLabelValue

    }
    
    // Respond to the tapping of the decimal
    
    /*
        Connect the decimal button to an IBAction.
        Add the decimal point if there is no existing decimal point.
    */
    
    @IBAction func tapDecimal(sender: AnyObject) {
        if hasDecimal == false {
            calcLabelValue = calcLabelValue.stringByAppendingString(".")
            calcLabel.text = calcLabelValue
            hasDecimal = true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Add left and right swipe gesture to the ResultScreenView
        
        var leftSwipe = UISwipeGestureRecognizer(target: self, action: "clearCalcLabel")
        var rightSwipe = UISwipeGestureRecognizer(target: self, action: "clearCalcLabel")
        
        leftSwipe.direction = .Left
        rightSwipe.direction = .Right
        
        resultScreen.addGestureRecognizer(leftSwipe)
        resultScreen.addGestureRecognizer(rightSwipe)
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func clearCalcLabel() {
        
        // This function is called to reset the calcLabel to 0
        
        calcLabel.text = "0" // set calcLabel text to 0
        calcLabelValue = "0"
        hasDecimal = false // set value to false to allow decimal point
    }

}

