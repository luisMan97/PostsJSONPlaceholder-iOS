//
//  GetFavoritePostsUseCase.swift
//  PostsJSONPlaceholder
//
//  Created by Jorge Luis Rivera Ladino on 10/07/22.
//

import Combine

class GetFavoritePostsUseCase {

    // Repository
    private var repository: PostListRepositoryProtocol

    // MARK: - Initializers

    init(repository: PostListRepositoryProtocol) {
        self.repository = repository
    }

    // MARK: - Internal Methods

    func invoke() -> AnyPublisher<[Post], Never> {
        repository.getFavoritePosts()
    }

}
