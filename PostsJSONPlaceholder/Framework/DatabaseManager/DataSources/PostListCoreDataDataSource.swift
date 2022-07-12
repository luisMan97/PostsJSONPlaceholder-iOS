//
//  PostListCoreDataDataSource.swift
//  PostsJSONPlaceholder
//
//  Created by Jorge Luis Rivera Ladino on 10/07/22.
//

import Combine
import CoreData

class PostListCoreDataDataSource: NSObject, LocalPostListDataSource {

    // MARK: - Internal Properties

    var posts = CurrentValueSubject<[Post], Never>([])

    // MARK: - Private Properties

    private var viewContext = PersistenceController.shared.managedContext
    private var fetchRequest: NSFetchRequest<Post> = {
        let fetchRequest: NSFetchRequest<Post> = Post.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        return fetchRequest
    }()
    private lazy var postFetchController: NSFetchedResultsController<Post> = {
        let postFetchController = NSFetchedResultsController(fetchRequest: fetchRequest,
                                                             managedObjectContext: viewContext,
                                                             sectionNameKeyPath: nil,
                                                             cacheName: nil)
        return postFetchController
    }()

    // MARK: - Initializers

    override init() {
        super.init()
        postFetchController.delegate = self
        getFavoritePosts()
    }

    // MARK: - Internal Methods

    func deleteFavoritePosts(favoritePosts: [Post], offsets: IndexSet) {
        offsets.map { favoritePosts[$0] }.forEach(viewContext.delete)
        saveContext()
    }

    func deleteAllPosts() {
        let fetchRequest: NSFetchRequest<Post> = Post.fetchRequest()

        do {
            let posts = try viewContext.fetch(fetchRequest)

            posts.forEach(viewContext.delete)
            try viewContext.save()
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }


    // MARK: - Private Methods

    private func getFavoritePosts() {
        do {
            try postFetchController.performFetch()
            posts.value = postFetchController.fetchedObjects ?? []
        } catch {
            NSLog(error.localizedDescription)
        }
    }

    private func saveContext() {
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }

}

// MARK: - NSFetchedResultsControllerDelegate
extension PostListCoreDataDataSource: NSFetchedResultsControllerDelegate {

    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        guard let posts = controller.fetchedObjects as? [Post] else {
            return
        }
        print("Context has changed, reloading courses")
        self.posts.value = posts
    }
}
