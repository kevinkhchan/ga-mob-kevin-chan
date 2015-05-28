//
//  KHC_NotesList_TableViewController.swift
//  Notes
//
//  Created by Kevin Chan on 7/05/2015.
//  Copyright (c) 2015 Kevin Chan. All rights reserved.
//

import UIKit

class KHC_Notes_List_TableViewController: PFQueryTableViewController {
    
    //----------------------------------------------------------------------
    // MARK: - Outlets
    //----------------------------------------------------------------------

    
    //----------------------------------------------------------------------
    // MARK: - Properties
    //----------------------------------------------------------------------
    
    let reachability = Reachability.reachabilityForInternetConnection()
    
    //----------------------------------------------------------------------
    // MARK: - Actions
    //----------------------------------------------------------------------

    
    //----------------------------------------------------------------------
    // MARK: - Scene Lifecycle
    //----------------------------------------------------------------------
    
    override init(style: UITableViewStyle, className: String?) {
        super.init(style: style, className: className)
    }
    
    required init!(coder aDecoder: NSCoder!) {
        super.init(coder: aDecoder)
    
        // Configure the PFQueryTableView
        self.parseClassName = "BlogPost"
        self.textKey = "title"
        self.pullToRefreshEnabled = false
        self.paginationEnabled = false
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        loadObjects()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "reachabilityChanged:", name: ReachabilityChangedNotification, object: reachability)
        reachability.startNotifier()
        
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        
        reachability.stopNotifier()
        
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }

    
    //----------------------------------------------------------------------
    // MARK: - PFQueryTableView Data Source
    //----------------------------------------------------------------------

    //Define the query that will provide the data for the table view
    override func queryForTable() -> PFQuery {

        var query = PFQuery(className: "BlogPost")
        /*
        if !reachability.isReachable() {
            query.fromLocalDatastore()
        }
        */
        query.orderByDescending("updatedAt")
        return query
        
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath, object: PFObject!) -> PFTableViewCell {
        
        var cell = tableView.dequeueReusableCellWithIdentifier("KHC_NotesList_Cell") as! PFTableViewCell!
        if cell == nil {
            cell = PFTableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "KHC_NotesList_Cell")
        }
        
        // Extract values from the PFObject to display in the table cell
        if let notesTitle = object["title"] as? String {
            cell?.textLabel?.text = notesTitle
        }
        
        if let notesSubTitle = object["subtitle"] as? String {
            cell?.detailTextLabel?.text = notesSubTitle
        }
        
        return cell
    }
        
    //----------------------------------------------------------------------
    // MARK: - Navigation
    //----------------------------------------------------------------------

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "KHC_Notes_ContentView_Segue" {
            // Get the new view controller using [segue destinationViewController]
            var segueToView = segue.destinationViewController as! KHC_Notes_Content_ViewController
            
            // Pass the selected object to the destination view controller
            if let indexPath = self.tableView.indexPathForSelectedRow() {
                segueToView.currentObject = objectAtIndexPath(indexPath)
            }
        }
    }

    //----------------------------------------------------------------------
    // MARK: - User Interaction
    //----------------------------------------------------------------------
    
    // Support conditional editing of the table view
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        
        return true
        
    }
    
    // Support editing the table view
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
            if editingStyle == .Delete {
                
                    
                    let objectToDelete = objectAtIndexPath(indexPath)
                    
                    SVProgressHUD.showWithStatus("Deleting", maskType: SVProgressHUDMaskType.Black)
                    
                    objectToDelete?.deleteInBackgroundWithBlock({
                        (success, error) -> Void in
                        if success {
                            
                            // reload objects
                            self.loadObjects()
                            
                            // Store the progress HUD
                            SVProgressHUD.dismiss()

                        }
                        else {
                            
                            // Stop the progress HUD
                            SVProgressHUD.dismiss()
                            
                            // Display alert using UIAlertController
                            // Use UIAlertView for iOS < 8
                            let alert = UIAlertController(title: "Note not deleted!",
                                message: "Please try again.",
                                preferredStyle: .Alert)
                            let okAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
                            alert.addAction(okAction)
                            self.presentViewController(alert, animated: true, completion: nil)

                            // reload objects
                            self.loadObjects()
                        }
                    })
                
            }
            else if editingStyle == .Insert {
                // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
            }
    }
    
    //----------------------------------------------------------------------
    // MARK: - Functions
    //----------------------------------------------------------------------
    
    func reachabilityChanged(note: NSNotification) {
        
        let reachability = note.object as! Reachability
        
        if reachability.isReachable() {
            
            loadObjects()
            
        } else {
            
            //
            
        }
    }
    
}
