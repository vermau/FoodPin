//
//  RestaurantTableViewController.swift
//  FoodPin
//
//  Created by Ujjwal Verma on 15/10/2015.
//  Copyright © 2015 Intellisoft. All rights reserved.
//

import UIKit
import CoreData

class RestaurantTableViewController: StateController, NSFetchedResultsControllerDelegate {
    @IBOutlet weak var restaurantListTableView: UITableView!

	private var fetchResultController: NSFetchedResultsController!
    private var restaurantListDelegate: RestaurantListDelegate!
    
    private func loadDataFromDatabase() {
        let fetchRequest = NSFetchRequest(entityName: "Restaurant")
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        if let managedObjectContext = modelController?.managedObjectContext {
            fetchResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
            fetchResultController.delegate = self
            
            do {
                try fetchResultController.performFetch()
                modelController.restaurants = fetchResultController.fetchedObjects as! [Restaurant]
            } catch {
                print(error)
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Food Pin"
        
        //	-- Load data into the TableView from Database. First time it loads all data. Subsequently it loads only changed data
        self.loadDataFromDatabase()
        restaurantListDelegate = RestaurantListDelegate(restaurants: modelController.restaurants)
        restaurantListTableView.dataSource = restaurantListDelegate
        restaurantListTableView.delegate = restaurantListDelegate
        
        // --Remove the title of the backBarButtonItem so that it only shows "<" in the NavigationBar
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.Plain, target: nil, action: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        //restaurantListTableView.reloadData()
        // --Hide the NavigationBar when the user scrolls down
        navigationController?.hidesBarsOnSwipe = true
    }

	// ----------------------------------------------------------------------------------------------------------------------
	// -- NSFetchedResultsControllerDelegate Protocol Methods
	
	func controllerWillChangeContent(controller: NSFetchedResultsController) {
		restaurantListTableView.beginUpdates()
	}
	
	func controller(controller: NSFetchedResultsController, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
		switch (type) {
		case NSFetchedResultsChangeType.Insert:
			if let indexPathForNewRecord = newIndexPath {
				restaurantListTableView.insertRowsAtIndexPaths([indexPathForNewRecord], withRowAnimation: .Fade)
			}
		case NSFetchedResultsChangeType.Delete:
			if let indexPathForDeletedRecord = indexPath {
				restaurantListTableView.deleteRowsAtIndexPaths([indexPathForDeletedRecord], withRowAnimation: .Fade)
			}
		case NSFetchedResultsChangeType.Update:
			if let indexPathForUpdatedRecord = indexPath {
				restaurantListTableView.reloadRowsAtIndexPaths([indexPathForUpdatedRecord], withRowAnimation: .Fade)
			}
		default:
			restaurantListTableView.reloadData()
		}
		
		modelController.restaurants = controller.fetchedObjects as! [Restaurant]
        
        /*
                -- Update the restaurant list in "RestaurantListDataSource"
                -- 'cuz the TableView ADDS or DELETES the rows based on count returned by the TableViewDataSource
        */
        restaurantListDelegate.upadteRestaurantList(modelController.restaurants)

	}
	
	func controllerDidChangeContent(controller: NSFetchedResultsController) {
        /*
            -- At this stage the TableView calls the methods of "UITableViewDataSource" protocol
            -- to refresh the no of rows in the TableView and to update the data in the TableView
        */
		restaurantListTableView.endUpdates()
	}

    
    /*
        -- This method is called when a row is selected in the Table
    */
    /*override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var visitedTitle = "I have been here"
        let optionMenu = UIAlertController(title: nil, message: "What do you want to do ??", preferredStyle: UIAlertControllerStyle.ActionSheet)
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil)
        
        //    -- Create an ActionHandler for the Call button in the form of CLOSURE
        let callActionHandler = { (action: UIAlertAction) -> Void in
            let callAlertMessage = UIAlertController(title: "Service Unavailable", message: "Sorry this feature is not active yet !!", preferredStyle: .Alert)
            callAlertMessage.addAction(UIAlertAction(title: "Okay", style: .Default, handler: nil))
            self.presentViewController(callAlertMessage, animated: true, completion: nil)
        }
        
        //    -- Create the Call Action and add the callActionHandler to it for handling the action on pressing Call button
        let callAction = UIAlertAction(title: "Call " + "03-947-\(indexPath.row)-3000", style: UIAlertActionStyle.Default, handler: callActionHandler)
        
        visitedTitle = !restaurantIsVisited[indexPath.row] ? "I have been here" : "I have not been here"
        let isVisitedAction = UIAlertAction(title: visitedTitle, style: UIAlertActionStyle.Default,
            handler: { // Writing an INLINE CLOSURE for Action Handler. This is the preferred style for declaring Action Handlers
                (action: UIAlertAction) -> Void in
                self.restaurantIsVisited[indexPath.row] = self.restaurantIsVisited[indexPath.row] ? false : true
                let cell = tableView.cellForRowAtIndexPath(indexPath)
                cell?.accessoryType = self.restaurantIsVisited[indexPath.row] ? .Checkmark : .None
                //cell?.accessoryType = UITableViewCellAccessoryType.Checkmark
                tableView.deselectRowAtIndexPath(indexPath, animated: false)
            })
        
        optionMenu.addAction(callAction)
        optionMenu.addAction(isVisitedAction)
        optionMenu.addAction(cancelAction)
        
        self.presentViewController(optionMenu, animated: true, completion: nil)
    }*/


    /*
                    ---------------------------------------
                        Mark: - TableView editing
                    ---------------------------------------
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*func activityViewController(activityController: UIActivityViewController, itemForActivityType activityType: String) -> AnyObject? {
        if activityType == UIActivityTypePostToFacebook {
            message = "Posting: Just checking in at " + self.restaurantNames
        }
    }*/
    
    // Override to create CUSTOM SWIPE ACTIONS for the selected row in the table view
    /*override func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        // Define the DELETE Action
        let deleteAction = UITableViewRowAction(style: UITableViewRowActionStyle.Default, title: "Delete", handler: {(action, indexPath) -> Void in
            // Delete the corresponding row from the Data Source Array
            self.modelController.restaurants.removeAtIndex(indexPath.row)
            
            /*  -- Delete the row from the UITableView
            -- The deleteRowsAtIndexPaths method takes in two parameters:
            1. An array of indexPath
            2. Row animation type
            -- Here we just pass the method with the current indexPath and specify to use the fade animation
            */
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Fade)
            })

        /*
            // -- Important Point To Be Notes Here
            // As per new policy of Facebook, setting the Initial Text for any message posted to the Facebook app
            // ( if Facebook app is installed on user's device and tries to POST on facebook from your app )
            // is wrong and is not supported by the Facebook app. Images can be POSTED though.
            // Facebook automatically removes the Initial Text even if your try to post it through your code
            // However if Facebook app is not installed on device and user logins to Facebook account through Settings
            // He will be able to post DEFAULT TEXT Message along with Image as this still works
        */

        // Define the SOCIAL SHARING Action
        let shareAction = UITableViewRowAction(style: UITableViewRowActionStyle.Default, title: "Share", handler: {(action: UITableViewRowAction, indexPath: NSIndexPath) -> Void in
            let defaultText = "Just checking in at " + self.modelController.restaurants[indexPath.row].name
            if let restaurantImage = UIImage(data: self.modelController.restaurants[indexPath.row].image!) {
                let activityController = UIActivityViewController(activityItems: [defaultText, restaurantImage], applicationActivities: nil)
                
                // -- Excluded activities from the activityController
                activityController.excludedActivityTypes =  [
                                                                UIActivityTypeAirDrop, UIActivityTypePrint,
                                                                UIActivityTypeAddToReadingList, UIActivityTypeAssignToContact,
                                                                UIActivityTypeSaveToCameraRoll, UIActivityTypeCopyToPasteboard,
                                                                UIActivityTypeOpenInIBooks, UIActivityTypeMessage,
                                                                UIActivityTypePostToWeibo, UIActivityTypePostToTencentWeibo
                                                            ]
                
                // -- Present activityController on the screen
                self.presentViewController(activityController, animated: true, completion: nil)
            }
            })
        
        // Changing the Background Color of Action Buttons in UITableViewRowAction
        shareAction.backgroundColor = UIColor(red: 245.0/255.0, green: 215.0/255.0, blue: 110.0/255.0, alpha: 1.0)
        deleteAction.backgroundColor = UIColor(red: 246.0/255.0, green: 71.0/255.0, blue: 71.0/255.0, alpha: 1.0)

        // Return an array of UITableViewRowAction objects in order to create CUSTOM ACTION BUTTONS for SWIPE on the row
        return [deleteAction, shareAction]
    }*/
    
    // Override to support editing the table view -- Row Deletion and Insertion.
    /*override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            
            // Delete the corresponding row from the Data Source Array
            modelController.restaurants.removeAtIndex(indexPath.row)
            
            /*  -- Delete the row from the UITableView
                -- The deleteRowsAtIndexPaths method takes in two parameters: 
                        1. An array of indexPath
                        2. Row animation type
                -- Here we just pass the method with the current indexPath and specify to use the fade animation
            */
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }*/

    /*.
                    ---------------------------------------
                        Mark: - StatusBar customization
                    ---------------------------------------
    */
    override func prefersStatusBarHidden() -> Bool {
        return false
    }
    
    /*override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }*/

	@IBAction func close(segue: UIStoryboardSegue) {
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        super.prepareForSegue(segue, sender: sender)
        if segue.identifier == "restaurantDetail" {
            if let _ = segue.destinationViewController as? RestaurantDetailViewController, let indexPath = restaurantListTableView.indexPathForSelectedRow {
                modelController.selectedRestaurant = modelController.restaurants[indexPath.row]
            }
        } else if segue.identifier == "addRestaurant" {
            if let navController = segue.destinationViewController as? IQhiredNavigationController {
                let destinationViewController = navController.viewControllers.first as? AddRestaurantController
                destinationViewController!.modelController = self.modelController
            }
        }
    }
    
    class RestaurantListDelegate: NSObject, UITableViewDataSource, UITableViewDelegate {
        private var restaurants: [Restaurant]!
        
        init(restaurants: [Restaurant]) {
            self.restaurants = restaurants
        }
        
        func numberOfSectionsInTableView(tableView: UITableView) -> Int {
            return 1
        }

        func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return restaurants.count
        }
        
        func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! RestaurantTableViewCell
            let restaurant = restaurantAtIndexPath(indexPath)
            
            cell.backgroundColor = UIColor.clearColor()
            
            // --Configure the custom cell with required values
            cell.name = restaurant.name
            cell.type = restaurant.type
            cell.location = restaurant.location
            cell.restaurantImage = "restaurant"
            
            return cell
        }
        
        private func upadteRestaurantList(restaurants: [Restaurant]) {
            self.restaurants = restaurants
        }
        
        private func restaurantAtIndexPath(indexPath: NSIndexPath) -> Restaurant {
            return restaurants[indexPath.row]
        }
    }
}
