//
//  AddGroupViewController.swift
//  whosin
//
//  Created by Micha Schwendener on 22/07/15.
//  Copyright (c) 2015 Micha Schwendener. All rights reserved.
//

import UIKit
import Parse

class CreateGroupViewController: UIViewController {
    
    let baseURLGeocode = "https://maps.googleapis.com/maps/api/geocode/json?"
    
    var lookupAddressResults: Dictionary<NSObject, AnyObject>!
    
    var fetchedFormattedAddress: String!
    
    var fetchedAddressLongitude: Double!
    
    var fetchedAddressLatitude: Double!
    
    
    @IBOutlet weak var groupName: UILabel!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var privateSwitch: UISwitch!
    @IBAction func clickPrivate(sender: UISwitch) {
        if privateSwitch.on {
            keywordLabel.hidden = false
            keywordInput.hidden = false
            locationField.hidden = true
            locationLabel.hidden = true
        } else {
            keywordLabel.hidden = true
            keywordInput.hidden = true
            locationField.hidden = false
            locationLabel.hidden = false
        }
    }
    
    
    @IBOutlet weak var keywordLabel: UILabel!
    @IBOutlet weak var keywordInput: UITextField!
    
    @IBOutlet weak var locationLabel: UILabel!
    
    @IBOutlet weak var locationField: UITextField!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var descriptionTextfield: UITextView!
    
    @IBOutlet weak var saveButton: UIButton!
    
    @IBAction func save(sender: UIButton) {
        let group = PFObject(className: "group")
        group["name"] = nameField.text
        group["description"] = descriptionTextfield.text
        
        if privateSwitch.on {
            group["keyword"] = keywordInput.text
            
            
            group.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
                println("Object has been saved")
                
                let groupUser = PFObject(className: "group_user")
                groupUser["groupId"] = group.objectId
                groupUser["userId"] = PFUser.currentUser()?.objectId
                groupUser.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
                    println("fuck yes")
                }
                
            }

        } else  {
            
            
            var inputLocation = locationField.text
            
            geocodeAddress(inputLocation, withCompletionHandler: { (status, success) -> Void in
                if !success {
                    println(status)
                    
                    if status == "ZERO_RESULTS" {
                        println("The location could not be found.")
                    }
                }
                else {
                    group["lat"] = self.fetchedAddressLatitude
                    group["lng"] = self.fetchedAddressLongitude
                    group["location"] = self.fetchedFormattedAddress
                    
                    group.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
                        println("Object has been saved")
                        
                        let groupUser = PFObject(className: "group_user")
                        groupUser["groupId"] = group.objectId
                        groupUser["userId"] = PFUser.currentUser()?.objectId
                        groupUser.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
                            println("fuck yes")
                        
                        }
                        
                    }
                }
            })
        }
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func geocodeAddress(address: String!, withCompletionHandler completionHandler: ((status: String, success: Bool) -> Void)) {
        if let lookupAddress = address {
            var geocodeURLString = baseURLGeocode + "address=" + lookupAddress
            geocodeURLString = geocodeURLString.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!
            
            let geocodeURL = NSURL(string: geocodeURLString)
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                let geocodingResultsData = NSData(contentsOfURL: geocodeURL!)
                
                var error: NSError?
                let dictionary: Dictionary<NSObject, AnyObject> = NSJSONSerialization.JSONObjectWithData(geocodingResultsData!, options: NSJSONReadingOptions.MutableContainers, error: &error) as! Dictionary<NSObject, AnyObject>
                
                if (error != nil) {
                    println(error)
                    completionHandler(status: "", success: false)
                }
                else {
                    // Get the response status.
                    let status = dictionary["status"] as! String
                    
                    if status == "OK" {
                        let allResults = dictionary["results"] as! Array<Dictionary<NSObject, AnyObject>>
                        self.lookupAddressResults = allResults[0]
                        
                        // Keep the most important values.
                        self.fetchedFormattedAddress = self.lookupAddressResults["formatted_address"] as! String
                        let geometry = self.lookupAddressResults["geometry"] as! Dictionary<NSObject, AnyObject>
                        self.fetchedAddressLongitude = ((geometry["location"] as! Dictionary<NSObject, AnyObject>)["lng"] as! NSNumber).doubleValue
                        self.fetchedAddressLatitude = ((geometry["location"] as! Dictionary<NSObject, AnyObject>)["lat"] as! NSNumber).doubleValue
                        
                        completionHandler(status: status, success: true)
                    }
                    else {
                        completionHandler(status: status, success: false)
                    }
                }
            })
        }
        else {
            completionHandler(status: "No valid address.", success: false)
        }
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()

        if privateSwitch.on {
            keywordLabel.hidden = false
            keywordInput.hidden = false
            locationField.hidden = true
            locationLabel.hidden = true
        } else {
            keywordLabel.hidden = true
            keywordInput.hidden = true
            locationField.hidden = false
            locationLabel.hidden = false
        }
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
