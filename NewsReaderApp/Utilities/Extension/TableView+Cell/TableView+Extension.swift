//
//  TableView+Cell.swift
//  NewsReaderApp
//
//  Created by Tushar on 08/03/26.
//

import UIKit

extension UITableView {
    
    func registerCell<T: UITableViewCell>(cell: T.Type) {
        let identifier = String(describing: cell.self)
        let nib = UINib(nibName: identifier, bundle: nil)
        register(nib, forCellReuseIdentifier: identifier)
    }
    
    
    func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath, cell: T.Type) -> T {
        let identifier = String(describing: T.self)
        guard let cell = dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? T else {
            fatalError("Cell \(identifier) not found")
        }
        return cell
    }
}
