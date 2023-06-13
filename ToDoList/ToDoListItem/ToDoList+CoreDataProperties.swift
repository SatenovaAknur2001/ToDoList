//
//  ToDoList+CoreDataProperties.swift
//  
//
//  Created by Aknura Kanabekova on 13.06.2023.
//
//

import Foundation
import CoreData


extension ToDoList {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ToDoList> {
        return NSFetchRequest<ToDoList>(entityName: "ToDoList")
    }

    @NSManaged public var name: String?
    @NSManaged public var createdAt: Date?

}
