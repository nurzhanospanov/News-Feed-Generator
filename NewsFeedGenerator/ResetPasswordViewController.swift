//
//  ResetPasswordViewController.swift
//  NewsFeedGenerator
//
//  Created by nurzhan on 6/7/16.
//  Copyright © 2016 Nurzhan. All rights reserved.
//

import UIKit
import Parse
import Bolts

class ResetPasswordViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
 
    @IBAction func resetButtonPressed(sender: AnyObject) {
        let email = emailTextField.text
        if(email != nil){
            PFUser.requestPasswordResetForEmailInBackground(emailTextField.text!, block: { (result, error) in
              
                if (error == nil) {
                    let emailAlert = UIAlertController (title: "Password Reset", message: "An email containing information on how to reset your password has been sent to " + email! + ".", preferredStyle: UIAlertControllerStyle.Alert)
                    let emailCancel = UIAlertAction (title: "Dismiss", style: .Cancel, handler: nil)
                    
                    emailAlert.addAction(emailCancel)
                    
                    self.presentViewController(emailAlert, animated: true, completion: nil)
                    
                } else {
                    if(error?.code == 205) {
                        let errorAlert = UIAlertController(title: "Error!", message: "no user found with email " + email! + ".", preferredStyle: UIAlertControllerStyle.Alert)
                        let emailCancel = UIAlertAction (title: "Dismiss", style: .Cancel, handler: nil)
                        errorAlert.addAction(emailCancel)
                        self.presentViewController(errorAlert, animated: true, completion: nil)
                    } else {
                        let errorAlert = UIAlertController(title: "Error!", message: "Неизвестная ошибка", preferredStyle: UIAlertControllerStyle.Alert)
                        let emailCancel = UIAlertAction (title: "Dismiss", style: .Cancel, handler: nil)
                        errorAlert.addAction(emailCancel)
                        self.presentViewController(errorAlert, animated: true, completion: nil)

                    }
                }
                
            })
        }
        else{
            let alert = UIAlertView()
            alert.title = "Error!"
            alert.message = "Enter your email."
            alert.addButtonWithTitle("Ok")
            alert.show()
        }
    }

    @IBAction func cancelButtonPressed(sender: AnyObject) {
        let vc:SignInViewController = self.storyboard?.instantiateViewControllerWithIdentifier("SignInViewController") as! SignInViewController
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
