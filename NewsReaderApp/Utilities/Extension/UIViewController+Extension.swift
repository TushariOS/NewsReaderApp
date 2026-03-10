//
//  Untitled.swift
//  NewsReaderApp
//
//  Created by Tushar on 10/03/26.
//
import UIKit

extension UIViewController {
    
    func showAlert(title: String, message: String) {
        
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        
        present(alert, animated: true)
    }
}
