//
//  RemotePostListDataSource.swift
//  PostsJSONPlaceholder
//
//  Created by Jorge Luis Rivera Ladino on 10/07/22.
//

import Combine

protocol RemotePostListDataSource {
    func getPosts() -> AnyPublisher<[PostViewModel], Error>
}
