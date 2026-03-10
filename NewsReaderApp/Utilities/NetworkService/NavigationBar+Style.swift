//
//  NavigationBar+Style.swift
//  NewsReaderApp
//
//  Created by Tushar on 09/03/26.
//

import UIKit

extension UINavigationController {

    func applyBlueNavigationBar(color: UIColor = .gray, titleColor: UIColor = .white, title: String? = nil) {
        navigationBar.titleTextAttributes = [.foregroundColor: titleColor]
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = color
        appearance.titleTextAttributes = [
            .foregroundColor: UIColor.black
        ]

        navigationBar.standardAppearance = appearance
        navigationBar.scrollEdgeAppearance = appearance
        navigationBar.compactAppearance = appearance
    }
}
