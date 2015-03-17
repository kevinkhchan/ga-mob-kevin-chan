//
//  ViewController.swift
//  Lesson03
//
//  Created by Rudd Taylor on 9/28/14.
//  Copyright (c) 2014 General Assembly. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    /*
    TODO one: Hook up a swipeable area on the home screen that must present a modal dialog when swiped. You must create the modal dialog and present it in CODE (not the storyboard).
    TODO two: Add an imageview to the modal dialog presented in TODO two.
    TODO three: Add and hook up a ‘dismiss’ button below the above mentioned image view that will dismiss the modal dialog. Do this in CODE.
    TODO four: Hook up the button on the home screen to push ArrayTableViewController into view (via the navigation controller) when tapped. Do this by triggering a segue from this view controller. The method you are looking for is performSegueWithIdentifier. Find the identifier from the storyboard.
    */

    // Set the button to perform a Segue to the storyboard showTableView
    @IBAction func toDoFourButton(sender: AnyObject) {
        self.performSegueWithIdentifier("showTableView", sender: self)
    }

    override func viewDidLoad() {
        // Set the VC to recognise the left and right Swipe gesture
        super.viewDidLoad()
        
        // Call on the function showSecondViewController
        // if a left or right Swipe gesture is triggered.
        var leftSwipe = UISwipeGestureRecognizer(target: self, action: "showSecondViewController")
        var rightSwipe = UISwipeGestureRecognizer(target: self, action: "showSecondViewController")
        
        leftSwipe.direction = .Left
        rightSwipe.direction = .Right
        
        // allocate the left and right Swipe gesture recognizer to the VC
        view.addGestureRecognizer(leftSwipe)
        view.addGestureRecognizer(rightSwipe)
        
    }

    func showSecondViewController() {
        // perform a Segue to the storyboard segueToDoTwoModal
        self.performSegueWithIdentifier("segueToDoTwoModal", sender: self)
    }
    
}


