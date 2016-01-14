//
//  RestaurantTableViewController.swift
//  FoodPin
//
//  Created by Ujjwal Verma on 15/10/2015.
//  Copyright © 2015 Intellisoft. All rights reserved.
//

import UIKit

class RestaurantTableViewController: UITableViewController {
    
    var restaurantNames = ["Cafe Deadend", "Homei", "Teakha", "Cafe Loisl", "Petite Oyster",
        "For Kee Restaurant", "Po's Atelier", "Bourke Street Bakery", "Haigh's Chocolate",
        "Palomino Espresso", "Upstate", "Traif", "Graham Avenue Meats",
        "Waffle & Wolf", "Five Leaves", "Cafe Lore", "Confessional", "Barrafina",
        "Donostia", "Royal Oak", "Thai Cafe"]

    var restaurantImages = ["cafedeadend.jpg", "homei.jpg", "teakha.jpg",
            "cafeloisl.jpg", "petiteoyster.jpg", "forkeerestaurant.jpg", "posatelier.jpg",
            "bourkestreetbakery.jpg", "haighschocolate.jpg", "palominoespresso.jpg",
            "upstate.jpg", "traif.jpg", "grahamavenuemeats.jpg", "wafflewolf.jpg",
            "fiveleaves.jpg", "cafelore.jpg", "confessional.jpg", "barrafina.jpg",
            "donostia.jpg", "royaloak.jpg", "thaicafe.jpg"]
    
    var restaurantLocations = ["Hong Kong", "Hong Kong", "Hong Kong", "Hong Kong",
        "Hong Kong", "Hong Kong", "Hong Kong", "Sydney", "Sydney", "Sydney", "New ￼York",
        "New York", "New York", "New York", "New York", "New York", "New York",
        "London", "London", "London", "London"]
    
    var restaurantTypes = ["Coffee & Tea Shop", "Cafe", "Tea House", "Austrian / Causual Drink",
            "French", "Bakery", "Bakery", "Chocolate", "Cafe", "American / Seafood",
            "American", "American", "Breakfast & Brunch", "Coffee & Tea", "Coffee & Tea",
            "Latin American", "Spanish", "Spanish", "Spanish", "British", "Thai"]
    
    var restaurantIsVisited = [Bool](count: 21, repeatedValue: false)
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
        return restaurantNames.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "Cell"
        
        // Forced downcasting the returned cell from UITableViewCell to RestaurantTableViewCell
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! RestaurantTableViewCell

        // Configure the cell...
        cell.lblName.text = restaurantNames[indexPath.row]
        cell.lblLocation.text = restaurantLocations[indexPath.row]
        cell.lblType.text = restaurantTypes[indexPath.row]
        cell.thumbnailImageView.image = UIImage(named: restaurantImages[indexPath.row])
        
        // Rounding the corners of thumbnailImageView. For a perfect circle, set the corner radius to 30 ( half of the width and height of the thumbnailImageView which is 60 )
        cell.thumbnailImageView.layer.cornerRadius = 10
        cell.thumbnailImageView.clipsToBounds = true
        
        // Set the value of accessortType property by checking the value in the array using the TERNARY OPERATOR for IF ELSE
        cell.accessoryType = restaurantIsVisited[indexPath.row] ? UITableViewCellAccessoryType.Checkmark : .None
        
        return cell
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
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

    // Override to create CUSTOM SWIPE ACTIONS for the selected row in the table view
    override func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        // Define the DELETE Action
        let deleteAction = UITableViewRowAction(style: UITableViewRowActionStyle.Default, title: "Delete", handler: {(action, indexPath) -> Void in
            // Delete the corresponding rows from the Data Source Arrays
            self.restaurantNames.removeAtIndex(indexPath.row)
            self.restaurantLocations.removeAtIndex(indexPath.row)
            self.restaurantTypes.removeAtIndex(indexPath.row)
            self.restaurantImages.removeAtIndex(indexPath.row)
            
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
        let shareAction = UITableViewRowAction(style: UITableViewRowActionStyle.Default, title: "Share", handler: {(action, indexPath) -> Void in
            let defaultText = "Just checking in at " + self.restaurantNames[indexPath.row]
            if let restaurantImage = UIImage(named: self.restaurantImages[indexPath.row]) {
                let activityController = UIActivityViewController(activityItems: [defaultText, restaurantImage], applicationActivities: nil)
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
            
            // Delete the corresponding rows from the Data Source Arrays
            restaurantNames.removeAtIndex(indexPath.row)
            restaurantLocations.removeAtIndex(indexPath.row)
            restaurantTypes.removeAtIndex(indexPath.row)
            restaurantImages.removeAtIndex(indexPath.row)
            
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
                destinationViewController.restaurantImage = restaurantImages[indexPath.row]
            }
        }
    }

}
