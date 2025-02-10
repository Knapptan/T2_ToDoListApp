//
//  CoreDataManager.swift
//  T2_ToDoListApp
//
//  Created by Knapptan on 07.02.2025.
//

import CoreData
import Foundation

// MARK: - CRUD
public final class CoreDataManager {
    public static let shared = CoreDataManager()
    private init() {}
    
    // MARK: - Core Data stack
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "T2_ToDoListApp")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: Acsess to viewContext
    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }

    // MARK: - Core Data Saving support
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    // MARK: - CRUD Operations
    
    // MARK: Create new task
    func createNewTask(taskTitle: String? = nil, taskDescription: String? = nil, isTaskCompleted: Bool = false, userId: UInt32 = 0) {
        let task = TaskModel(context: viewContext)
        
        task.taskId = UInt32(Date().timeIntervalSince1970)
        task.taskTitle = taskTitle
        task.taskDescription = taskDescription
        task.taskCreationDate = Date()
        task.isTaskCompleted = isTaskCompleted
        task.userId = userId
        
        saveContext()
    }
    
    // MARK: Read all tasks
    func fetchTasks() -> [TaskModel] {
        let request: NSFetchRequest<TaskModel> = TaskModel.fetchRequest()
        do {
            return try viewContext.fetch(request)
        } catch {
            print("Error uplaod tasks: \(error)")
               return []
        }
    }
    
    // MARK: Update task
    func updateTask(task: TaskModel, newTaskTitle: String?, newTaskDescription: String?, newIsTaskCompleted: Bool?) {

        if let newTaskTitle = newTaskTitle {
            task.taskTitle = newTaskTitle
        }
        if let newTaskDescription = newTaskDescription {
            task.taskDescription = newTaskDescription
        }
        if let newIsTaskCompleted = newIsTaskCompleted {
            task.isTaskCompleted = newIsTaskCompleted
        }
        
        saveContext()
    }
    
    func updateTaskModel(_ task: TaskModel, updateBlock: (TaskModel) -> Void) {
        updateBlock(task)
        saveContext()
    }
    
    // MARK: Delete task
    func deleteTaskModel(_ task: TaskModel) {
        viewContext.delete(task)
        saveContext()
    }
}
