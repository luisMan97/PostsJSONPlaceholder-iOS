//
//  User.swift
//  PostsJSONPlaceholder
//
//  Created by Jorge Luis Rivera Ladino on 10/07/22.
//

import Foundation

struct User: Decodable, Identifiable {
    let id: Int?
    let name: String?
    let email: String?
    let phone: String?
    let website: String?
}
