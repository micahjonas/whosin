//
//  AddGroupViewController.swift
//  whosin
//
//  Created by Micha Schwendener on 22/07/15.
//  Copyright (c) 2015 Micha Schwendener. All rights reserved.
//

import UIKit

class CreateGroupViewController: UIViewController {

    @IBOutlet weak var groupName: UILabel!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var privateSwitch: UISwitch!
    @IBAction func clickPrivate(sender: UISwitch) {
        
        
        
        
    }
    
    
    @IBOutlet weak var keywordLabel: UILabel!
    @IBOutlet weak var keywordInput: UITextField!
    
    @IBOutlet weak var locationLabel: UILabel!
    
    @IBOutlet weak var locationField: UITextField!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var descriptionTextfield: UITextView!
    
    @IBOutlet weak var saveButton: UIButton!
    
    @IBAction func save(sender: UIButton) {
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
