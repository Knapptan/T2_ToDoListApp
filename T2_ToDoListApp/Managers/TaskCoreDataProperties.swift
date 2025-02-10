//
//  Task+CoreDataProperties.swift
//  T2_ToDoListApp
//
//  Created by Knapptan on 07.02.2025.
//
//

import Foundation
import CoreData


@objc(TaskModel)
public class TaskModel: NSManagedObject {

}

extension TaskModel {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<TaskModel> {
        return NSFetchRequest<TaskModel>(entityName: "TaskModel")
    }
    
    @NSManaged public var taskId: UInt32
    @NSManaged public var userId: UInt32
    @NSManaged public var taskTitle: String?
    @NSManaged public var taskCreationDate: Date
    @NSManaged public var taskDescription: String?
    @NSManaged public var isTaskCompleted: Bool

}

extension TaskModel : Identifiable {

}
