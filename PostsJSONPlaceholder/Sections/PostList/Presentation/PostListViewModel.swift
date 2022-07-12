//
//  PostListViewModel.swift
//  PostsJSONPlaceholder
//
//  Created by Jorge Luis Rivera Ladino on 10/07/22.
//

import Foundation
import CoreData
import Combine
import SwiftUI

class PostListViewModel: ObservableObject {

    // MARK: - Internal Output Events Properties

    @Published var showProgress = false
    @Published var posts: [PostViewModel] = []
    @Published var error: String?
    @Published var favoritePosts: [Post] = []
    @Published var favoritePostsViewModel: [PostViewModel] = []

    var progressTitle = ""

    // MARK: - Private Properties

    private var subscriptions: Set<AnyCancellable> = []
    // Interactor
    private var getPostListUseCase: GetPostsUseCase
    private var deleteFavoritePostsUseCase: DeleteFavoritePostsUseCase
    private var getFavoritePostsUseCase: GetFavoritePostsUseCase
    private var deleteAllPostsUseCase: DeleteAllPostsUseCase

    // MARK: - Initializers

    init(getPostListUseCase: GetPostsUseCase,
         deleteFavoritePostsUseCase: DeleteFavoritePostsUseCase,
         getFavoritePostsUseCase: GetFavoritePostsUseCase,
         deleteAllPostsUseCase: DeleteAllPostsUseCase) {
        self.getPostListUseCase = getPostListUseCase
        self.deleteFavoritePostsUseCase = deleteFavoritePostsUseCase
        self.getFavoritePostsUseCase = getFavoritePostsUseCase
        self.deleteAllPostsUseCase = deleteAllPostsUseCase
        getFavoritePosts()
    }

    // MARK: - Internal Methods

    func getPosts() {
        progressTitle = "Cargando usuarios..."
        showProgress = true

        getPostListUseCase.invoke()
            .sink(receiveCompletion: { [weak self] subscriptionCompletion in
                guard let self = self else { return }
                if case let .failure(error) = subscriptionCompletion {
                    self.error = error.localizedDescription
                }

                self.showProgress = false
            }, receiveValue: { [weak self] value in
                guard let self = self else { return }
                let favoritePostsIds = self.favoritePosts.map { Int($0.id) }
                self.posts = value.filter( { favoritePostsIds.contains($0.id) } )
                self.posts.append(contentsOf: value.filter( { !favoritePostsIds.contains($0.id) } ))
            })
            .store(in: &subscriptions)
    }

    func deleteFavoritePosts(offsets: IndexSet) {
        deleteFavoritePostsUseCase.invoke(favoritePosts: favoritePosts, offsets: offsets)
    }

    func deleteAllPosts() {
        deleteAllPostsUseCase.invoke()
        getPosts()
    }

    // MARK: - Private Methods

    private func getFavoritePosts() {
        getFavoritePostsUseCase.invoke()
            .sink { [weak self] favoritePosts in
                self?.favoritePosts = favoritePosts
                self?.favoritePostsViewModel = favoritePosts.map { $0.toViewModel() }
        }.store(in: &subscriptions)
    }

}
