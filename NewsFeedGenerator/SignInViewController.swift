//
//  SignInViewController.swift
//  NewsFeedGenerator
//
//  Created by nurzhan on 6/7/16.
//  Copyright © 2016 Nurzhan. All rights reserved.
//

import UIKit
import Parse

class SignInViewController: UIViewController {
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
    
    @IBAction func signInButtonPressed(sender: AnyObject) {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.hidden = false
        activityIndicator.startAnimating()
        
        PFUser.logInWithUsernameInBackground(emailTextField.text!, password: passwordTextField.text!) {
            (user: PFUser?, error: NSError?) -> Void in
            if (user!["emailVerified"] as! Bool == true) {
                let vc:ChooseResourceViewController = self.storyboard?.instantiateViewControllerWithIdentifier("ChooseResourceViewController") as! ChooseResourceViewController
                self.presentViewController(vc, animated: true, completion: nil) // successfull login
            } else {
                let alertController = UIAlertController(title: "Email address verification", message: "We have sent you an email that contains a link - you must click this link before you can continue.", preferredStyle: UIAlertControllerStyle.Alert)
                alertController.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.Default, handler: nil))
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
