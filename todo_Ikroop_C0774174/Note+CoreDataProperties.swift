//
//  Note+CoreDataProperties.swift
//  todo_Ikroop_C0774174
//
//  Created by VirkIkroop on 2020-06-24.
//  Copyright © 2020 VirkIkroop. All rights reserved.
//
//

import Foundation
import CoreData


extension Note {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Note> {
        return NSFetchRequest<Note>(entityName: "Note")
    }

    @NSManaged public var title: String?
    @NSManaged public var text: String?
    @NSManaged public var days: Int16
    @NSManaged public var dateAdded: Date?
    @NSManaged public var notebook: Notebook?

}
