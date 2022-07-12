//
//  PostDetailRepositoryMock.swift
//  PostsJSONPlaceholderTests
//
//  Created by Jorge Luis Rivera Ladino on 12/07/22.
//

import Foundation
import Combine
@testable import PostsJSONPlaceholder

class PostDetailRepositoryMock: PostDetailRepositoryProtocol {

    var posts = CurrentValueSubject<[Post], Never>([])

    func getUser(postId: Int) async throws -> User {
        return .init(id: 1023020, name: "Jorge", email: "riveraladinojorgeluis@gmail.com", phone: "3222464569", website: "luisman97")
    }

    func getComments(postId: Int) async throws -> [Comment] {
        return [.init(id: 01, body: "The best clean code guide")]
    }

    func savePost(_ post: PostViewModel) { }

}
