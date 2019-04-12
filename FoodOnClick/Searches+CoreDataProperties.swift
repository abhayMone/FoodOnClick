//
//  Searches+CoreDataProperties.swift
//  FoodOnClick
//
//  Created by abhay mone on 4/22/18.
//  Copyright © 2018 abhay mone. All rights reserved.
//

import Foundation
import CoreData


extension Searches {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Searches> {
        return NSFetchRequest<Searches>(entityName: "Searches")
    }

    @NSManaged public var foodItem: String?

}
