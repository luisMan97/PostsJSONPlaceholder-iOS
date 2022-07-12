//
//  LocalPostListDataSource.swift
//  PostsJSONPlaceholder
//
//  Created by Jorge Luis Rivera Ladino on 10/07/22.
//

import Foundation
import Combine

protocol LocalPostListDataSource {
    var posts: CurrentValueSubject<[Post], Never> { get }
    func deleteFavoritePosts(favoritePosts: [Post], offsets: IndexSet)
    func deleteAllPosts()
}
