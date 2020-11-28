//
//  Location+CoreDataProperties.swift
//  weatherApp_API
//
//  Created by user182271 on 11/26/20.
//
//

import Foundation
import CoreData


extension Location {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Location> {
        return NSFetchRequest<Location>(entityName: "Location")
    }

    @NSManaged public var city: String?
    @NSManaged public var state: String?
    @NSManaged public var country: String?

}

extension Location : Identifiable {

}
