//
//  PostListView.swift
//  PostsJSONPlaceholder
//
//  Created by Jorge Luis Rivera Ladino on 7/07/22.
//

import SwiftUI

struct PostListView: View {

    // MARK: - ViewModel

    @StateObject var viewModel: PostListViewModel

    // MARK: - Private Properties

    @State private var editMode = EditMode.inactive
    private var showFavorites: Bool {
        selectorIndex == 1
    }
    @State private var selectorIndex = 0
    @State private var numbers = ["All", "Favorites"]

    // MARK: - Internal Properties

    var body: some View {
        NavigationView {
            LoadingView(isShowing: $viewModel.showProgress, text: viewModel.progressTitle) {
                VStack {
                    Picker(String(), selection: $selectorIndex.onChange(segmentedChanged)) {
                        ForEach(0 ..< numbers.count) { index in
                            Text(numbers[index])
                                .tag(index)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding(.top)

                    if showFavorites {
                        if viewModel.favoritePosts.isEmpty {
                            Text("No tienes favoritos guardados")
                                .font(.system(.title3, design: .rounded))
                                .multilineTextAlignment(.center)
                                .padding()
                        } else {
                            List {
                                ForEach(viewModel.favoritePostsViewModel) { post in
                                    NavigationLink {
                                        PostDetailFactory.getPostListView(postViewModel: post)
                                    } label: {
                                        Text(post.title)
                                    }
                                }.onDelete(perform: deleteItems)
                            }
                        }
                    } else {
                        List {
                            ForEach(viewModel.posts) { post in
                                NavigationLink {
                                    PostDetailFactory.getPostListView(postViewModel: post)
                                } label: {
                                    HStack {
                                        Image(systemName: viewModel.favoritePosts.filter( { $0.id == Int16(post.id) } ).isNotEmpty ? "star.fill" : "circle.fill")
                                            .foregroundColor(viewModel.favoritePosts.filter( { $0.id == Int16(post.id) } ).isNotEmpty ? .yellow : .blue)

                                        Text(post.title)
                                    }

                                }
                            }//.onDelete(perform: deleteItems)
                        }
                    }

                    Spacer()

                    if viewModel.favoritePosts.isNotEmpty {
                        Button(action: viewModel.deleteAllPosts, label: {
                            Text("Delete All Favorites")
                                .foregroundColor(.white)
                                .padding()
                        }).frame(width: UIScreen.main.bounds.width)
                            .background(Color.red)
                    }
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        rightButton
                    }
                }
                .alert(item: $viewModel.error) {
                    Alert(title: Text("Error"),
                          message: Text($0),
                          dismissButton: .default(Text("Ok"))
                    )
                }
                .environment(\.editMode, $editMode)
            }
            .onChange(of: viewModel.favoritePosts) { newValue in
                if editMode == .active && viewModel.favoritePosts.isEmpty {
                    viewModel.getPosts()
                    editMode = .inactive
                }
            }
            .onAppear {
                viewModel.getPosts()
            }.navigationBarTitle(showFavorites ? "Favorite Posts" : "Posts")
            .navigationBarTitleDisplayMode(.inline)
        }
    }

    // MARK: - Private Methods

    private func deleteItems(offsets: IndexSet) {
        withAnimation { viewModel.deleteFavoritePosts(offsets: offsets) }
    }

    private func segmentedChanged(to value: Int) {
        if value == 0 { editMode = .inactive }
    }

    private var rightButton: some View {
        return Group {
            if showFavorites {
                editButton
            } else {
                Button(action: viewModel.getPosts, label: {
                    Image(systemName: "arrow.clockwise")
                })
            }
        }
    }

    private var editButton: some View {
        return Group {
            switch editMode {
            case .inactive:
                if viewModel.favoritePosts.isEmpty {
                    EmptyView()
                } else {
                    EditButton()
                }
            case .active:
                EditButton()
            default:
                EmptyView()
            }
        }
    }

}
