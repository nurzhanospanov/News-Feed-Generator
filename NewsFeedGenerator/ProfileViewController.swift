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
        profileImageView = UIImageView(frame: CGRectMake(0, 0, 100, 100))

        /*let backgroundImage = UIImageView(frame: UIScreen.mainScreen().bounds)
        backgroundImage.image = UIImage(named: "0")
        self.view.insertSubview(backgroundImage, atIndex: 0)*/
        gettingImageFromFacebook()
        // Do any additional setup after loading the view.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func gettingImageFromFacebook(){
        /*var facebookProfileUrl = NSURL(string: "http://graph.facebook.com/\(Container.sharedInstance.facebookId)/picture?type=large")
        if let data = NSData(contentsOfURL: facebookProfileUrl!) {
            profileImageView.image = UIImage(data: data)
        }*/
        self.profileImageView.image = Container.sharedInstance.picture
        
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
