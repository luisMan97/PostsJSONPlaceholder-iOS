//
//  PostsListsURLSessionDataSource.swift
//  PostsJSONPlaceholder
//
//  Created by Jorge Luis Rivera Ladino on 10/07/22.
//

import Combine

class PostsListsURLSessionDataSource: RemotePostListDataSource {

    func getPosts() -> AnyPublisher<[PostViewModel], Error> {
        getPostsPublisher()
            .map(mapResponseToDomain)
            .eraseToAnyPublisher()
    }
    
}

private extension PostsListsURLSessionDataSource {

    func getPostsPublisher() -> AnyPublisher<[PostResponse], Error> {
        APIManager.request(service: .Posts)
    }

    func mapResponseToDomain(_ serverResponse: [PostResponse]) -> [PostViewModel] {
        serverResponse.map {
            $0.toDomain()
        }
    }
}
