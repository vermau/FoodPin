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
	
	// ----------------------------------------------------------------------------------------------------------------------
	// -- CORE DATA Stack
	
/*	lazy var applicationDocumentsDirectory: NSURL = {
		// The directory the application uses to store the Core Data store file. This code uses a directory named "com.iqhired.CoreDataDemo" in the application's documents Application Support directory.
		let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
		return urls[urls.count-1]
	}()
	
	lazy var managedObjectModel: NSManagedObjectModel = {
		// The managed object model for the application. This property is not optional. It is a fatal error for the application not to be able to find and load its model.
		let modelURL = NSBundle.mainBundle().URLForResource("Foodpin", withExtension: "momd")!
		return NSManagedObjectModel(contentsOfURL: modelURL)!
	}()
	
	lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
		// The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it. This property is optional since there are legitimate error conditions that could cause the creation of the store to fail.
		// Create the coordinator and store
		let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
		let url = self.applicationDocumentsDirectory.URLByAppendingPathComponent("Foodpin.sqlite")
		var failureReason = "There was an error creating or loading the application's saved data."
		do {
			try coordinator.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: url, options: nil)
		} catch {
			// Report any error we got.
			var dict = [String: AnyObject]()
			dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data"
			dict[NSLocalizedFailureReasonErrorKey] = failureReason
			
			dict[NSUnderlyingErrorKey] = error as NSError
			let wrappedError = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
			// Replace this with code to handle the error appropriately.
			// abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
			NSLog("Unresolved error \(wrappedError), \(wrappedError.userInfo)")
			abort()
		}
		
		return coordinator
	}()
	
	lazy var managedObjectContext: NSManagedObjectContext = {
		// Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.) This property is optional since there are legitimate error conditions that could cause the creation of the context to fail.
		let coordinator = self.persistentStoreCoordinator
		var managedObjectContext = NSManagedObjectContext(concurrencyType: .MainQueueConcurrencyType)
		managedObjectContext.persistentStoreCoordinator = coordinator
		return managedObjectContext
	}()
	
	// MARK: - Core Data Saving support
	
	func saveContext () {
		if managedObjectContext.hasChanges {
			do {
				try managedObjectContext.save()
			} catch {
				// Replace this implementation with code to handle the error appropriately.
				// abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
				let nserror = error as NSError
				NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
				abort()
			}
		}
	} */
}

