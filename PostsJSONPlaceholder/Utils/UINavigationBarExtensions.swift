//
//  UINavigationBarExtensions.swift
//  PostsJSONPlaceholder
//
//  Created by Jorge Luis Rivera Ladino on 11/07/22.
//

import UIKit

extension UINavigationBar {

    func setup(backgroundColor: UIColor) {
        let apperance = UINavigationBar.appearance()
        let standardAppearance = UINavigationBarAppearance().setup(backgroundColor: backgroundColor)

        apperance.tintColor = .white

        apperance.standardAppearance = standardAppearance
        apperance.compactAppearance = standardAppearance
        apperance.scrollEdgeAppearance = standardAppearance
    }

}
