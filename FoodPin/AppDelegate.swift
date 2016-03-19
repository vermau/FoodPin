//
//  AppDelegate.swift
//  FoodPin
//
//  Created by Ujjwal Verma on 15/10/2015.
//  Copyright © 2015 Intellisoft. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        let modelController = ModelController()

        if let initialController = window?.rootViewController {
            if initialController.isKindOfClass(UINavigationController) {
                let navController = initialController as! IQhiredNavigationController
                if let controller = navController.viewControllers.first as? StateController {
                    controller.modelController = modelController
                }
            }
        }

        // --Change the Status Bar to light color for the entire application
        UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.LightContent
        
        // --Change the background color of the Navigation Bar for whole application
        //UINavigationBar.appearance().barTintColor = COLORS.SEAGREEN.toUIColor()

        // --Change the foreground color of the Navigation Bar for whole application
        //UINavigationBar.appearance().tintColor = COLORS.WHITE.toUIColor()
        
        // --Change the font of the Navigation Bar
        /*if let barFont = UIFont(name: "Avenir-Light", size: 24.0) {
            UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName: COLORS.BLACK.toUIColor(), NSFontAttributeName: barFont]
			//UINavigationBar.appearance().titleTextAttributes = [NSFontAttributeName: barFont]
        }*/

        return true
    }
}

