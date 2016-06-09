//
//  ChooseResourceViewController.swift
//  NewsFeedGenerator
//
//  Created by nurzhan on 6/7/16.
//  Copyright © 2016 Nurzhan. All rights reserved.
//

import UIKit

class ChooseResourceViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        gettingFacebookID()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func gettingFacebookID()
    {
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
                Container.sharedInstance.facebookId = (userData["id"] as? String!)!
                print("Lol")
                print(Container.sharedInstance.facebookId)
               
                let pictureURL = "https://graph.facebook.com/\(Container.sharedInstance.facebookId)/picture?type=large&return_ssl_resources=1"
                let URLRequest = NSURL(string: pictureURL)
                let URLRequestNeeded = NSURLRequest(URL: URLRequest!)
                NSURLConnection.sendAsynchronousRequest(URLRequestNeeded, queue: NSOperationQueue.mainQueue(), completionHandler: {(response: NSURLResponse?,data: NSData?, error: NSError?) -> Void in
                    
                    if error == nil {
                       let picture = UIImage(data: data!)
                        print(picture)
                        Container.sharedInstance.picture = picture
                        print(Container.sharedInstance.picture)
                        self.imageView.image = picture
                        
                    }
                    else {
                        print("Error: \(error!.localizedDescription)")
                    }
                })

                }
            }
        }
    
    @IBAction func goToProfile(sender: AnyObject) {
        let vc:TabBarViewController = self.storyboard?.instantiateViewControllerWithIdentifier("TabBarViewController") as! TabBarViewController
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
