//
//  PostDetailFactory.swift
//  PostsJSONPlaceholder
//
//  Created by Jorge Luis Rivera Ladino on 12/07/22.
//

import Foundation

enum PostDetailFactory {

    static func getPostListView(postViewModel: PostViewModel) -> PostDetilView {
        // presenter
        let presenter = PostDetailPresenter()
        // repository
        let repository = PostDetailRepository()
        // interactor
        let interactor = PostDetailInteractor(repository: repository,
                                              presenter: presenter)
        return PostDetilView(interactor: interactor, presenter: presenter, post: postViewModel)
    }

}
