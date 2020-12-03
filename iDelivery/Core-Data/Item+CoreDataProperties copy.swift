//
//  Item+CoreDataProperties.swift
//  
//
//  Created by mac on 12/3/20.
//
//

import Foundation
import CoreData


extension Item {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Item> {
        return NSFetchRequest<Item>(entityName: "Item")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var phone: String?
    @NSManaged public var image: String?
    @NSManaged public var city: String?
    @NSManaged public var machine: Int16
    @NSManaged public var email: String?
    @NSManaged public var price: String?
    @NSManaged public var returns: String?
    @NSManaged public var stock: String?
    @NSManaged public var parentList: List?

}
