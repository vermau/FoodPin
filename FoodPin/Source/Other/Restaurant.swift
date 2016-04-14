//
//  Restaurant.swift
//  FoodPin
//
//  Created by Ujjwal Verma on 1/18/16.
//  Copyright © 2016 Intellisoft. All rights reserved.
//

import Foundation
import CoreData

class Restaurant: NSManagedObject {

    // ----------------------------------------------------------------------------------------------------------------------
    // -- Properties
    
	@NSManaged var name: String
    @NSManaged var type: String
    @NSManaged var location: String
    @NSManaged var phone: String?
    @NSManaged var image: NSData?
    @NSManaged var rating: String?
    @NSManaged var isVisited: NSNumber?

    // ----------------------------------------------------------------------------------------------------------------------
    // -- Initializers
    
    /*init(){
		super.init()
	}
    init(name: String, type: String, location: String, phone: String?, image: NSData?, rating: String?, isVisited: NSNumber?) {
        self.name = name
        self.type = type
        self.location = location
        self.phone = phone
        self.image = image
        self.rating = rating
        self.isVisited = isVisited
    }*/
}