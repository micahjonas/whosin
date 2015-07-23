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
    @IBOutlet weak var lblLocation: UILabel!
    @IBOutlet weak var btnImIn: UIButton!

    
    
    var time : String = ""
    var date : String = ""
    var group : String = ""
    var desc : String = ""
    var pplGoing : String = ""
    var location: String = ""
    var event : PFObject = PFObject(className: "event")
    var name : String = ""
    var pplJoined : [PFObject] = []
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        lblTime.text = "Time: " + time
        lblDate.text = "Date: " + date
        
        lblLocation.text = "Location: " + location
        txtDescription.text = "" + desc
        
        let query = PFQuery(className: "group")
        query.whereKey("objectId", equalTo: group)
        query.findObjectsInBackgroundWithBlock{
            (objects: [AnyObject]?, error: NSError?) in
                var temp = objects?.first!.objectForKey("name") as! String
                self.lblGroup.text = "Group: \(temp)"
        
        }
        // Do any additional setup after loading the view.
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        
        super.viewWillAppear(animated)
        let relation = event.relationForKey("usersJoining")
        let query = relation.query()
        query!.findObjectsInBackgroundWithBlock({(objects : [AnyObject]?, error: NSError?) in
            self.pplJoined = objects as! [PFObject]
            if contains(self.pplJoined, PFUser.currentUser()!){
                self.btnImIn.setTitle("I'm In!", forState: UIControlState())
            }
            else{
                self.btnImIn.setTitle("I'm Out!", forState: UIControlState())
            }
        })
        

      
    }

    
    
    //MARK: - Button operations
    
    @IBAction func btnImIn(sender: AnyObject) {
        
        
        
        
        println(event)
        let relation2 = PFUser.currentUser()?.relationForKey("eventsJoined")
        let relation = event.relationForKey("usersJoining")
        let user = PFUser.currentUser()
        
        if !contains(pplJoined, PFUser.currentUser()!){
            println("if")
            relation.addObject(user!)
            relation2?.addObject(event)
            btnImIn.setTitle("I'm In!", forState: UIControlState())
            pplJoined.append(user!)
        }
        else if contains(pplJoined, PFUser.currentUser()!){
            println("else")
            btnImIn.setTitle("I'm Out!", forState: UIControlState())
            relation.removeObject(user!)
            relation2?.removeObject(event)
            pplJoined.removeAtIndex(find(pplJoined, user!)!)
        }
        event.saveInBackground()
        
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
