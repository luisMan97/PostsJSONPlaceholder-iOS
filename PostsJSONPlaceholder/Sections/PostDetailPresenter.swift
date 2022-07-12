//
//  PostDetailPresenter.swift
//  PostsJSONPlaceholder
//
//  Created by Jorge Luis Rivera Ladino on 11/07/22.
//

import SwiftUI

class PostDetailPresenter: ObservableObject {

    @Published var user: User?
    @Published var comments: [Comment] = []
    @Published var error: String?
    @Published var favoritePosts: [Post] = []

}
