//
//  EventTableViewController.swift
//  whosin
//
//  Created by X Code User on 7/22/15.
//  Copyright (c) 2015 Micha Schwendener. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class EventTableViewController: PFQueryTableViewController {
    
        
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
    
    /*override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        self.performSegueWithIdentifier("scheisser", sender: self)
    }*/

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
        
        override func queryForTable() -> PFQuery {
            
            
            //var userId : String = PFUser.currentUser()!.objectId!
            
            
            //let relation = PFUser.currentUser()?.relationForKey("groups")
            //let query = relation?.query()
            
            /*
            query.whereKey("userId", equalTo: userId)
            query.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]?, error: NSError?) -> Void in
            var groups : [String]
            if error == nil {
            // The find succeeded.
            println("Successfully retrieved \(objects!.count) scores.")
            // Do something with the found objects
            if let objects = objects as? [PFObject] {
            for object in objects {
            
            }
            }
            } else {
            // Log details of the failure
            println("Error: \(error!) \(error!.userInfo!)")
            }
            }
            
            */
            let query = PFQuery(className: "event")
            return query
        }


    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        
        if segue.identifier == "eventSegue" {
            
            if let indexPath = self.tableView.indexPathForSelectedRow() {
                let object = objects![indexPath.row] as! PFObject

                
                var index = indexPath.row
                var event : PFObject = self.objects?[index] as! PFObject
                

                (segue.destinationViewController as? DetailEventViewController)?.title = "Details"
                (segue.destinationViewController as? DetailEventViewController)?.time = event.objectForKey("time") as! String
                (segue.destinationViewController as? DetailEventViewController)?.date = (event.objectForKey("date") as! String)
                (segue.destinationViewController as? DetailEventViewController)?.group = (event.objectForKey("group") as! String)
                (segue.destinationViewController as? DetailEventViewController)?.desc = (event.objectForKey("description") as! String)
                (segue.destinationViewController as? DetailEventViewController)?.location = (event.objectForKey("location") as! String)
                  (segue.destinationViewController as? DetailEventViewController)?.event = event


            }
        }
    }
}

