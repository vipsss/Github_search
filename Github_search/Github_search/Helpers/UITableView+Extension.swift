//
//  UITableView+Extension.swift
//  Github_search
//
//  Created by Mac User on 14.02.2023.
//

import Foundation
import UIKit

public extension UITableView {
    

    func registerCell(type: UITableViewCell.Type, identifier: String? = nil) {
        let cellId = String(describing: type)
        register(UINib(nibName: cellId, bundle: nil), forCellReuseIdentifier: identifier ?? cellId)
    }

    func dequeueCell<T: UITableViewCell>(withType type: UITableViewCell.Type, for indexPath: IndexPath) -> T? {
        return dequeueReusableCell(withIdentifier: type.identifier, for: indexPath) as? T
    }
    
}

public extension UITableViewCell {
    
    static var identifier: String {
        return String(describing: self)
    }
    
}
