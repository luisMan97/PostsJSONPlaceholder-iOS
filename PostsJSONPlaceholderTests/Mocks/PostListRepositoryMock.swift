//
//  PostListRepositoryMock.swift
//  PostsJSONPlaceholderTests
//
//  Created by Jorge Luis Rivera Ladino on 12/07/22.
//

import Combine
import Foundation
@testable import PostsJSONPlaceholder

class PostListRepositoryMock: PostListRepositoryProtocol {

    let postsSub = PassthroughSubject<[PostViewModel], Error>()
    let favoritePostsSub = PassthroughSubject<[Post], Never>()

    func getPosts() -> AnyPublisher<[PostViewModel], Error> {
        postsSub.eraseToAnyPublisher()
    }

    func getFavoritePosts() -> AnyPublisher<[Post], Never> {
        favoritePostsSub.eraseToAnyPublisher()
    }

    func deleteFavoritePosts(favoritePosts: [Post], offsets: IndexSet) { }

    func deleteAllPosts() { }

}
