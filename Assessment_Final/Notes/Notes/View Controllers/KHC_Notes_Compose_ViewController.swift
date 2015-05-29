//
//  KHC_Notes_Compose_ViewController.swift
//  Notes
//
//  Created by Kevin Chan on 7/05/2015.
//  Copyright (c) 2015 Kevin Chan. All rights reserved.
//

import UIKit

class KHC_Notes_Compose_ViewController: UIViewController {
    
    //----------------------------------------------------------------------
    // MARK: - Outlets
    //----------------------------------------------------------------------
    
    @IBOutlet weak var KHC_Notes_Compose_Label_Title: UILabel!
    @IBOutlet weak var KHC_Notes_Compose_Label_Subtitle: UILabel!
    
    @IBOutlet weak var KHC_Notes_Compose_Title: UITextField!
    @IBOutlet weak var KHC_Notes_Compose_Subtitle: UITextField!
    @IBOutlet weak var KHC_Notes_Compose_Content: UITextView!
    
    @IBOutlet weak var KHC_Notes_Compose_Contstraint_Bottom: NSLayoutConstraint!
    
    @IBOutlet weak var addNoteStatus: UIBarButtonItem!

    //----------------------------------------------------------------------
    // MARK: - Properties
    //----------------------------------------------------------------------
    
    let reachability = Reachability.reachabilityForInternetConnection()
    
    //----------------------------------------------------------------------
    // MARK: - Actions
    //----------------------------------------------------------------------
    
    @IBAction func addNote(sender: UIBarButtonItem) {
        
        // Lower (Hide) keyboard
        self.view.endEditing(true)
        
        // Add the note to Parse if title is provided
        if (KHC_Notes_Compose_Title.text != "") {
            
            // Create a new parse object
            var addObject = PFObject(className: "BlogPost")
            
            addObject["title"] = KHC_Notes_Compose_Title.text
            addObject["subtitle"] = KHC_Notes_Compose_Subtitle.text
            addObject["content"] = KHC_Notes_Compose_Content.text
            // addObject.pinInBackground()
            
            // Check if the device is connected to the network (internet)
            
            if reachability.isReachable() {
                
                // Start the progress HUD animation with subtitle "Saving"
                SVProgressHUD.showWithStatus("Saving…", maskType: SVProgressHUDMaskType.Black)
                
                // Save the data to the server as a background task
                addObject.saveInBackgroundWithBlock({ (success, error) -> Void in
                    
                    if success {
                        
                        // Dismiss the progress HUD
                        SVProgressHUD.dismiss()
                        
                        // Return to Notes List table view
                        self.navigationController?.popViewControllerAnimated(true)
                    }
                    else {
                        
                        // Stop the progress HUD and display Error message
                        SVProgressHUD.dismiss()
                        
                        // Display alert using UIAlertController
                        // Use UIAlertView for iOS < 8
                        let alert = UIAlertController(title: "Failed to Save",
                            message: "Please try again",
                            preferredStyle: .Alert)
                        let okAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
                        alert.addAction(okAction)
                        self.presentViewController(alert, animated: true, completion: nil)
                        
                    }
                    
                })
                
            }
            else {
                
                // Display alert using UIAlertController
                // Use UIAlertView for iOS < 8
                let alert = UIAlertController(title: "Failed to Save",
                    message: "Network connection error",
                    preferredStyle: .Alert)
                let okAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
                alert.addAction(okAction)
                self.presentViewController(alert, animated: true, completion: nil)
                
            }
            
        }
        else {
            
            // Legacy code that is not required at this point as the "Done" button
            // will only be active when the title is not ""
            
            // Indicate that a title needs to be provided
            if KHC_Notes_Compose_Title.text == "" {
                KHC_Notes_Compose_Label_Title.text = "Please enter a title"
                KHC_Notes_Compose_Label_Title.font = UIFont.boldSystemFontOfSize(14)
                KHC_Notes_Compose_Label_Title.textColor = UIColor.redColor()
                
            }
            else {
                
                KHC_Notes_Compose_Label_Title.text = "Title"
                KHC_Notes_Compose_Label_Title.font = UIFont.systemFontOfSize(14)
                KHC_Notes_Compose_Label_Title.textColor = UIColor.blackColor()
                
            }
        }
    }
    
    //----------------------------------------------------------------------
    // MARK: - Scene Lifecycle
    //----------------------------------------------------------------------
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // Set events to be observed by the NSNotificationCenter
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardNotification:", name:UIKeyboardWillShowNotification, object: nil);
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardNotification:", name:UIKeyboardWillHideNotification, object: nil);
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "textFieldDidChange:", name: UITextFieldTextDidChangeNotification, object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "reachabilityChanged:", name: ReachabilityChangedNotification, object: reachability)
        reachability.startNotifier()

    }
    
    override func viewDidDisappear(animated: Bool) {
        
        super.viewDidDisappear(animated)
        
        reachability.stopNotifier()
        
        NSNotificationCenter.defaultCenter().removeObserver(self)
        
    }
    
    //----------------------------------------------------------------------
    // MARK: - Navigation
    //----------------------------------------------------------------------
    

    //----------------------------------------------------------------------
    // MARK: - User Interaction
    //----------------------------------------------------------------------
    
    // Hide the keyboard when user taps any where on screen that is not textView or textField
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        
        self.view.endEditing(true)
        
    }
    
    //----------------------------------------------------------------------
    // MARK: - Functions
    //----------------------------------------------------------------------
    
    //
    // Function to adjust (with animation) the constraint at the bottom of the root view
    // based on theheight of the keyboard
    //
    func keyboardNotification(notification: NSNotification) {
        
        // Set the boolean value of isShowing indicating if keyboard is hiding or showing
        // true if the keyboard is showing and false if keyboard is hiding
        let isShowing = notification.name == UIKeyboardWillShowNotification

        if let userInfo = notification.userInfo {
            
            let endFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.CGRectValue()
            let endFrameHeight = endFrame?.size.height ?? 0.0
            let duration:NSTimeInterval = (userInfo[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0
            let animationCurveRawNSN = userInfo[UIKeyboardAnimationCurveUserInfoKey] as? NSNumber
            let animationCurveRaw = animationCurveRawNSN?.unsignedLongValue ?? UIViewAnimationOptions.CurveEaseInOut.rawValue
            let animationCurve:UIViewAnimationOptions = UIViewAnimationOptions(rawValue: animationCurveRaw)
            self.KHC_Notes_Compose_Contstraint_Bottom?.constant = isShowing ? endFrameHeight : 20.0
            UIView.animateWithDuration(duration,
                delay: NSTimeInterval(0),
                options: animationCurve,
                animations: { self.view.layoutIfNeeded() },
                completion: nil)
            
        }
    }
    
    //
    // Enable or disable the Done button based on whether either textField(s) have changed
    //
    func textFieldDidChange(notification: NSNotification) {
        
        if (KHC_Notes_Compose_Title.text != "") {
            
            addNoteStatus.enabled = true
            
        }
        else {
            
            addNoteStatus.enabled = false
            
        }
        
    }

    //
    // Check if the device is connected to the internet
    //
    func reachabilityChanged(note: NSNotification) {
        
        let reachability = note.object as! Reachability
        
        if reachability.isReachable() {

            //
            
        } else {

            //
        
        }
        
    }

}
