//
//  AlertView.swift
//  NewsReaderApp
//
//  Created by Tushar on 10/03/26.
//

import UIKit

final class AlertViewManager {
    
    static func showAlert(
        on viewController: UIViewController,
        title: String,
        message: String,
        buttonTitle: String = "OK"
    ) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        let action = UIAlertAction(title: buttonTitle, style: .default)
        alert.addAction(action)
        viewController.present(alert, animated: true)
    }
}
