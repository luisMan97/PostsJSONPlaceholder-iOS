//
//  GetFavoritePostsUseCaseTests.swift
//  PostsJSONPlaceholderTests
//
//  Created by Jorge Luis Rivera Ladino on 12/07/22.
//

import XCTest
import Combine
@testable import PostsJSONPlaceholder

class GetFavoritePostsUseCaseTests: XCTestCase {

    private var repositoryMock = PostListRepositoryMock()
    private lazy var getFavoritePostsUseCase: GetFavoritePostsUseCase = {
        let getFavoritePostsUseCase = GetFavoritePostsUseCase(repository: repositoryMock)
        XCTAssertNotNil(getFavoritePostsUseCase)
        return getFavoritePostsUseCase
    }()

    func testGetPosts() {
        let postViewModel = PostViewModel(postResponse: .init(userId: 1023, id: 01, title: "SwiftUI Clean", body: "the SwitfUI Clean Architecture"))
        let post = Post(context: PersistenceController.preview.managedContext)
        postViewModel.toCoreDataModel(post)
        let expectedValues: [Post] = [
            post
        ]
        var recievedValues: [Post] = []

        let exp = expectation(description: "expected values")

        let cancelable = getFavoritePostsUseCase.invoke()
            .sink(receiveCompletion: { (subscriptionCompletion: Subscribers.Completion<Never>) in

            }, receiveValue: { (value) in
                recievedValues = value
                if recievedValues == expectedValues {
                    exp.fulfill()
                }
            })

        repositoryMock.favoritePostsSub.send([post])
        wait(for: [exp], timeout: 1)
        XCTAssertNotNil(cancelable)
    }

}
