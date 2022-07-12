//
//  PostsJSONPlaceholderApp.swift
//  PostsJSONPlaceholder
//
//  Created by Jorge Luis Rivera Ladino on 7/07/22.
//

import SwiftUI

@main
struct PostsJSONPlaceholderApp: App {
    let persistenceController = PersistenceController.shared

    init() {
        UINavigationBar().setup(backgroundColor: UIColor(named: "secondaryGreenColor") ?? .gray)
    }

    var body: some Scene {
        WindowGroup {
            PostListFactory.getPostListView()
                .environment(\.managedObjectContext, persistenceController.managedContext)
        }
    }
}
