//
//  ProfileViewController.swift
//  NewsFeedGenerator
//
//  Created by nurzhan on 6/9/16.
//  Copyright © 2016 Nurzhan. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import ParseFacebookUtilsV4
import FBSDKCoreKit

class ProfileViewController: UIViewController {
   
    @IBOutlet weak var profileImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        //profileImageView = UIImageView(frame: CGRectMake(0, 0, 100, 100))

        let backgroundImage = UIImageView(frame: UIScreen.mainScreen().bounds)
        backgroundImage.image = UIImage(named: "0")
        self.view.insertSubview(backgroundImage, atIndex: 0)
        gettingImageFromFacebook()
        // Do any additional setup after loading the view.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func gettingImageFromFacebook(){

        let request = FBSDKGraphRequest(graphPath:"me", parameters:nil)
        // Send request to Facebook
        request.startWithCompletionHandler {
            (connection, result, error) in
            if error != nil {
                // Some error checking here
                print(error)
            }
            else if let userData = result as? [String:AnyObject] {
                // Access user data
                let facebookId = (userData["id"] as? String!)!
                
                let pictureURL = "https://graph.facebook.com/\(facebookId)/picture?type=large&return_ssl_resources=1"
                let URLRequest = NSURL(string: pictureURL)
                let URLRequestNeeded = NSURLRequest(URL: URLRequest!)
                NSURLConnection.sendAsynchronousRequest(URLRequestNeeded, queue: NSOperationQueue.mainQueue(), completionHandler: {(response: NSURLResponse?,data: NSData?, error: NSError?) -> Void in
                    
                    if error == nil {
                        let picture = UIImage(data: data!)
                        self.profileImageView.image = picture
                        
                    }
                    else {
                        print("Error: \(error!.localizedDescription)")
                    }
                })
                
            }
        }

       
        
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
