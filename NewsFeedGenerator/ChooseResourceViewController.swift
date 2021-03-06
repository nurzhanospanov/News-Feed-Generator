//
//  ChooseResourceViewController.swift
//  NewsFeedGenerator
//
//  Created by nurzhan on 6/7/16.
//  Copyright © 2016 Nurzhan. All rights reserved.
//

import UIKit
import Parse

class ChooseResourceViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet weak var tableView: UITableView!
    var resources = [PFObject]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.loadResourcesFromParse()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadResourcesFromParse() {
        
        let query = PFQuery(className:"Resource")
        
        query.findObjectsInBackgroundWithBlock { (resourcesFromParse, error) in
            print(resourcesFromParse)
            if (error == nil) {
                if (resourcesFromParse != nil) {
                    self.resources = resourcesFromParse!
                    self.tableView.reloadData()
                }
            } else {
                print("Error: \(error!) \(error!.userInfo)")
            }
        }
        
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.resources.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: ChooseResourceTableViewCell = tableView.dequeueReusableCellWithIdentifier("ChooseResourceTableViewCell") as! ChooseResourceTableViewCell

        let resource = resources[indexPath.row]
        let imageFile = resource["logo"] as? PFFile
        
        imageFile!.getDataInBackgroundWithBlock({ (imageData: NSData?, error: NSError?) -> Void in
            guard let data = imageData, image = UIImage(data: data) else {return}
                cell.imageView!.image = image
            })
        
        //cell.textLabel!.text = resource["name"] as? String

        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        var userResource = PFObject(className: "UserResource")
        userResource["user"] = PFUser.currentUser()
        userResource["resource"] = resources[indexPath.row]
        
        userResource.saveInBackgroundWithBlock { (success, error) in
            if (success) {
                print("ok")
            } else {
                print("error")
            }
        }
    }
    
}
