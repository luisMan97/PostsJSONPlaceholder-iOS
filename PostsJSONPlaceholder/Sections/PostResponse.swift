//
//  PostResponse.swift
//  PostsJSONPlaceholder
//
//  Created by Jorge Luis Rivera Ladino on 10/07/22.
//

import Foundation

struct PostResponse: Decodable, Identifiable {
    let userId: Int?
    let id: Int?
    let title: String?
    let body: String?
}

extension PostResponse {

    func toDomain() -> PostViewModel {
        .init(postResponse: self)
    }

}
