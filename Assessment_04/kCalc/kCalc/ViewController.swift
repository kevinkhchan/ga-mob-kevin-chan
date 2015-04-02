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

    @IBOutlet weak var calcLabel: UILabel!
    
    // Respond to the tapping of numbers
    /*
        Connect all the numeral buttons to an IBAction.
        Check if the exisiting number is 0. If so replace with the number pressed.
        If the exisiting number is not 0 then append the number pressed to the end of the string.
    */
    
    
    @IBAction func tapNumbers(sender: UIButton) {
        
        let tappedNumber : String! = sender.titleLabel!.text

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
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

