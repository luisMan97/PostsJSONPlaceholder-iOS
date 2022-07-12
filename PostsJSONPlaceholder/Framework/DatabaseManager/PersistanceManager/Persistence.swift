//
//  Persistence.swift
//  PostsJSONPlaceholder
//
//  Created by Jorge Luis Rivera Ladino on 7/07/22.
//

import CoreData
import UIKit

struct PersistenceController {

    static let shared = PersistenceController()

    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.managedContext
        for i in 0..<10 {
            let post = Post(context: viewContext)
            post.title = "Post title \(i)"
            post.body = "Post Description \(i)"
        }
        result.saveContext()
        return result
    }()

    var managedContext: NSManagedObjectContext {
        container.viewContext
    }

    private let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "PostsJSONPlaceholder")
        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }
        container.viewContext.automaticallyMergesChangesFromParent = true
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                /*
                Typical reasons for an error here include:
                * The parent directory does not exist, cannot be created, or disallows writing.
                * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                * The device is out of space.
                * The store could not be migrated to the current model version.
                Check the error message to determine what the actual problem was.
                */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        saveAutomatically()
    }

    private func saveAutomatically() {
        let center = NotificationCenter.default
        let notification = UIApplication.willResignActiveNotification

        center.addObserver(forName: notification, object: nil, queue: nil) { _ in
            self.saveContext()
        }
    }

    // MARK: - Core Data Saving support

    func saveContext() {
        guard managedContext.hasChanges else {
            return
        }

        do {
            try managedContext.save()
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }

}
