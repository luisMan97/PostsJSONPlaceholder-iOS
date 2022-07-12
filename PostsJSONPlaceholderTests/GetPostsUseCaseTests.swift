//
//  GetPostsUseCaseTests.swift
//  PostsJSONPlaceholderTests
//
//  Created by Jorge Luis Rivera Ladino on 12/07/22.
//

import XCTest
import Combine
@testable import PostsJSONPlaceholder

class GetPostsUseCaseTests: XCTestCase {

    private var repositoryMock = PostListRepositoryMock()
    private lazy var getPostsUseCaseTests: GetPostsUseCase = {
        let getPostsUseCaseTests = GetPostsUseCase(repository: repositoryMock)
        XCTAssertNotNil(getPostsUseCaseTests)
        return getPostsUseCaseTests
    }()

    func testGetPosts() {
        let expectedValues: [PostViewModel] = [
            .init(postResponse: .init(userId: 1023, id: 01, title: "SwiftUI Clean", body: "the SwitfUI Clean Architecture"))
        ]
        var recievedValues: [PostViewModel] = []

        let exp = expectation(description: "expected values")

        let cancelable = getPostsUseCaseTests.invoke()
            .sink(receiveCompletion: { (subscriptionCompletion: Subscribers.Completion<Error>) in

            }, receiveValue: { (value) in
                recievedValues = value
                if recievedValues == expectedValues {
                    exp.fulfill()
                }
            })

        repositoryMock.postsSub.send([.init(postResponse: .init(userId: 1023, id: 01, title: "SwiftUI Clean", body: "the SwitfUI Clean Architecture"))])
        wait(for: [exp], timeout: 1)
        XCTAssertNotNil(cancelable)
    }

}
