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
    
    var calcLabelValue: String! // start with no value in the label as it is 0
    var hasDecimal: Bool = false // has the decimal been pressed - start with no
    var hasCalculation: Bool = false // is there a calculation in progress - start with no
    let errorMessage: String = "Error!" // set the errorMessage to ensure consistency
    let clearValueMessage: String = "Swipe to clear this value" // set the swipe message to clear screen value
    let clearCalculationMessage: String = "Swipe to clear the calculation" // set the swipe messate to clear the calculation
    
    var calcSequence = [] // optional array to use in a future version
    var previousCalcValue: Double! // variable to store the previous value of a calculation which will become the first value in a calculation
    var calcOperand: String! // variable to store the operand to be used in the calculation
    var clearCalcSequence: Bool = false // variable to store boolean to indicate if the calculation sequence should be cleared by the swipe gesture
    var clearLabelValue:Bool = false // variable to store boolean to indicate if the label on the screen should be cleared by the swipe gesture
    
    // Add the label as an IBOutlet

    @IBOutlet weak var resultScreen: UIView! // add the view to allow for the recognition of swipe gestures to clear the labels
    @IBOutlet weak var calcLabel: UILabel! // add label to display the values corresponding to calculations and input via the numeral buttons
    @IBOutlet weak var clearResultScreenInstructions: UILabel! // add the label to provide instructions for clearing the calculator screen
    @IBOutlet weak var calcSequenceLabel: UILabel!
    
    
    // Respond to the swipe gesture in the ResultScreenView to clear values and reset to 0
    @IBAction func swipeToClearResultScreen(sender: UISwipeGestureRecognizer) {
        if clearResultScreenInstructions.text == clearCalculationMessage {
            previousCalcValue = nil
            clearResultScreen() // clear the ResultScreenView
            clearSwipeLabel() // remove the swipe to clear instruction
        } else {
            if previousCalcValue != nil {
                clearResultScreenInstructions.text = clearCalculationMessage
            } else {
                clearSwipeLabel()
            }
            clearResultScreen() // clear the ResultScreenView
        }
    }
    
    
    // Respond to the tapping of numbers
    /*
        Connect all the numeral buttons to an IBAction.
        Check if the exisiting number is 0. If so replace with the number pressed.
        If the exisiting number is not 0 then append the number pressed to the end of the string.
    */
    
    @IBAction func tapNumbers(sender: UIButton) {
        
        // get the value of the keypress. The number is the title of the label for the button in the .Normal state.
        
        let tappedNumber : String! = sender.titleForState(.Normal)!
        if clearLabelValue == true {
            resetLabelValue()
            clearLabelValue = false
        }
        if clearCalcSequence == true {
            resetLabelValue()
            previousCalcValue = nil
            clearCalcSequence = false
        }
        if calcLabelValue == nil {
            calcLabelValue = tappedNumber
            clearResultScreenInstructions.text = clearValueMessage
        } else if (countElements(calcLabelValue) < 12) {
            calcLabelValue = calcLabelValue.stringByAppendingString(tappedNumber)
        }
        calcLabel.text = calcLabelValue

    }
    
    // Respond to the tapping of the decimal
    /*
        Connect the decimal button to an IBAction.
        Add the decimal point if there is no existing decimal point.
    */
    @IBAction func tapDecimal(sender: UIButton) {
        // Change the calcLabelValue to 0 if it is nil.
        /*
            The nil state throws back an error when the countElements is applied to the calcLabelValue.
        */
        if clearLabelValue == true {
            resetLabelValue()
            clearLabelValue = false
        }
        if clearCalcSequence == true {
            resetLabelValue()
            previousCalcValue = nil
            clearCalcSequence = false
        }
        if calcLabelValue == nil{
            calcLabelValue = "0"
            clearResultScreenInstructions.text = clearValueMessage
        }
        if hasDecimal == false && (countElements(calcLabelValue) < 11) {
            calcLabelValue = calcLabelValue.stringByAppendingString(".")
            calcLabel.text = calcLabelValue
            hasDecimal = true
        }
    }
    
    
    @IBAction func tapOperand(sender: UIButton) {
        if calcLabel.text == errorMessage {
            return
        }
        if previousCalcValue == nil {
            if calcLabelValue != nil {
                previousCalcValue = (calcLabelValue as NSString).doubleValue
            } else {
                previousCalcValue = 0
            }
        } else {
            if calcLabelValue != nil {
                let currentCalcValue: Double = (calcLabelValue as NSString).doubleValue
                switch calcOperand
                {
                case "+":
                    previousCalcValue = calcAddition(previousCalcValue, secondValue: currentCalcValue)
                case "−":
                    previousCalcValue = calcSubtraction(previousCalcValue, secondValue: currentCalcValue)
                case "×":
                    previousCalcValue = calcMultiplication(previousCalcValue, secondValue: currentCalcValue)
                case "÷":
                    if currentCalcValue == 0 {
                        calcLabel.text = errorMessage
                        resetLabelValue()
                        clearCalcSequence = true
                        clearResultScreenInstructions.text = clearCalculationMessage
                        return
                    } else {
                        previousCalcValue = calcDivision(previousCalcValue, secondValue: (calcLabelValue as NSString).doubleValue)
                    }
                default:
                    if previousCalcValue != nil {
                        clearCalcSequence = true
                    }
                }
            }
        }
        
        // Check if the returned value has more than 12 characters. If so, limit the output to 12 characters only.
        /*

        */
        var calcLabelString = "\(previousCalcValue)"
        if suffix(calcLabelString, 2) == ".0" {
            let endIndex = countElements(calcLabelString) - 2
            calcLabelString = calcLabelString.substringToIndex(advance(calcLabelString.startIndex, endIndex))
        }
        if countElements(calcLabelString) > 12 {
            calcLabel.text = calcLabelString.substringToIndex(advance(calcLabelString.startIndex, 12))
        } else {
            calcLabel.text = calcLabelString
        }
        
        //
        /*

        */
        calcOperand = sender.titleForState(.Normal)!
        clearLabelValue = true
        resetLabelValue()
        
        //
        /*

        */
        if calcOperand == "=" {
            if previousCalcValue != nil {
                clearCalcSequence = true
                clearResultScreenInstructions.text = clearCalculationMessage
            }
        } else {
            clearCalcSequence = false
        }

    }
    
    func calcAddition(firstValue: Double, secondValue: Double) -> Double {
        return (firstValue + secondValue)
    }
    
    func calcSubtraction(firstValue: Double, secondValue: Double) -> Double {
        return (firstValue - secondValue)
    }
    
    func calcMultiplication(firstValue: Double, secondValue: Double) -> Double {
        return (firstValue * secondValue)
    }
    
    func calcDivision(firstValue: Double, secondValue: Double) -> Double {
        return (firstValue / secondValue)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        clearSwipeLabel()
        clearCalculationSequenceLabel()
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // 
    //  Function to set the ResultScreenView to 0 and reset associated variables
        /*
        set the calculator label variable to 0
        set the calculator label text to match the variable
        set the decimal boolean variable to false
        */
    //
    func clearResultScreen() {
        resetLabelValue()
        calcLabel.text = "0" // set calcLabel text to 0
    }
    
    func resetLabelValue() {
        calcLabelValue = nil
        hasDecimal = false // set value to false to allow decimal point
    }
    
    func clearSwipeLabel() {
        self.clearResultScreenInstructions.text = ""
    }
    
    func clearCalculationSequenceLabel() {
        self.calcSequenceLabel.text = ""
    }
}

