//
//  ResultTableViewController.swift
//  whosin
//
//  Created by Micha Schwendener on 23/07/15.
//  Copyright (c) 2015 Micha Schwendener. All rights reserved.
//

import UIKit
import Parse

class ResultTableViewController: UITableViewController {
    
    var results : [PFObject] = []
    var groupWithRelations : [PFObject] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        


        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        let relation = PFUser.currentUser()?.relationForKey("groups")
        let query = relation?.query()
        query!.findObjectsInBackgroundWithBlock({(objects: [AnyObject]?, error: NSError?) in
            self.groupWithRelations = objects as! [PFObject]
            self.tableView.reloadData()
        })
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
        return results.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("GroupResultCell", forIndexPath: indexPath) as! UITableViewCell

        let object = results[indexPath.row] as PFObject
        if contains(groupWithRelations, object) {
            cell.accessoryType = UITableViewCellAccessoryType.Checkmark
        } else {
            cell.accessoryType = UITableViewCellAccessoryType.None
        }
        cell.textLabel?.text = object.objectForKey("name") as! String
        

        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let object = results[indexPath.row] as PFObject
        
        if contains(groupWithRelations, object) {
            
            let index = find(groupWithRelations, object)
            groupWithRelations.removeAtIndex(index!)

            let relation = PFUser.currentUser()?.relationForKey("groups")
            relation?.removeObject(object)
            PFUser.currentUser()?.saveInBackground()
        
        
        } else {
            groupWithRelations.append(object)
            let relation = PFUser.currentUser()?.relationForKey("groups")
            relation?.addObject(object)
            PFUser.currentUser()?.saveInBackground()
        }
    
        /*
        let relation = PFUser.currentUser()?.relationForKey("groups")
        let query = relation?.query()
        query?.whereKey("objectId", equalTo: object.objectId!)
        query!.findObjectsInBackgroundWithBlock({(objects: [AnyObject]?, error: NSError?) in
            
            
        
            println(objects)
        
        })
        
        
        
        println(relation)
        
        //relation?.addObject(object)
        
        //PFUser.currentUser()?.saveInBackground()*/
        
        self.tableView.reloadData()
        
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
