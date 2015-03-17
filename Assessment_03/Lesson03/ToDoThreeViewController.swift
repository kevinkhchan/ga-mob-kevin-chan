//
//  ToDoThreeViewController.swift
//  Lesson03
//
//  Created by Kevin Chan on 14/03/2015.
//  Copyright (c) 2015 General Assembly. All rights reserved.
//

import UIKit

class ToDoThreeViewController: UIViewController {

    // set the button return the view to the VC that called this VC modally
    @IBAction func toDoThreeDismiss(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
