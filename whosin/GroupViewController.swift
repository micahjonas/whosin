//
//  GroupViewController.swift
//  whosin
//
//  Created by X Code User on 7/22/15.
//  Copyright (c) 2015 Micha Schwendener. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class GroupViewController: UIViewController {
    
    var results = [PFObject]()
    
    let baseURLGeocode = "https://maps.googleapis.com/maps/api/geocode/json?"
    
    var lookupAddressResults: Dictionary<NSObject, AnyObject>!
    
    var fetchedFormattedAddress: String!
    
    var fetchedAddressLongitude: Double!
    
    var fetchedAddressLatitude: Double!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        if privateSwitch.on {
            passwordLabel.text = "keyword"
        } else {
            passwordLabel.text = "location"
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var passwortField: UITextField!
    @IBOutlet weak var passwordLabel: UILabel!

    @IBOutlet weak var privateSwitch: UISwitch!

    @IBAction func clickPrivate(sender: UIButton) {
        if privateSwitch.on {
            passwordLabel.text = "keyword"
        } else {
            passwordLabel.text = "location"
        }
    }
    @IBAction func search(sender: AnyObject) {
        if(privateSwitch.on){
            let query = PFQuery(className: "group")
            query.whereKey("name", equalTo: nameField.text)
            query.whereKey("keyword", equalTo: passwortField.text)
            
            query.findObjectsInBackgroundWithBlock{(objects: [AnyObject]?, error: NSError?) in
                self.results = []
                for object in objects! {
                    
                    self.results.append(object as! PFObject)
                    
                }
                self.performSegueWithIdentifier("resultList", sender: self)
            }

            
        } else {
            let query = PFQuery(className: "group")
            if nameField.text != nil || nameField != "" {
                query.whereKey("searchname", containsString: nameField.text)
                println(nameField.text)
            }
            
            if passwortField.text != nil {
            
                geocodeAddress(passwortField.text, withCompletionHandler: { (status, success) -> Void in
                    if !success {
                        println(status)
                        
                        if status == "ZERO_RESULTS" {
                            println("The location could not be found.")
                        }
                    }
                    else {
                        
                        let lat = self.calcMinMaxLat(self.fetchedAddressLatitude)
                        query.whereKey("lat", greaterThan: lat.0)
                        query.whereKey("lat", lessThan: lat.1)
                        let lng = self.calcMinMaxLng(self.fetchedAddressLatitude, lng:self.fetchedAddressLongitude)
                        query.whereKey("lng", greaterThan: lng.0)
                        query.whereKey("lng", lessThan: lng.1)
                        query.findObjectsInBackgroundWithBlock{(objects: [AnyObject]?, error: NSError?) in
                            
                            self.results = []
                            for object in objects! {
                                
                                self.results.append(object as! PFObject)

                            }
                            
                            self.performSegueWithIdentifier("resultList", sender: self)
                        }
                        
                    }
                })
            } else {
            
                query.findObjectsInBackgroundWithBlock{(objects: [AnyObject]?, error: NSError?) in
                    
                    
                    println(objects)
                    self.performSegueWithIdentifier("resultList", sender: self)

                    
                }
            }
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "resultList" {
            
            
            (segue.destinationViewController as? ResultTableViewController)?.title = "Results"
            (segue.destinationViewController as? ResultTableViewController)?.results = results
        }
    }



            
    
    func calcMinMaxLat(lat:Double) ->(Double, Double) {
        var min = lat - 0.2
        var max = lat + 0.2
        return (min, max)
    }
    
    func calcMinMaxLng(lat:Double, lng:Double) ->(Double, Double) {
        var radiant = lat*M_PI/180
        var dis: Double = abs((20*360)/(2*6373*cos(radiant)*M_PI))
        var min = lng - dis
        var max = lng + dis
        return (min,max)
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

    
    
    
    @IBOutlet weak var resultTable: UITableView!
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
