//
//  AppDelegate.swift
//  NewsFeedGenerator
//
//  Created by nurzhan on 6/7/16.
//  Copyright © 2016 Nurzhan. All rights reserved.
//

import UIKit
import Parse
import Bolts
import FBSDKCoreKit
import ParseFacebookUtilsV4



@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        UITabBar.appearance().translucent = false
        UITabBar.appearance().barTintColor = UIColor.blackColor()
        UITabBar.appearance().tintColor = UIColor.whiteColor()
        
        let configuration = ParseClientConfiguration {
            $0.applicationId = "6p64zyBaHpZC3eX3g3qgCm1P4anu58fIHYGoXy5G"
            $0.clientKey = "nSjprCZIsRw1kL6limH3YKl9LnFiYWjIwA5vMjnQ"
            // $0.server = "http://YOUR_PARSE_SERVER:1337/parse" // where is parse server ???
        }
        
        Parse.initializeWithConfiguration(configuration) // parse sign in and sign up configuration
        
        Parse.setApplicationId("6p64zyBaHpZC3eX3g3qgCm1P4anu58fIHYGoXy5G", clientKey:"nSjprCZIsRw1kL6limH3YKl9LnFiYWjIwA5vMjnQ")
        PFFacebookUtils.initializeFacebookWithApplicationLaunchOptions(launchOptions)
        
        FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions) // Facebook sign in

        // Override point for customization after application launch.
        return true
    }
    
    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject) -> Bool {
       return FBSDKApplicationDelegate.sharedInstance().application(application, openURL: url, sourceApplication: sourceApplication, annotation: annotation)
    }
        
        
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        
        FBSDKAppEvents.activateApp()
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


    }

