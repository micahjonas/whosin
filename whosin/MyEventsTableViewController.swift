//
//  MyEventsTableViewController.swift
//  whosin
//
//  Created by X Code User on 7/23/15.
//  Copyright (c) 2015 Micha Schwendener. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class MyEventsTableViewController: PFQueryTableViewController {
    
    
    // Initialise the PFQueryTable tableview
    override init(style: UITableViewStyle, className: String!) {
        super.init(style: style, className: className)
    }
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        // Configure the PFQueryTableView
        self.parseClassName = "event"
        self.textKey = "name"
        self.pullToRefreshEnabled = true
        self.paginationEnabled = false
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("eventSegue", sender: self)
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func queryForTable() -> PFQuery {
        
        let query = PFQuery(className: "event")
        var userId = PFUser.currentUser()?.objectId
        println(userId)
        
        query.whereKey("creator", equalTo: userId!)
        return query
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        /*if (segue.identifier == "btnSubmitSegue") {
        var svc = segue.destinationViewController as SecondViewController;
        svc.dataPassed = fieldA.text
        svc.secondDataPassed = fieldB.text
        }*/
        
        
        if segue.identifier == "eventSegue" {
            
            if let indexPath = self.tableView.indexPathForSelectedRow() {
                println(indexPath.row)
                let object = objects![indexPath.row] as! PFObject
                
                
                var index = indexPath.row
                var event : PFObject = self.objects?[index] as! PFObject
                println("fuck yeah")
                println(event)
                
                /*
                var passDestination = segue.destinationViewController as! DetailEventViewController;
                
                passDestination.date = event.stringForKey("date")
                passDestination.group = event.stringForKey("groups")
                passDestination.desc = event.stringForKey("description")
                passDestination.location = event.stringForKey("location")
                */
                //println(event)
                
                
                //println(object)
                
                /*
                var artist = object.objectForKey("name") as? String
                var mobileUrl = object.objectForKey("url") as? String
                mobileUrl = mobileUrl?.stringByReplacingOccurrencesOfString("www.last.fm", withString: "m.last.fm")
                */
                /*(segue.destinationViewController as? DetailEventViewController)?.title = "Details"
                (segue.destinationViewController as? DetailEventViewController)?.time = event.objectForKey("time") as! String
                (segue.destinationViewController as? DetailEventViewController)?.date = (event.objectForKey("date") as! String)
                (segue.destinationViewController as? DetailEventViewController)?.group = (event.objectForKey("groups") as! String)
                (segue.destinationViewController as? DetailEventViewController)?.desc = (event.objectForKey("description") as! String)
                (segue.destinationViewController as? DetailEventViewController)?.location = (event.objectForKey("location") as! String)*/
                
                
            }
        }
    }


    // MARK: - Table view data source


    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as! UITableViewCell

        // Configure the cell...

        return cell
    }
    */

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
