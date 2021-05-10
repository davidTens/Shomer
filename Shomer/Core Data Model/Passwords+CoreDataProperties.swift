//
//  Passwords+CoreDataProperties.swift
//  Shomer
//
//  Created by David T on 5/5/21.
//
//

import Foundation
import CoreData


extension Passwords {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Passwords> {
        return NSFetchRequest<Passwords>(entityName: "Passwords")
    }

    @NSManaged public var account: String?
    @NSManaged public var app: String?
    @NSManaged public var password: String?
    @NSManaged public var date: String?

}
