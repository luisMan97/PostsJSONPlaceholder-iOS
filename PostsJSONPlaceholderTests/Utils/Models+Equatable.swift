//
//  Models+Equatable.swift
//  PostsJSONPlaceholderTests
//
//  Created by Jorge Luis Rivera Ladino on 12/07/22.
//

import Foundation
@testable import PostsJSONPlaceholder

// MARK: - PostViewModel Equatable
extension PostViewModel: Equatable {

    public static func == (lhs: PostViewModel, rhs: PostViewModel) -> Bool {
        lhs.id == rhs.id
        && lhs.userId == rhs.userId
        && lhs.body == rhs.body
        && lhs.title == rhs.title
    }

}

// MARK: - User Equatable
extension User: Equatable {

    public static func == (lhs: User, rhs: User) -> Bool {
        lhs.id == rhs.id
        && lhs.email == rhs.email
        && lhs.phone == rhs.phone
        && lhs.website == rhs.website
    }

}

// MARK: - Comment Equatable
extension Comment: Equatable {

    public static func == (lhs: Comment, rhs: Comment) -> Bool {
        lhs.id == rhs.id
        && lhs.body == rhs.body
    }

}
