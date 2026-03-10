//
//  LoaderManager.swift
//  NewsReaderApp
//
//  Created by Tushar on 10/03/26.
//

import UIKit

final class LoaderManager {
    
    static let shared = LoaderManager()
    
    private var loader = UIActivityIndicatorView(style: .large)
    private var backgroundView = UIView()
    
    private init() {}
    
    func showLoader(on view: UIView) {
        
        backgroundView.frame = view.bounds
        backgroundView.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        
        loader.center = view.center
        loader.startAnimating()
        
        backgroundView.addSubview(loader)
        view.addSubview(backgroundView)
    }
    
    func hideLoader() {
        loader.stopAnimating()
        backgroundView.removeFromSuperview()
    }
}
