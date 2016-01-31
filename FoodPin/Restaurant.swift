//
//  Restaurant.swift
//  FoodPin
//
//  Created by Ujjwal Verma on 1/18/16.
//  Copyright © 2016 Intellisoft. All rights reserved.
//

import Foundation

class Restaurant {
    var name = ""
    var type = ""
    var location = ""
    var phone = ""
    var image = ""
    var rating: String?
    var isVisited = false
    
    init(name: String, type: String, location: String, phone: String, image: String, rating: String?, isVisited: Bool) {
        self.name = name
        self.type = type
        self.location = location
        self.phone = phone
        self.image = image
        self.rating = rating
        self.isVisited = isVisited
    }
}