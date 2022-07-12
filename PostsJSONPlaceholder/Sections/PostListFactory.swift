//
//  PostListFactory.swift
//  PostsJSONPlaceholder
//
//  Created by Jorge Luis Rivera Ladino on 10/07/22.
//

import Foundation

enum PostListFactory {

    static func getPostListView() -> PostListView {
        // DataSource
        let remoteDataSource = PostsListsURLSessionDataSource()
        let localDataSource = PostListCoreDataDataSource()
        // Repository
        let repository = PostListRepository(remoteDataSource: remoteDataSource,
                                            localDataSource: localDataSource)
        // Interactor
        let getPostListUseCase = GetPostsUseCase(repository: repository)
        let deleteFavoritePostsUseCase = DeleteFavoritePostsUseCase(repository: repository)
        let getFavoritePostsUseCase = GetFavoritePostsUseCase(repository: repository)
        let deleteAllPostsUseCase = DeleteAllPostsUseCase(repository: repository)
        // ViewModel
        let viewModel = PostListViewModel(getPostListUseCase: getPostListUseCase,
                                          deleteFavoritePostsUseCase: deleteFavoritePostsUseCase,
                                          getFavoritePostsUseCase: getFavoritePostsUseCase,
                                          deleteAllPostsUseCase: deleteAllPostsUseCase)
        return PostListView(viewModel: viewModel)
    }

}
