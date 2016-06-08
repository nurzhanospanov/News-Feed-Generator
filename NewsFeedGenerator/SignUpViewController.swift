//
//  SignUpViewController.swift
//  NewsFeedGenerator
//
//  Created by nurzhan on 6/7/16.
//  Copyright © 2016 Nurzhan. All rights reserved.
//

import UIKit
import Parse
import Bolts
import ParseFacebookUtilsV4
import FBSDKCoreKit


class SignUpViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!

    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func signUpButtonPressed(sender: UIButton) {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.hidden = false
        activityIndicator.startAnimating()
        
        let user = PFUser()
        user.email = emailTextField.text
        user.password = passwordTextField.text
        user.username = user.email
        
        print("I am here")
        user.signUpInBackgroundWithBlock {
            (succeeded: Bool, error: NSError?) -> Void in
            if(error == nil){
                let alertController = UIAlertController(title: "Email address verification", message: "We have sent you an email that contains a link - you must click this link before you can continue.", preferredStyle: UIAlertControllerStyle.Alert)
                alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: { alertController in self.processSignOut()}))
                self.presentViewController(alertController, animated: true, completion: nil)
            }
            else{
                let alert = UIAlertView()
                alert.title = "Error!"
                alert.message = "Error."
                alert.addButtonWithTitle("Ok")
                alert.show()
            }
        }
        
    }
    @IBAction func closeButtonPressed(sender: AnyObject) {
        let vc:SignInViewController = self.storyboard?.instantiateViewControllerWithIdentifier("SignInViewController") as! SignInViewController
        self.presentViewController(vc, animated: true, completion: nil)
        
    }
    @IBAction func enterButtonPressed(sender: AnyObject) {
        let vc:SignInViewController = self.storyboard?.instantiateViewControllerWithIdentifier("SignInViewController") as! SignInViewController
        self.presentViewController(vc, animated: true, completion: nil)
    }
    
    func processSignOut() {
        
        // // Sign out
        PFUser.logOut()
        
        // Display sign in / up view controller
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier("SignInViewController") as! SignInViewController
        self.presentViewController(vc, animated: true, completion: nil)
    }

    @IBAction func fbLoginButtonPressed(sender: AnyObject) {
        PFFacebookUtils.logInInBackgroundWithReadPermissions(["email", "public_profile"]) {
            (user: PFUser?, error: NSError?) -> Void in
            if let user = user {
                if user.isNew {
                    let vc:ViewController = self.storyboard?.instantiateViewControllerWithIdentifier("ViewController") as! ViewController
                    self.presentViewController(vc, animated: true, completion: nil)
                    
                } else {
                    let loginAlert = UIAlertController(title: "Succesful!", message: "You are signing up through Facebook!", preferredStyle: UIAlertControllerStyle.Alert)
                    let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: {(action:UIAlertAction!) in self.goToResource()})
                    loginAlert.addAction(okAction)
                    self.presentViewController(loginAlert, animated: true, completion: nil)                }
            } else {
                let loginAlert = UIAlertController(title: "Error!", message: "Uh oh. The user cancelled the Facebook login.", preferredStyle: UIAlertControllerStyle.Alert)
                self.presentViewController(loginAlert, animated: true, completion: nil)

                
            }
        }
        

    }
    public func goToResource(){
        let vc:ChooseResourceViewController = self.storyboard?.instantiateViewControllerWithIdentifier("ChooseResourceViewController") as! ChooseResourceViewController
        self.presentViewController(vc, animated: true, completion: nil)
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
