//
//  PostCoreData.swift
//  PostsJSONPlaceholder
//
//  Created by Jorge Luis Rivera Ladino on 12/07/22.
//

import Foundation

extension Post {

    func toViewModel() -> PostViewModel {
        .init(postResponse: .init(userId: Int(userId), id: Int(id), title: title, body: body))
    }
}
