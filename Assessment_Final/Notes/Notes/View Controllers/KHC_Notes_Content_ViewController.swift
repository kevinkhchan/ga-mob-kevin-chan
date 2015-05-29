//
//  KHC_Notes_Content_ViewController.swift
//  Notes
//
//  Created by Kevin Chan on 7/05/2015.
//  Copyright (c) 2015 Kevin Chan. All rights reserved.
//

import UIKit

class KHC_Notes_Content_ViewController: UIViewController {
    
    //----------------------------------------------------------------------
    // MARK: - Outlets
    //----------------------------------------------------------------------
    
    @IBOutlet weak var KHC_Notes_Title: UITextField!
    @IBOutlet weak var KHC_Notes_Subtitle: UITextField!
    @IBOutlet weak var KHC_Notes_Content: UITextView!
    @IBOutlet weak var KHC_Notes_UpdatedAt: UILabel!
    
    @IBOutlet weak var KHC_Notes_Constraint_Bottom: NSLayoutConstraint!
    
    @IBOutlet weak var updateNoteStatus: UIBarButtonItem!
    
    //----------------------------------------------------------------------
    // MARK: - Properties
    //----------------------------------------------------------------------

    // Create container to receive Parse data from Notes List View
    var currentObject : PFObject?
    
    var currentTitle : String?
    var currentSubtitle : String?
    var currentContent : String?
    
    let reachability = Reachability.reachabilityForInternetConnection()
    
    //----------------------------------------------------------------------
    // MARK: - Actions
    //----------------------------------------------------------------------
    
    @IBAction func updateNote(sender: UIBarButtonItem) {
        
        if reachability.isReachable() {
            
            // Lower (Hide) keyboard
            self.view.endEditing(true)
            
            // Unwrap the current object object
            if let object = currentObject {
                
                object["title"] = KHC_Notes_Title.text
                object["subtitle"] = KHC_Notes_Subtitle.text
                object["content"] = KHC_Notes_Content.text
                
                // object.pinInBackground()
                
                // Start the progress HUD animation with subtitle "Saving"
                SVProgressHUD.showWithStatus("Saving", maskType: SVProgressHUDMaskType.Black)
                
                // Save the data back to the server in a background task
                object.saveInBackgroundWithBlock({ (success, error) -> Void in
                    
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
        }
        else {
            
            // Stop the progress HUD and display Error message
            SVProgressHUD.dismiss()
            
            // Display alert using UIAlertController
            // Use UIAlertView for iOS < 8
            let alert = UIAlertController(title: "Failed to Update",
                message: "Please try again",
                preferredStyle: .Alert)
            let okAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
            alert.addAction(okAction)
            self.presentViewController(alert, animated: true, completion: nil)

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
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "textViewDidChange:", name: UITextViewTextDidChangeNotification, object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "reachabilityChanged:", name: ReachabilityChangedNotification, object: reachability)
        reachability.startNotifier()

        
        // Unwrap current object
        if let object = currentObject {
            
            // Unwrap content and set as text for KHC_Notes_Title
            if let theTitle = object["title"] as? String {
                KHC_Notes_Title.text = theTitle
                currentTitle = theTitle
            }
            
            // Unwrap content and set as text for KHC_Notes_Subtitle
            if let theSubtitle = object["subtitle"] as? String {
                KHC_Notes_Subtitle.text = theSubtitle
                currentSubtitle = theSubtitle
            }
            
            // Unwrap content and set as text for KHC_Notes_Content
            if let theContent = object["content"] as? String {
                KHC_Notes_Content.text = theContent
                currentContent = theContent
            }
            
            // set the text for KHC_Notes_UpdatedAt label
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "dd MMMM yyyy, hh:mm a"
            let updatedAtString = dateFormatter.stringFromDate(object.updatedAt!)
            
            KHC_Notes_UpdatedAt.text = "Last updated on \(updatedAtString)"

        }
    }
    
    override func viewDidDisappear(animated: Bool) {
        
        super.viewDidDisappear(animated)
        
        reachability.stopNotifier()
        
        NSNotificationCenter.defaultCenter().removeObserver(self)
        
    }
    
    /*
    //----------------------------------------------------------------------
    // MARK: - Navigation
    //----------------------------------------------------------------------
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
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
    
    // Function to adjust (with animation) the constraint at the bottom of the root view
    // based on theheight of the keyboard
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
            self.KHC_Notes_Constraint_Bottom?.constant = isShowing ? endFrameHeight : 20.0
            UIView.animateWithDuration(duration,
                delay: NSTimeInterval(0),
                options: animationCurve,
                animations: { self.view.layoutIfNeeded() },
                completion: nil)
        }
        
    }
    
    // Enable or disable the Done button based on whether either textField(s) have changed
    func textFieldDidChange(notification: NSNotification) {
        
        if (KHC_Notes_Title.text != currentTitle) || (KHC_Notes_Subtitle.text != currentSubtitle) {
            
            updateNoteStatus.enabled = true
            
        }
        else {
            
            updateNoteStatus.enabled = false
            
        }
        
    }
    
    // Enable or disable the Done button based on whether the textView has changed
    func textViewDidChange(notification: NSNotification) {
        
        if KHC_Notes_Content.text != currentContent {
            
            updateNoteStatus.enabled = true
            
        }
        else {
            
            updateNoteStatus.enabled = false
            
        }
        
    }
    
    // Check if the device is connected to the internet
    func reachabilityChanged(note: NSNotification) {
        
        let reachability = note.object as! Reachability
        
        if reachability.isReachable() {
            
            //
            
        } else {
            
            //
            
        }
    }

}
