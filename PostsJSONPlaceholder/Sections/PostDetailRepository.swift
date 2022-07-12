//
//  PostDetailRepository.swift
//  PostsJSONPlaceholder
//
//  Created by Jorge Luis Rivera Ladino on 11/07/22.
//

import Combine
import CoreData

protocol PostDetailRepositoryProtocol {
    var posts: CurrentValueSubject<[Post], Never> { get }
    func getUser(postId: Int) async throws -> User
    func getComments(postId: Int) async throws -> [Comment]
    func savePost(_ post: PostViewModel)
}

class PostDetailRepository: NSObject, PostDetailRepositoryProtocol {

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

    override init() {
        super.init()
        postFetchController.delegate = self
        getFavoritePosts()
    }

    // MARK: - Internal Methods

    func getUser(postId: Int) async throws -> User {
        let parameters = ["postId": postId] as [String: AnyObject]
        return try await APIManager.request(service: .User(parameters)).async()
    }

    func getComments(postId: Int) async throws -> [Comment] {
        let parameters = ["postId": postId] as [String: AnyObject]
        return try await APIManager.asyncRequest(service: .Comments(parameters))
    }

    func savePost(_ post: PostViewModel) {
        let localPosts = getPosts().filter { $0.id == post.id }
        guard localPosts.isEmpty else {
            deletePost(post)
            return
        }
        let newItem = Post(context: viewContext)
        post.toCoreDataModel(newItem)

        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }

    // MARK: - Private Methods

    private func deletePost(_ post: PostViewModel) {
        let fetchRequest: NSFetchRequest<Post> = Post.fetchRequest()

        do {
            let posts = try viewContext.fetch(fetchRequest)

            guard let postToDelete = posts.first(where: { $0.id == post.id }) else {
                return
            }
            viewContext.delete(postToDelete)
            try viewContext.save()
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }

    private func getFavoritePosts() {
        do {
            try postFetchController.performFetch()
            posts.value = postFetchController.fetchedObjects ?? []
        } catch {
            NSLog(error.localizedDescription)
        }
    }

    private func getPosts() -> [Post] {
        let fetchRequest: NSFetchRequest<Post> = Post.fetchRequest()

        do {
            let posts = try viewContext.fetch(fetchRequest)

            return posts
        } catch {
            let nsError = error as NSError
            print("Unresolved error \(nsError), \(nsError.userInfo)")
            return []
        }
    }

}

// MARK: - NSFetchedResultsControllerDelegate
extension PostDetailRepository: NSFetchedResultsControllerDelegate {

    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        guard let posts = controller.fetchedObjects as? [Post] else {
            return
        }
        print("Context has changed, reloading courses")
        self.posts.value = posts
    }

}
