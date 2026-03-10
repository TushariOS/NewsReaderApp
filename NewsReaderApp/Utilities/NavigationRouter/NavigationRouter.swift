//
//  NavigationRouter.swift
//  NewsReaderApp
//
//  Created by Tushar on 09/03/26.
//

import UIKit

final class NavigationRouter {

    static func push<T: UIViewController>(
        from source: UIViewController,
        storyboard: String = "Main",
        identifier: String,
        configure: ((T) -> Void)? = nil
    ) {

        let storyboard = UIStoryboard(name: storyboard, bundle: nil)

        guard let vc = storyboard.instantiateViewController(withIdentifier: identifier) as? T else {
            return
        }

        configure?(vc)

        source.navigationController?.pushViewController(vc, animated: true)
    }
}
