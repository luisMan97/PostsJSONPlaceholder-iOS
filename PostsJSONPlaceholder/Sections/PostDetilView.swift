//
//  PostDetilView.swift
//  PostsJSONPlaceholder
//
//  Created by Jorge Luis Rivera Ladino on 7/07/22.
//

import SwiftUI
import CoreData

struct PostDetilView: View {

    var interactor: PostDetailInteractor
    @StateObject var presenter: PostDetailPresenter
    var post: PostViewModel

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 16) {
                Text(post.title)
                    .font(.title)
                    .foregroundColor(.primaryGreenColor)
                    .multilineTextAlignment(.center)
                postInformationView
                userView
                commentsView
            }
        }
        .padding()
        .alert(item: $presenter.error) {
            Alert(title: Text("Error"),
                  message: Text($0),
                  dismissButton: .default(Text("Ok"))
            )
        }
        .navigationBarTitle("Post")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem {
                Button(action: { interactor.savePost(post) }) {
                    let localPosts = presenter.favoritePosts.filter { $0.id == post.id }
                    Label("Add Item", systemImage: localPosts.isEmpty ? "star" : "star.fill")
                }
            }
        }.task {
            await interactor.getComments(postId: post.userId)
            await interactor.getUser(postId: post.userId)
        }
    }

    private var postInformationView: some View {
        HStack {
            VStack(alignment: .leading, spacing: 8) {
                Text("Description").font(.title2).bold()
                Text(post.body).font(.body)
            }

            Spacer()
        }
    }

    private var userView: some View {
        HStack {
            VStack(alignment: .leading, spacing: 8) {
                Text("User").font(.title2).bold()
                Text(presenter.user?.name ?? "")
                    .foregroundColor(.primaryGreenColor)
                HStack {
                    Image(systemName: "envelope.fill")
                        .foregroundColor(.primaryGreenColor)
                    Text(presenter.user?.email ?? "")
                }
                HStack {
                    Image(systemName: "phone.fill")
                        .foregroundColor(.primaryGreenColor)
                    Text(presenter.user?.phone ?? "")
                }
                HStack {
                    Image(systemName: "at.circle.fill")
                        .foregroundColor(.primaryGreenColor)
                    Text(presenter.user?.website ?? "")
                }
            }

            Spacer()
        }
    }

    private var commentsView: some View {
        VStack(spacing: 8) {
            Text("Comments").font(.title2).bold()
            //List {
            ForEach(presenter.comments) { comment in
                    VStack(alignment: .leading) {
                        NavigationLink {
                            VStack(spacing: 16) {
                                HStack {
                                    VStack(alignment: .leading, spacing: 8) {
                                        Text("Description").font(.title2).bold()
                                        Text(comment.body!)
                                    }
                                    Spacer()
                                }
                                userView
                                Spacer()
                            }.padding()
                        } label: {
                            Text(comment.body!)
                                .font(.body)
                                .foregroundColor(.black)
                                .multilineTextAlignment(.leading)
                        }
                        Divider()
                    }
                }
            //}.frame(height: (CGFloat(comments.count) * 50))
        }
    }
}


