//
//  TabBarController.swift
//  whosin
//
//  Created by Micha Schwendener on 21/07/15.
//  Copyright (c) 2015 Micha Schwendener. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class TabBarController: UITabBarController, PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        if PFUser.currentUser() == nil {
            var loginCtrl = PFLogInViewController()
            loginCtrl.fields = PFLogInFields.Facebook
            loginCtrl.facebookPermissions = ["public_profile", "email", "user_friends"]
            //loginCtrl.facebookPermissions = ["friends_about_me"]
            loginCtrl.delegate = self
            
            var logInLogoTitle = UILabel()
            logInLogoTitle.text = "Who's in"
            
            loginCtrl.logInView!.logo = logInLogoTitle
            
            self.presentViewController(loginCtrl, animated: true, completion: nil)
            
        }        
    }
    
    func getFBData(user: PFUser!){
        FBRequestConnection.startForMeWithCompletionHandler({connection, result, error in
            if (error != nil) {
                println(result)
            }else {
                println("Error")
            }
        })
    }
    
    func getUserInfo() {
        
        if let session = PFFacebookUtils.session() {
            if session.isOpen {
                println("session is open")
                FBRequestConnection.startForMeWithCompletionHandler({
                    (connection: FBRequestConnection!, result: AnyObject!, error: NSError!) -> Void in
                    //println("done me request")
                    if error != nil { println("facebook me request - error is not nil :(") }
                    else { println("facebook me request - error is nil :) ")
                        let urlUserImg = "http://graph.facebook.com/\(result.objectID)/picture?type=large"
                        let firstName = result.first_name
                        let lastName = result.last_name }
                })
            }
        } else {
            //let user:PFUser = PFUser.currentUser()
            //println("ohooo \(user)")
        }
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func logInViewController(logInController: PFLogInViewController, didFailToLogInWithError error: NSError?) {
        println("login failed")
    }
    
    func logInViewControllerDidCancelLogIn(logInController: PFLogInViewController) {
        println("login canceled by user")
    }
    
    func signUpViewController(signUpController: PFSignUpViewController, didSignUpUser user: PFUser) {
        self.dismissViewControllerAnimated(true, completion: nil)
        //self.loginMessage.text = user.username
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
