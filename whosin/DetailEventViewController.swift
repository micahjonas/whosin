//
//  DetailEventViewController.swift
//  whosin
//
//  Created by X Code User on 7/22/15.
//  Copyright (c) 2015 Micha Schwendener. All rights reserved.
//

import UIKit
import Parse
import ParseUI


class DetailEventViewController: UIViewController {
    
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblGroup: UILabel!
    @IBOutlet weak var txtDescription: UITextView!
    @IBOutlet weak var lblPplGoing: UILabel!
    
    
    /*func queryForTable() -> PFQuery{
        let query = PFQuery(className: "eventDetails")
        return query
        
    }
    var details : PFQuery = queryForTable("event")
    var time, date, desc, group, pplGoing : String
    time = details.
    */
    
    
    
    var event : AnyObject!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK: - Button operations
    
    @IBAction func btnImIn(sender: AnyObject) {
        
        
        
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
