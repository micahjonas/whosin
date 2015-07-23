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
            //query.whereKey("searchname", containsString: .text)
            query.whereKey("keyword", equalTo: passwortField.text)
            
            println(query.findObjects())
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
