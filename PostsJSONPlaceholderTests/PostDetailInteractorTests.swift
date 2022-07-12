//
//  PostDetailInteractorTests.swift
//  PostsJSONPlaceholderTests
//
//  Created by Jorge Luis Rivera Ladino on 12/07/22.
//

import XCTest
@testable import PostsJSONPlaceholder

class PostDetailInteractorTests: XCTestCase {

    private var repositoryMock = PostDetailRepositoryMock()
    private var presenter = PostDetailPresenter()
    private lazy var postDetailInteractor: PostDetailInteractor = {
        let postDetailInteractor = PostDetailInteractor(repository: repositoryMock, presenter: presenter)
        XCTAssertNotNil(postDetailInteractor)
        return postDetailInteractor
    }()

    func testGetUser() async {
        let expectedValues = User(id: 1023020, name: "Jorge", email: "riveraladinojorgeluis@gmail.com", phone: "3222464569", website: "luisman97")
        await postDetailInteractor.getUser(postId: 01)
        XCTAssertEqual(presenter.user, expectedValues)
    }

    func testGetComments() async {
        let expectedValues = [Comment(id: 01, body: "The best clean code guide")]
        await postDetailInteractor.getComments(postId: 01)
        XCTAssertEqual(presenter.comments, expectedValues)
    }

}
