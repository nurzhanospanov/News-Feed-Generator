//
//  SignInViewController.swift
//  NewsFeedGenerator
//
//  Created by nurzhan on 6/7/16.
//  Copyright © 2016 Nurzhan. All rights reserved.
//

import UIKit
import Parse
import FBSDKLoginKit
import ParseFacebookUtilsV4
import FBSDKCoreKit



class SignInViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var facebookLoginButton: UIButton!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        let currentUser = PFUser.currentUser()
        print(currentUser)
        if(currentUser != nil){
            print("i am here")
            let vc:ChooseResourceViewController = self.storyboard?.instantiateViewControllerWithIdentifier("ChooseResourceViewController") as! ChooseResourceViewController
            self.presentViewController(vc, animated: true, completion: nil)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func fbLoginButtonPressed(sender: UIButton) {
        PFFacebookUtils.logInInBackgroundWithReadPermissions(["email", "public_profile"]) {
            (user: PFUser?, error: NSError?) -> Void in
            if let user = user {
                if user.isNew {
                    let loginAlert = UIAlertController(title: "Succesful!", message: "You are signing up through Facebook!", preferredStyle: UIAlertControllerStyle.Alert)
                    let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: {(action:UIAlertAction!) in self.goToResource()})
                    loginAlert.addAction(okAction)
                    self.presentViewController(loginAlert, animated: true, completion: nil)

                } else {
                    let loginAlert = UIAlertController(title: "Succesful!", message: "You are signing up through Facebook!", preferredStyle: UIAlertControllerStyle.Alert)
                    let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: {(action:UIAlertAction!) in self.goToResource()})
                    loginAlert.addAction(okAction)
                    self.presentViewController(loginAlert, animated: true, completion: nil)
                }
            } else {
                let loginAlert = UIAlertController(title: "Error!", message: "Uh oh. The user cancelled the Facebook login.", preferredStyle: UIAlertControllerStyle.Alert)
                self.presentViewController(loginAlert, animated: true, completion: nil)
                
                
            }
        }

    }
    
    
    @IBAction func signInButtonPressed(sender: AnyObject) {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.hidden = false
        activityIndicator.startAnimating()
        
        PFUser.logInWithUsernameInBackground(emailTextField.text!, password: passwordTextField.text!) {
            (user: PFUser?, error: NSError?) -> Void in
            if(error == nil){
            if (user!["emailVerified"] as! Bool == true) {
                let vc:ChooseResourceViewController = self.storyboard?.instantiateViewControllerWithIdentifier("ChooseResourceViewController") as! ChooseResourceViewController
                self.presentViewController(vc, animated: true, completion: nil) // successfull login
            } else {
                let alertController = UIAlertController(title: "Email address verification", message: "We have sent you an email that contains a link - you must click this link before you can continue.", preferredStyle: UIAlertControllerStyle.Alert)
                alertController.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.Default, handler: nil))
                self.presentViewController(alertController, animated: true, completion: nil)                
                
            }
            }else if(error?.code == 101){
                let alertController = UIAlertController(title: "Error!", message: "Incorrect username or password.\nTry again.", preferredStyle: UIAlertControllerStyle.Alert)
                alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default, handler: nil))
                self.presentViewController(alertController, animated: true, completion: nil)
            }else{
                let alertController = UIAlertController(title: "Error!", message: "Unknown error", preferredStyle: UIAlertControllerStyle.Alert)
                alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default, handler: nil))
                self.presentViewController(alertController, animated: true, completion: nil)
            }
        }
    
        
    }
    @IBAction func registrateButtonPressed(sender: AnyObject) {
        
        let vc:SignUpViewController = self.storyboard?.instantiateViewControllerWithIdentifier("SignUpViewController") as! SignUpViewController
        self.presentViewController(vc, animated: true, completion: nil)
    }

    @IBAction func resetPasswordButtonPressed(sender: AnyObject) {
        let vc:ResetPasswordViewController = self.storyboard?.instantiateViewControllerWithIdentifier("ResetPasswordViewController") as! ResetPasswordViewController
        self.presentViewController(vc, animated: true, completion: nil)
    }
    public func goToResource(){
        let vc:ChooseResourceViewController = self.storyboard?.instantiateViewControllerWithIdentifier("ChooseResourceViewController") as! ChooseResourceViewController
        self.presentViewController(vc, animated: true, completion: nil)
    } // function for segue to "ChooseResourcesViewController"

}
