//
//  PVMainTableViewController.swift
//  PhotoViewerRedux
//
//  Created by Kevin Chan on 31/03/2015.
//  Copyright (c) 2015 Kevin Chan. All rights reserved.
//

import UIKit

class PVMainTableViewController: UITableViewController {
    
    // MARK: - Define sections
    
    // Define the sections to be used for this table view example
    
    var citySanFrancisco = [ContentDetails]()
    var citySeattle = [ContentDetails]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Define the data for each section 
        
        var newLocation = ContentDetails(itemName: "Union Square", itemFilename: "unionsquare", itemDescription: "Union Square is a 2.6-acre public plaza bordered by Geary, Powell, Post and Stockton Streets in downtown San Francisco, California. \"Union Square\" also refers to the central shopping, hotel, and theatre district that surrounds the plaza for several blocks.")
        citySanFrancisco.append(newLocation)
        
        newLocation = ContentDetails(itemName: "Mission District", itemFilename: "missiondistrict", itemDescription: "The Mission District is located in east-central San Francisco. It is bordered to the east by U.S. Route 101, which forms the boundary between the eastern portion of the district, known as \"Inner Mission\", and its eastern neighbour, Potrero Hill.")
        citySanFrancisco.append(newLocation)
        
        newLocation = ContentDetails(itemName: "Nob Hill", itemFilename: "nobhill", itemDescription: "Nob Hill is a neighbourhood in San Francisco, California, centred on the intersection of California Street and Powell Street. It is one of San Francisco's 44 hills, and one of its original \"Seven Hills.\" Prior to the 1850s, Nob Hill was called California Hill (after California Street, which climbs its steep eastern face). It was renamed after the Central Pacific Railroad's Big Four – called the Nobs – built mansions there.")
        citySanFrancisco.append(newLocation)
        
        newLocation = ContentDetails(itemName: "Fisherman's Wharf", itemFilename: "fishermanswharf", itemDescription: "Fisherman's Wharf is a neighbourhood and popular tourist attraction in San Francisco, California. It roughly encompasses the northern waterfront area of San Francisco from Ghirardelli Square or Van Ness Avenue east to Pier 35 or Kearny Street.")
        citySanFrancisco.append(newLocation)
        
        


        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return citySanFrancisco.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("pvLocationCell", forIndexPath: indexPath) as UITableViewCell

        // Configure the cell...
        var currentContent = citySanFrancisco[indexPath.row]
        cell.textLabel?.text = currentContent.itemName

        return cell
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "San Francisco"
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        var secondScene = segue.destinationViewController as PVInfoViewController
        
        // Pass the selected object to the new view controller.
        if let indexPath = self.tableView.indexPathForSelectedRow() {
            let selectedContent = citySanFrancisco[indexPath.row]
            secondScene.currentContent = selectedContent
        }
    }
    
}
