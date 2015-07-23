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
                println(id)
                query.whereKey("group", equalTo: id!)

                queryArray.append(query)
                
            }
            
            var compQuery = PFQuery.orQueryWithSubqueries(queryArray)
            compQuery.findObjectsInBackgroundWithBlock {
                (results: [AnyObject]?, error: NSError?) -> Void in
                if error == nil {
                    // results contains players with lots of wins or only a few wins.
                    self.events = results as! [PFObject]
                    println(self.events)
                    self.tableView.reloadData()
                }
            }
            
            
            
        }

        
        
        
        
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
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
        
    /*
        let relation = event.relationForKey("usersJoining")
        let query = relation.query()
        let userId = PFUser.currentUser()?.objectId
        query!.whereKey("objectId", equalTo: userId!)
        query!.findObjectsInBackgroundWithBlock {
            (results: [AnyObject]?, error: NSError?) -> Void in
            if error == nil {
                
                
                
            }
        }

        
        */
        
        
        
        /*
        let query = Qu
        let userId = PFUser.currentUser()?.objectId
        event.whereKey("objectId", equalTo: userId!)
        
        */
        
        return cell
    }
    
    
}

/*

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
                    println(id)
                    query.whereKey("group", equalTo: id!)
                    query.findObjectsInBackgroundWithBlock{
                        (objects: [AnyObject]?, error: NSError?) -> Void in
                        
                        queryArray.append(query)
                        
                    }
                    
                }
                
                
                
                
            }
            println("awsome")
            println(queryArray)
            

            
            var compQuery = PFQuery.orQueryWithSubqueries(queryArray)

            return compQuery
        }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.loadObjects()
        self.tableView.reloadData()
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


            }
        }
    }
}*/

