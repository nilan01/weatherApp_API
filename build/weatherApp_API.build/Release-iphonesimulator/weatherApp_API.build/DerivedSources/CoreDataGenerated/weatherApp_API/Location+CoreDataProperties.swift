//
//  Location+CoreDataProperties.swift
//  
//
//  Created by user182271 on 11/30/20.
//
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension Location {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Location> {
        return NSFetchRequest<Location>(entityName: "Location")
    }

    @NSManaged public var city: String?
    @NSManaged public var country: String?

}

extension Location : Identifiable {

}
