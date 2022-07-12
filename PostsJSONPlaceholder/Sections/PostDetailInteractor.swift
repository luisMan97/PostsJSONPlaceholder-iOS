//
//  PostDetailInteractor.swift
//  PostsJSONPlaceholder
//
//  Created by Jorge Luis Rivera Ladino on 11/07/22.
//

import Combine


class PostDetailInteractor {

    // MARK: - Private Properties

    var repository: PostDetailRepositoryProtocol
    var presenter: PostDetailPresenter

    // MARK: - Private Properties

    private var subscriptions: Set<AnyCancellable> = []

    // MARK: - Initializers

    init(repository: PostDetailRepositoryProtocol, presenter: PostDetailPresenter) {
        self.repository = repository
        self.presenter = presenter
        getFavoritePosts()
    }

    // MARK: - Internal Methods

    @MainActor
    func getUser(postId: Int) async {
        do {
            presenter.user = try await repository.getUser(postId: postId)
        } catch {
            presenter.error = error.localizedDescription
        }
    }

    @MainActor
    func getComments(postId: Int) async {
        do {
            presenter.comments = try await repository.getComments(postId: postId)
        } catch {
            presenter.error = error.localizedDescription
        }
    }

    // MARK: - Internal Methods


    func savePost(_ post: PostViewModel) {
        repository.savePost(post)
    }

    private func getFavoritePosts() {
        repository.posts
            .sink { [weak self] favoritePosts in
                self?.presenter.favoritePosts = favoritePosts
        }.store(in: &subscriptions)
    }

}
