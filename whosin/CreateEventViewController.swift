//
//  EventViewController.swift
//  whosin
//
//  Created by X Code User on 7/22/15.
//  Copyright (c) 2015 Micha Schwendener. All rights reserved.
//

import UIKit
import Parse


class CreateEventViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var txtDate: UITextField!
    @IBOutlet weak var txtTime: UITextField!
    @IBOutlet weak var txtGroups: UITextField!
    @IBOutlet weak var txtLocation: UITextField!
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtDescription: UITextView!
   
    //MARK: - Button operations
    
    @IBAction func btnSave(sender: AnyObject) {
        let event = PFObject(className: "event")
        event["name"] = txtName.text
        event["date"] = txtDate.text
        event["time"] = txtTime.text
        event["location"] = txtLocation.text
        event["groups"] = txtGroups.text
        event["description"] = txtDescription.text
        
        event.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
            println("Object has been saved")
            
            let relation = PFUser.currentUser()?.relationForKey("groups")
            
            relation?.addObject(event)
            
            PFUser.currentUser()?.saveInBackground()
            
            self.navigationController?.popViewControllerAnimated(true)
        }
        
        func btnCancel(sender: AnyObject) {
            self.navigationController?.popViewControllerAnimated(true)
            
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

    
}




