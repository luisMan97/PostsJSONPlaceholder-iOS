//
//  ContentView.swift
//  PostsJSONPlaceholder
//
//  Created by Jorge Luis Rivera Ladino on 7/07/22.
//

import SwiftUI
import CoreData

struct ContentView_Previews: PreviewProvider {

    init() {
        UINavigationBar().setup(backgroundColor: UIColor(named: "secondaryGreenColor") ?? .gray)
    }

    static var previews: some View {
        PostListFactory.getPostListView().environment(\.managedObjectContext, PersistenceController.preview.managedContext)
    }
}
