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

class EventTableViewController: UITableViewController {
    
    var events = [PFObject]()
    var eventsJoined : [PFObject] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var userId : String = PFUser.currentUser()!.objectId!
        let relation = PFUser.currentUser()?.relationForKey("groups")
        let query = relation?.query()
        
        var queryArray : [PFQuery] = []
        
        query?.findObjectsInBackgroundWithBlock{
            (objects: [AnyObject]?, error: NSError?) -> Void in
            let groups = objects as! [PFObject]
            
            
            for group in groups {
                var id = group.objectId as String?
                let query = PFQuery(className: "event")
                query.whereKey("group", equalTo: id!)

                queryArray.append(query)
                
            }
            
            var compQuery = PFQuery.orQueryWithSubqueries(queryArray)
            compQuery.findObjectsInBackgroundWithBlock {
                (results: [AnyObject]?, error: NSError?) -> Void in
                if error == nil {
                    // results contains players with lots of wins or only a few wins.
                    self.events = results as! [PFObject]
                    self.tableView.reloadData()
                }
            }
            
            
            
        }

        
        
        
        
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        

        
        let relation = PFUser.currentUser()?.relationForKey("eventsJoined")
        let query = relation?.query()
        query!.findObjectsInBackgroundWithBlock({(objects: [AnyObject]?, error: NSError?) in
            self.eventsJoined = objects as! [PFObject]
            
            println("eventJoined")
            println(objects)
            println(self.eventsJoined)
            
            self.tableView.reloadData()
        })
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("eventsCell", forIndexPath: indexPath) as! UITableViewCell
        
        let event = events[indexPath.row]
        var txt = event.objectForKey("name") as! String
        cell.textLabel!.text = txt

        if contains(eventsJoined, event) {
            cell.accessoryType = UITableViewCellAccessoryType.Checkmark
        } else {
            cell.accessoryType = UITableViewCellAccessoryType.None
        }
        
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        
        if segue.identifier == "eventSegue" {
            
            if let indexPath = self.tableView.indexPathForSelectedRow() {
                let event = events[indexPath.row] as PFObject
                
                
                var index = indexPath.row
               // var event : PFObject = self.objects?[index] as! PFObject
                
                
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
