//
//  Notes+CoreDataProperties.swift
//  Shomer
//
//  Created by David T on 5/6/21.
//
//

import Foundation
import CoreData


extension Notes {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Notes> {
        return NSFetchRequest<Notes>(entityName: "Notes")
    }

    @NSManaged public var title: String?
    @NSManaged public var text: String?
    @NSManaged public var date: String?

}
