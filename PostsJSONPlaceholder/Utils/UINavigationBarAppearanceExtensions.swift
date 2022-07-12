//
//  UINavigationBarAppearanceExtensions.swift
//  PostsJSONPlaceholder
//
//  Created by Jorge Luis Rivera Ladino on 11/07/22.
//

import UIKit

extension UINavigationBarAppearance {

    func setup(backgroundColor: UIColor) -> UINavigationBarAppearance {

        let apperance = UINavigationBarAppearance()

        apperance.largeTitleTextAttributes = [
            .foregroundColor: UIColor.white
        ]
        apperance.titleTextAttributes = [
            .foregroundColor: UIColor.white
        ]

        apperance.backgroundColor = backgroundColor

        return apperance
    }

}
