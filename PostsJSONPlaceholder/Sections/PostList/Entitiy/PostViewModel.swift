//
//  PostViewModel.swift
//  PostsJSONPlaceholder
//
//  Created by Jorge Luis Rivera Ladino on 10/07/22.
//

import Foundation

struct PostViewModel: Identifiable {

    let postResponse: PostResponse

    init(postResponse: PostResponse) {
        self.postResponse = postResponse
    }

    var userId: Int { postResponse.userId ?? -1 }
    var id: Int { postResponse.id ?? -1 }
    var title: String { postResponse.title ?? "" }
    var body: String { postResponse.body ?? "" }

    private var idInt16: Int16 { Int16(id) }
    private var userIdInt16: Int16 { Int16(userId) }
}

extension PostViewModel {

    func toCoreDataModel(_ post: Post) {
        post.id = idInt16
        post.userId = userIdInt16
        post.body = body
        post.title = title
    }
}

