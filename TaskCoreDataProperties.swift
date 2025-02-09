//
//  Task+CoreDataProperties.swift
//  T2_ToDoListApp
//
//  Created by Knapptan on 07.02.2025.
//
//

import Foundation
import CoreData


@objc(Task)
public class Task: NSManagedObject {

}

extension Task {
//    @nonobjc public class func fetchRequest() -> NSFetchRequest<Task> {
//        return NSFetchRequest<Task>(entityName: "Task")
//    }

    @NSManaged public var title: String?
    @NSManaged public var creationDate: Date?
    @NSManaged public var taskDescription: String?
    @NSManaged public var isCompleted: Bool

}

extension Task : Identifiable {

}
