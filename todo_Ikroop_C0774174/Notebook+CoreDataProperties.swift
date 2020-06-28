//
//  Notebook+CoreDataProperties.swift
//  todo_Ikroop_C0774174
//
//  Created by VirkIkroop on 2020-06-24.
//  Copyright © 2020 VirkIkroop. All rights reserved.
//
//

import Foundation
import CoreData


extension Notebook {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Notebook> {
        return NSFetchRequest<Notebook>(entityName: "Notebook")
    }

    @NSManaged public var dateCreated: Date?
    @NSManaged public var name: String?
    @NSManaged public var notes: Note?

}
