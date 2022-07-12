//
//  VisualEffectView.swift
//  PostsJSONPlaceholder
//
//  Created by Jorge Luis Rivera Ladino on 11/07/22.
//

import SwiftUI

struct VisualEffectView: UIViewRepresentable {

    var effect: UIVisualEffect?

    func makeUIView(context: UIViewRepresentableContext<Self>) -> UIVisualEffectView {
        UIVisualEffectView()
    }

    func updateUIView(_ uiView: UIVisualEffectView, context: UIViewRepresentableContext<Self>) {
        uiView.effect = effect
    }

}

