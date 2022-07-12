//
//  Comment.swift
//  PostsJSONPlaceholder
//
//  Created by Jorge Luis Rivera Ladino on 10/07/22.
//

import Foundation

struct Comment: Decodable, Identifiable {
    let id: Int?
    let body: String?
}
