//
//  DeleteAllPostsUseCase.swift
//  PostsJSONPlaceholder
//
//  Created by Jorge Luis Rivera Ladino on 12/07/22.
//

import Foundation

class DeleteAllPostsUseCase {

    // Repository
    private var repository: PostListRepositoryProtocol

    // MARK: - Initializers

    init(repository: PostListRepositoryProtocol) {
        self.repository = repository
    }

    // MARK: - Internal Methods

    func invoke() {
        repository.deleteAllPosts()
    }

}
