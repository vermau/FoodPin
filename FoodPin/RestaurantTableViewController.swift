//
//  RestaurantTableViewController.swift
//  FoodPin
//
//  Created by Ujjwal Verma on 15/10/2015.
//  Copyright © 2015 Intellisoft. All rights reserved.
//

import UIKit

class RestaurantTableViewController: UITableViewController {
    
    var restaurants:[Restaurant] = [
        
        Restaurant(name: "Cafe Deadend", type: "Coffee & Tea Shop", location: "Hong Kong", image: "cafedeadend.jpg", isVisited: false),
        
        Restaurant(name: "Homei", type: "Cafe", location: "Hong Kong", image: "homei.jpg", isVisited: false),
        
        Restaurant(name: "Teakha", type: "Tea House", location: "Hong Kong", image: "teakha.jpg", isVisited: false),
        
        Restaurant(name: "Cafe loisl", type: "Austrian / Causual Drink", location: "Hong Kong", image: "cafeloisl.jpg", isVisited: false),
        
        Restaurant(name: "Petite Oyster", type: "French", location: "Hong Kong", image: "petiteoyster.jpg", isVisited: false),
        
        Restaurant(name: "For Kee Restaurant", type: "Bakery", location: "Hong Kong", image: "forkeerestaurant.jpg", isVisited: false),
        
        Restaurant(name: "Po's Atelier", type: "Bakery", location: "Hong Kong", image: "posatelier.jpg", isVisited: false),
        
        Restaurant(name: "Bourke Street Backery", type: "Chocolate", location: "Sydney", image: "bourkestreetbakery.jpg", isVisited: false),
        
        Restaurant(name: "Haigh's Chocolate", type: "Cafe", location: "Sydney", image: "haighschocolate.jpg", isVisited: false),
        
        Restaurant(name: "Palomino Espresso", type: "American / Seafood", location: "Sydney", image: "palominoespresso.jpg", isVisited: false),
        
        Restaurant(name: "Upstate", type: "American", location: "New York", image: "upstate.jpg", isVisited: false),
        
        Restaurant(name: "Traif", type: "American", location: "New York", image: "traif.jpg", isVisited: false),
        
        Restaurant(name: "Graham Avenue Meats", type: "Breakfast & Brunch", location: "New York", image: "grahamavenuemeats.jpg", isVisited: false),
        
        Restaurant(name: "Waffle & Wolf", type: "Coffee & Tea", location: "New York", image: "wafflewolf.jpg", isVisited: false),
        
        Restaurant(name: "Five Leaves", type: "Coffee & Tea", location: "New York", image: "fiveleaves.jpg", isVisited: false),
        
        Restaurant(name: "Cafe Lore", type: "Latin American", location: "New York", image: "cafelore.jpg", isVisited: false),
        
        Restaurant(name: "Confessional", type: "Spanish", location: "New York", image: "confessional.jpg", isVisited: false),
        
        Restaurant(name: "Barrafina", type: "Spanish", location: "London", image: "barrafina.jpg", isVisited: false),
        
        Restaurant(name: "Donostia", type: "Spanish", location: "London", image: "donostia.jpg", isVisited: false),
        
        Restaurant(name: "Royal Oak", type: "British", location: "London", image: "royaloak.jpg", isVisited: false),
        
        Restaurant(name: "Thai Cafe", type: "Thai", location: "London", image: "thaicafe.jpg", isVisited: false)
        
        ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // --Set the title of the RestaurantTableViewController
        title = "Food Pin"
        
        // --Remove the title of the backBarButtonItem so that it only shows "<" in the NavigationBar
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.Plain, target: nil, action: nil)

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // Return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows
        return restaurants.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "Cell"
        
        // Forced downcasting the returned cell from UITableViewCell to RestaurantTableViewCell
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! RestaurantTableViewCell

        // Configure the cell...
        cell.lblName.text = restaurants[indexPath.row].name
        cell.lblLocation.text = restaurants[indexPath.row].location
        cell.lblType.text = restaurants[indexPath.row].type
        cell.thumbnailImageView.image = UIImage(named: restaurants[indexPath.row].image)
        
        // Rounding the corners of thumbnailImageView. For a perfect circle, set the corner radius to 30 ( half of the width and height of the thumbnailImageView which is 60 )
        cell.thumbnailImageView.layer.cornerRadius = 30
        cell.thumbnailImageView.clipsToBounds = true
        
        // Set the value of accessortType property by checking the value in the array using the TERNARY OPERATOR for IF ELSE
        cell.accessoryType = restaurants[indexPath.row].isVisited ? UITableViewCellAccessoryType.Checkmark : .None
        
        return cell
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return false
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
    override func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        // Define the DELETE Action
        let deleteAction = UITableViewRowAction(style: UITableViewRowActionStyle.Default, title: "Delete", handler: {(action, indexPath) -> Void in
            // Delete the corresponding row from the Data Source Array
            self.restaurants.removeAtIndex(indexPath.row)
            
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
            let defaultText = "Just checking in at " + self.restaurants[indexPath.row].name
            if let restaurantImage = UIImage(named: self.restaurants[indexPath.row].image) {
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
    }
    
    // Override to support editing the table view -- Row Deletion and Insertion.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            
            // Delete the corresponding row from the Data Source Array
            restaurants.removeAtIndex(indexPath.row)
            
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
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showRestaurantDetailSegue" {
            
            // -- If the user selects a row before clicking the back button in TableView, we will retrieve the indexPath of the row in a variable
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let destinationViewController = segue.destinationViewController as! RestaurantDetailViewController
                destinationViewController.restaurant = restaurants[indexPath.row]
            }
        }
    }

}
