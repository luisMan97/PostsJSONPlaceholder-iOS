//
//  DeleteFavoritePostsUseCase.swift
//  PostsJSONPlaceholder
//
//  Created by Jorge Luis Rivera Ladino on 10/07/22.
//

import Foundation

class DeleteFavoritePostsUseCase {

    // Repository
    private var repository: PostListRepositoryProtocol

    // MARK: - Initializers

    init(repository: PostListRepositoryProtocol) {
        self.repository = repository
    }

    // MARK: - Internal Methods

    func invoke(favoritePosts: [Post], offsets: IndexSet) {
        repository.deleteFavoritePosts(favoritePosts: favoritePosts, offsets: offsets)
    }

}

