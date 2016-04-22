//
//  Controller.swift
//  FoodPin
//
//  Created by Ujjwal Verma on 3/14/16.
//  Copyright © 2016 Intellisoft. All rights reserved.
//

import UIKit

class StateController: UIViewController {
    internal var modelController: ModelController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let destinationViewController = segue.destinationViewController as? StateController {
            destinationViewController.modelController = self.modelController
        }
    }
    
    internal func prepareForDestinationViewController(destinationViewController: UIViewController) {
        if let destinationVC = destinationViewController as? StateController {
            destinationVC.modelController = self.modelController
        }
    }
}
