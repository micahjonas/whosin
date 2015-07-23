//
//  GroupResultTableView.swift
//  whosin
//
//  Created by Micha Schwendener on 22/07/15.
//  Copyright (c) 2015 Micha Schwendener. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class GroupResultTableView: UITableViewController {
    
    var objects = [String]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        println("fukcer")
        println(objects)
    }
    
    func hack (arr: [String]){
        self.objects = arr
        self.tableView.reloadData()
    
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
        return objects.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("groupResultCell", forIndexPath: indexPath) as! UITableViewCell
        
        cell.textLabel!.text = objects[indexPath.row]
        return cell
    }

    
}
