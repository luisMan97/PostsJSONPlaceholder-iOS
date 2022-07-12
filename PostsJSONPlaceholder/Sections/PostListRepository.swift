//
//  PostListRepository.swift
//  PostsJSONPlaceholder
//
//  Created by Jorge Luis Rivera Ladino on 10/07/22.
//

import Foundation
import Combine

protocol PostListRepositoryProtocol {
    func getPosts() -> AnyPublisher<[PostViewModel], Error>
    func getFavoritePosts() -> AnyPublisher<[Post], Never>
    func deleteFavoritePosts(favoritePosts: [Post], offsets: IndexSet)
    func deleteAllPosts()
}

class PostListRepository: PostListRepositoryProtocol {

    private var remoteDataSource: RemotePostListDataSource
    private var localDataSource: LocalPostListDataSource

    init(remoteDataSource: RemotePostListDataSource,
         localDataSource: LocalPostListDataSource
    ) {
        self.remoteDataSource = remoteDataSource
        self.localDataSource = localDataSource
    }

    func getPosts() -> AnyPublisher<[PostViewModel], Error> {
        remoteDataSource.getPosts()
    }

    func getFavoritePosts() -> AnyPublisher<[Post], Never> {
        localDataSource.posts
            .eraseToAnyPublisher()
    }

    func deleteFavoritePosts(favoritePosts: [Post], offsets: IndexSet) {
        localDataSource.deleteFavoritePosts(favoritePosts: favoritePosts, offsets: offsets)
    }

    func deleteAllPosts() {
        localDataSource.deleteAllPosts()
    }

}
